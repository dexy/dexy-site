from dexy.dexy_filter import DexyFilter

class SimpleFilter(DexyFilter):
    ALIASES = ['simple']

    def process_text(self, input_text):
        return "This document has %s characters" % len(input_text)
