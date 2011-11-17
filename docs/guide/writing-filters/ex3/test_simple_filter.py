from filters.simple_filter import SimpleFilter

def test_simple_filter():
    f = SimpleFilter()
    assert f.process_text("hello!\n") == "This document has 7 characters"
