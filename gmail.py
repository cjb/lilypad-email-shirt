#!/usr/bin/python
# gmail.py
# Author:    Chris Ball <chris@printf.net>
# Function:  Use Gmail's RSS feed to find the number of unread e-mails,
#            and send the result out over a serial port.
# URL:       http://github.com/cjb/lilypad-email-tshirt/
# License:   GPLv2+ or later, at your option.

import sys, feedparser, serial, time
ser = serial.Serial('/dev/rfcomm0', 115200, timeout=1)

# Settings -- change these to match your account details
USERNAME="me@gmail.com"
PASSWORD="mypassword"
PROTO="https://"
SERVER="mail.google.com"
PATH="/gmail/feed/atom"

while True:
	newmails = int(feedparser.parse(PROTO + USERNAME + ":" + PASSWORD + "@" + SERVER + PATH)["feed"]["fullcount"])

	print "newmails: %s\n" % newmails
	ser.write(newmails)
	time.sleep(2)
