import turtle

screen = turtle.Screen()

turtle.mode('world')

turtle.hideturtle()
turtle.tracer(1000) # Don't render until the end...

for i in range(12):
    turtle.circle(50)
    turtle.rt(30)

turtle.update() # ...now render

print screen.getcanvas().postscript()
