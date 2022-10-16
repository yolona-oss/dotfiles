#!/bin/bash
# printing colors

color_rows() {
        COLOR_SCRIPT_REPO="https://api.github.com/repos/stark/Color-Scripts/contents/color-scripts"
        wget -q -O - "$(curl -s $COLOR_SCRIPT_REPO | jq '.[] | "\(.path) \(.download_url)"' -r | shuf -n1 | cut -d " " -f2)" | bash
}

get256bashColors() {
	local c i j

	printf "Standard 16 colors\n"
	for ((c = 0; c < 17; c++)); do
		printf "|%s%3d%s" "$(tput setaf "$c")" "$c" "$(tput sgr0)"
	done
	printf "|\n\n"

	printf "Colors 16 to 231 for 256 colors\n"
	for ((c = 16, i = j = 0; c < 232; c++, i++)); do
		printf "|"
		((i > 5 && (i = 0, ++j))) && printf " |"
		((j > 5 && (j = 0, 1)))   && printf "\b \n|"
		printf "%s%3d%s" "$(tput setaf "$c")" "$c" "$(tput sgr0)"
	done
	printf "|\n\n"
	
	printf "Greyscale 232 to 255 for 256 colors\n"
	for ((; c < 256; c++)); do
		printf "|%s%3d%s" "$(tput setaf "$c")" "$c" "$(tput sgr0)"
	done
	printf "|\n"
}

get256bashColorsRow() {
	echo $(x=`tput op` y=`printf %76s`;for i in {0..256};do o=00$i;echo -e ${o:${#o}-3:3} `tput setaf $i;tput setab $i`${y// /=}$x;done)
}

get16bashColors() {
	colors=(black
		red
		green
		yellow
		blue
		magenta
		cyan
		white)

	columns=$(tput cols)
	sym='@' # 
	maxlen=2

	for (( i = 0; $i < 8; i++ )); do
		if (( ${#colors[$i]} > $maxlen)); then
			maxlen=${#colors[$i]}
		fi
	done
	n=$(( columns / ${#colors[@]} ))

	d=$(echo %${n}q)
	linelen=$((n*8))

	printrow() {
		print_spaces()
		{
			for x in $(seq ${1}); do printf " "; done
		}

		# centred
		for (( i = $1, j = 0; $i < $(($1+8)); i++, j++ )); do
			tput setaf $i
			spaces=$(( n / 2 - ${#colors[$j]} / 2 ))
			print_spaces ${spaces}
			printf "%q" ${colors[$j]}
			print_spaces $(( n - ( spaces + ${#colors[$j]} ) ))
		done

		printf "\n"
		for (( i = $1;  $i < $(($1+8)); i++ )); do
			tput setaf $i
			for (( j = 0; $j < $n; j++ )); do
				printf "$sym"
			done
		done
		printf "\n"
	}

	reg="Regular Colors"
	for (( i = 0; $i < $((linelen/2 - ${#reg}/2)); i++ )); do
		printf " "
	done
	printf "$reg\n"
	printrow 0
	bri="Bright Colors"
	for (( i = 0; $i < $((linelen/2 - ${#reg}/2)); i++ )); do
		printf " "
	done
	printf "$bri\n"
	printrow 8
}

