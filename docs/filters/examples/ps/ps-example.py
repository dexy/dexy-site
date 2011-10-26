import turtle

screen = turtle.Screen()
screen.setworldcoordinates(-11, -11, 11, 11)

turtle.mode('world')

turtle.hideturtle()
turtle.tracer(1000) # don't update image until the end

for i in range(12):
    turtle.circle(100)
    turtle.rt(30)

turtle.update() # now update the image

print screen.getcanvas().postscript()
