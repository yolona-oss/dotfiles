#!/bin/bash
# image processing

get_img_resolution() {
	file "${*}" | grep -o -E ', [0-9]* *x *[0-9]*,' | sed 's/,//g' | sed 's/\ //g'
}
