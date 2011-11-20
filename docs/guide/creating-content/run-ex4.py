import json
import sys

sys.path.append("../docs/guide/creating-content")
import utils

script_output = {}
utils.run_example("ex4", script_output)

with open("dexy--script-output-ex4.json", "w") as f:
    json.dump(script_output, f, sort_keys=True, indent=4)
