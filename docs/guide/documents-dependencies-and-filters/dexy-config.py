from StringIO import StringIO
from dexy.constants import Constants
from dexy.controller import Controller
from dexy.document import Document
import dexy.introspect
import logging
import os
import json
import sys

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

def print_controller_members(controller):
    s = StringIO()
    ### @export "print-controller-members"
    for document_key, document in controller.members.iteritems():
        s.write("%s : %s\n" % (document_key, document))
    ### @end
    text = s.getvalue()
    s.close()
    return text

def print_controller_docs(controller):
    s = StringIO()
    ### @export "print-controller-docs"
    for doc in controller.docs:
        s.write(doc.key())
        s.write("  inputs: %s\n" % repr([d.key() for d in doc.inputs]))
    ### @end
    text = s.getvalue()
    s.close()
    return text

def run_example(name, script_output, run=False):
    log, logstream = stream_logger("%s.log" % name)
    populate_filters_log, populate_filters_logstream= stream_logger("%s.populate.filters.log" % name)
    os.chdir(name)

    with divert_stdout() as stdout:
        ### @export "controller-config"
        controller = Controller(args)
        controller.log = log
        controller.load_config()
        controller.process_config()
        ### @end
        if run:
            for doc in controller.docs:
                doc.log = log
            ### @export "populate-filters"
            Document.filter_list = dexy.introspect.filters(populate_filters_log)
            ### @export "controller-run"
            controller.docs = [doc.run() for doc in controller.docs]
            ### @end
        script_output["%s-run" % name] = stdout.getvalue()

    os.chdir("..")

    script_output["%s-depends" % name] = repr(controller.depends)
    script_output["%s-docs" % name] = print_controller_docs(controller)
    script_output["%s-log" % name] = logstream.getvalue()
    script_output["%s-populate-filters" % name] = populate_filters_logstream.getvalue()
    script_output["%s-members" % name] = print_controller_members(controller)
    script_output["%s-ordering" % name] = repr(controller.ordering)
    script_output["%s-doc-logs" % name] = dict((doc.key(), doc.logstream.getvalue()) for doc in controller.docs)


args = {
    "artifactclass" : Constants.DEFAULT_ACLASS,
    "artifactsdir" : "../../../../artifacts",
    "config" : Constants.DEFAULT_CONFIG,
    "dbclass" : Constants.DEFAULT_DBCLASS,
    "dbfile" : None,
    "directory" : ".",
    "exclude" : "",
    "hashfunction" : 'md5',
    "logsdir" : Constants.DEFAULT_LDIR,
    "nocache" : True,
    "profmem" : False,
    "recurse" : True,
    'run' : "",
    "strictinherit" : True,
    "zzz" : False # delete me when finished
}

# We will use this to hold captured output:
script_output = {}

# About ready to start, need to chdir because dexy runs this from
# within artifacts/ dir. Remove this to run script directly.
os.chdir("../docs/guide/documents-dependencies-and-filters/")

run_example("ex1", script_output)
run_example("ex2", script_output)
run_example("ex2a", script_output)
run_example("ex3", script_output, True)
run_example("ex4", script_output, True)

# end of all scripts, save data in artifacts dir
os.chdir("../../../artifacts")

with open("dexy--script-output.json", "w") as f:
    json.dump(script_output, f, sort_keys=True, indent=4)
