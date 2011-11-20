from dexy.filters.templating_filters import JinjaFilter
from dexy.filters.templating_plugins import TemplatePlugin
import csv

class CsvPlugin(TemplatePlugin):
    def run(self):
        csv_files = {}
        for artifact_key, artifact in self.filter_instance.artifact.inputs().iteritems():
            f = open(artifact.filepath(), "r")
            csv_files[artifact.key] = csv.DictReader(f)
        return {'csv_rows' : csv_files}

class CsvInputTemplateFilter(JinjaFilter):
    ALIASES = ['csv']
    PLUGINS = [ CsvPlugin ]
