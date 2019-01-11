#!/bin/sh

upsdrvctl -u root start
upsd -u root
upsmon -D
