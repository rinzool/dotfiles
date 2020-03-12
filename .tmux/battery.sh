#!/bin/bash
batteryvalue=$(upower -i $(upower -e | grep '/battery') | grep --color=never -E percentage|xargs|cut -d' ' -f2|sed s/%//)
echo "$batteryvalue%"
