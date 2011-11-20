data = {
    "foo" : 7,
    "bar" : "apple"
}

template = "foo is %(foo)s, bar is %(bar)s"

print template % data
