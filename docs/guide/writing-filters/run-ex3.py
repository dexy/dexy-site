import sys
sys.path.append("../docs/guide/writing-filters")
sys.path.append("../docs/guide/writing-filters/ex3")

from StringIO import StringIO
import json
import nose
import utils

script_output = {}
utils.run_example("ex3", script_output)

loader = nose.loader.TestLoader()
test = loader.loadTestsFromDir("../docs/guide/writing-filters/ex3")

config = nose.config.Config()
s = StringIO()
config.stream = s

result = nose.core.run(suite = test, config=config)
script_output['test-out'] = s.getvalue()
script_output['test-results'] = result

with open("dexy--script-output-ex3.json", "w") as f:
    json.dump(script_output, f, sort_keys=True, indent=4)
