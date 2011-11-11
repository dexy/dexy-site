import sys

for line in sys.stdin:
    line = line.strip()
    print "You said '%s', that took '%d' characters!" % (line, len(line))
