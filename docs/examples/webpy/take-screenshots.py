### @export "imports"
from selenium import webdriver
import time

### @export "screencapture"
def screencapture(filename, delay=1):
    time.sleep(delay)
    browser.save_screenshot(filename)

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
