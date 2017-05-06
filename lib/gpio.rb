require 'pi_piper'
include PiPiper

LIGHT = 4
BUTTON = 17

`rm gpio.lock`
pin = PiPiper::Pin.new(:pin => LIGHT, :direction => :out)

def flash pin, num, duration=0.5
  num.times do
    pin.off
    sleep duration
    pin.on
    sleep duration
    pin.off
  end
end

flash pin, 3

watch :pin => BUTTON do
  unless File.exists? "gpio.lock"
  	puts "Button Pressed"
  	`touch gpio.lock`
	flash pin, 1
	flash pin, 4, 0.25
	pin.on
	system("/home/pi/photobooth/capture.sh")
	p1 = fork { system("/home/pi/photobooth/upload.sh") }
	Process.detach(p1)
	pin.off
	`rm gpio.lock`
	puts "Ready!"
  end
end

PiPiper.wait
