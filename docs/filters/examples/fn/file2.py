with open("dexy--data-file-1.txt", "r") as f:
    print "The existing file named dexy--data-file-1.txt contained:"
    print f.read()

with open("dexy--data-file-2.txt", "w") as f:
    f.write("2.718281828")
