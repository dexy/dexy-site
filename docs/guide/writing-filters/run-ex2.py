import json
import sys

sys.path.append("../docs/guide/writing-filters")
import utils

script_output = {}
utils.run_example("ex2", script_output)

with open("dexy--script-output-ex2.json", "w") as f:
    json.dump(script_output, f, sort_keys=True, indent=4)
