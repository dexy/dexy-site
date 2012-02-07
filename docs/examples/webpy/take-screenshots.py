### @export "imports"
from selenium import webdriver
import time
from kaa import imlib2

### @export "constants"
WIDTH=850

### @export "screencapture"
def screencapture(filename, height=150, delay=1):
    time.sleep(delay)
    browser.save_screenshot(filename)
    crop_image(filename, WIDTH, height)

### @export "crop"
def crop_image(filename, region_width, region_height, x=0, y=0):
    image = imlib2.open(filename)
    image = image.crop((x, y), (region_width, region_height))
    image.save(filename)

### @export "start-browser"
browser = webdriver.Firefox() # Get local session of firefox

### @export "load-index-page"
browser.get("http://localhost:8080")
screencapture("dexy--index.png")
screencapture("dexy--index.pdf")

### @export "enter-text"
element = browser.find_element_by_name("title")
element.send_keys("Prepare Refresh Austin Talk demo")
screencapture("dexy--enter.png")
screencapture("dexy--enter.pdf")

### @export "add-todo"
browser.find_element_by_name("Add todo").click()
screencapture("dexy--add.png")
screencapture("dexy--add.pdf")

### @export "delete-todo"
browser.find_element_by_name("Delete todo").click()
screencapture("dexy--delete.png")
screencapture("dexy--delete.pdf")
