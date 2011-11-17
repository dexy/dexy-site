### @export "requires"
require 'rubygems'
require 'safariwatir'

### @export "constants"
IP_ADDRESS = ENV['EC2_INSTANCE_IP']
PORT = '8080'
BASE = "http://#{IP_ADDRESS}:#{PORT}/"

### @export "init-safari"
browser = Watir::Safari.new

### @export "def-screenshot"
def take_screenshotx(filename)
    sleep(1) # Make sure page is finished loading.
    `screencapture #{filename}`
    `convert -crop 800x500+0+0 #{filename} #{filename}`
end


### @export "def-ubuntu-screenshot"
def take_screenshot(filename)
    sleep(1) # Make sure page is finished loading.
    `gdm-screenshot #{filename}`
    `mv /var/run/gdm/greeter/GDM-Screenshot.png #{filename}`
end


### @export "goto-index"
browser.goto(BASE)
take_screenshot("dexy--index.png")

### @export "enter-text"
browser.text_field(:name, "title").set("Prepare Refresh Austin Talk Demo")
take_screenshot("dexy--enter.png")

### @export "add-todo"
browser.button(:name, "Add todo").click
raise unless browser.html.include?("<td>Prepare Refresh Austin Talk Demo</td>")
take_screenshot("dexy--add.png")

### @export "delete-todo"
browser.form(:index, 1).submit
take_screenshot("dexy--delete.png")

