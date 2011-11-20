from dexy.filters.templating_filters import JinjaFilter
from dexy.filters.templating_plugins import TemplatePlugin

class CalculationResultPlugin(TemplatePlugin):
    def run(self):
        return { 'foo' : [(x, 2*x) for x in range(0, 10)] }

class FunctionsPlugin(TemplatePlugin):
    def double(self, x):
        return 2*x

    def triple(self, x):
        return 3*x

    def run(self):
        return { 'double' : self.double, 'triple' : self.triple }

class TwoPluginsTemplateFilter(JinjaFilter):
    ALIASES = ['twoplugins']
    PLUGINS = [ CalculationResultPlugin, FunctionsPlugin ]
