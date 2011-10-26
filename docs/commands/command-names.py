from modargs import args
from ordereddict import OrderedDict
import dexy.commands
import json

commands_and_help = OrderedDict()
for cmd in args.available_commands(dexy.commands):
    help_text = args.help_text('dexy', dexy.commands, 'dexy', on=cmd)
    commands_and_help[cmd] = help_text

with open("dexy--commands.json", "w") as f:
    json.dump(commands_and_help, f)
