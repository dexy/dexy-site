from dexy.dexy_filter import DexyFilter
from ordereddict import OrderedDict # on Python 2.7 you can also use 'from collections import OrderedDict'

class SimpleSectionsFilter(DexyFilter):
    ALIASES = ['simplesections']

    def process_dict(self, input_dict):
        output_dict = OrderedDict()
        for section_name, section_text in input_dict.iteritems():
            output_dict[section_name] = "This section has %s characters" % len(section_text)
        return output_dict
