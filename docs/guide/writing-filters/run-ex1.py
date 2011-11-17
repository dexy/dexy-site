import json
import sys

sys.path.append("../docs/guide/writing-filters")
import utils

script_output = {}
utils.run_example("ex1", script_output)

with open("dexy--script-output-ex1.json", "w") as f:
    json.dump(script_output, f, sort_keys=True, indent=4)
