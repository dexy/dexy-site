from StringIO import StringIO
from dexy.artifact import Artifact
from dexy.dexy_filter import DexyFilter
from dexy.constants import Constants
from dexy.controller import Controller
from dexy.document import Document
import dexy.introspect
import logging
import os
import sys

args = {
    "artifactclass" : Constants.DEFAULT_ACLASS,
    "artifactsdir" : "../../../../artifacts",
    "config" : 'config.dexy',
    "dbclass" : Constants.DEFAULT_DBCLASS,
    "dbfile" : None,
    "directory" : ".",
    "disabletests" : False,
    "exclude" : "",
    "hashfunction" : 'md5',
    "logsdir" : Constants.DEFAULT_LDIR,
    "nocache" : True,
    "profmem" : False,
    "recurse" : True,
    "run" : "",
    "strictinherit" : True,
    "zzz" : False # delete me when finished
}

# Set up some functions for logging and capturing output.
class divert_stdout():
    def __enter__(self):
        self.old_stdout = sys.stdout
        self.my_stdout = StringIO()
        sys.stdout = self.my_stdout
        return self.my_stdout

    def __exit__(self, type, value, traceback):
        sys.stdout = self.old_stdout
        self.my_stdout.close()

def stream_logger(logname):
    logstream = StringIO()
    log = logging.getLogger(logname)
    log.setLevel(logging.DEBUG)
    log.propagate = 0
    handler = logging.StreamHandler(logstream)
    formatter = logging.Formatter(Constants.DEFAULT_LOGFORMAT)
    handler.setFormatter(formatter)
    log.addHandler(handler)
    return log, logstream

def run_example(name, script_output, run=False):
    os.chdir("../docs/guide/creating-content/")
    os.chdir(name)
    populate_filters_log, populate_filters_logstream = stream_logger("%s.populate.filters.log" % name)
    log, logstream = stream_logger("%s.log" % name)

    with divert_stdout() as stdout:
        Document.filter_list = dexy.introspect.filters(populate_filters_log)

        controller = Controller(args)
        controller.log = log
        controller.load_config()
        controller.process_config()

        for doc in controller.docs:
            doc.log = log

        controller.docs = [doc.run() for doc in controller.docs]
        script_output["%s-run" % name] = stdout.getvalue()
        script_output['docs'] = dict((doc.key(), doc.last_artifact.data_dict) for doc in controller.docs)
        print script_output['docs']

    script_output["%s-populate-filters" % name] = populate_filters_logstream.getvalue()
    script_output["%s-log" % name] = logstream.getvalue()
    os.chdir("..")
    os.chdir("../../../artifacts")
