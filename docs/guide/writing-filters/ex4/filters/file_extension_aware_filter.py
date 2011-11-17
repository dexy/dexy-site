from dexy.dexy_filter import DexyFilter

class FileExtensionAwareFilter(DexyFilter):
    ALIASES = ['fileextension']
    INPUT_EXTENSIONS = ['.txt']
    OUTPUT_EXTENSIONS = ['.txt', '.html']

    def process_text(self, input_text):
        if self.artifact.ext == '.txt':
            return "This is a text file.\n\n%s" % input_text
        elif self.artifact.ext == '.html':
            return "<p>This is a HTML file.</p><br /><p>%s</p>" % input_text
        else:
            raise Exception("unexpected file extension %s" % self.artifact.ext)
