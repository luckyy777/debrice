file=$(readlink -f "$1")
dir=${file%/*}
base="${file%.*}"
ext="${file##*.}"

cd "$dir" || exit 1

textype() { \
	command="xelatex"
	$command --output-directory="$dir" "$base" &&
	grep -qi addbibresource "$file" &&
	biber --input-directory "$dir" "$base" &&
	$command --output-directory="$dir" "$base" &&
	$command --output-directory="$dir" "$base"
}

case "$ext" in
	# Try to keep these cases in alphabetical order.
	[0-9]) preconv "$file" | refer -PS -e | groff -mandoc -T pdf > "$base".pdf ;;
	c) cc "$file" -o "$base" && "$base" ;;
	cpp) g++ "$file" -o "$base" && "$base" ;;
	cs) mcs "$file" && mono "$base".exe ;;
	go) go run "$file" ;;
	h) sudo make install ;;
	java) /usr/lib/jvm/java-11-openjdk/bin/javac -d classes "$file" && java -cp classes "${1%.*}" ;;
	m) octave "$file" ;;
	md)	if  [ -x "$(command -v lowdown)" ]; then
			lowdown -d nointem -e super "$file" -Tms | groff -mpdfmark -ms -kept > "$base".pdf
		elif [ -x "$(command -v groffdown)" ]; then
			groffdown -i "$file" | groff > "$base.pdf"
		else
			pandoc -t ms --highlight-style=kate -s -o "$base".pdf "$file"
		fi ; ;;
	mom) preconv "$file" | refer -PS -e | groff -mom -kept -T pdf > "$base".pdf ;;
	ms) preconv "$file" | refer -PS -e | groff -me -ms -kept -T pdf > "$base".pdf ;;
	org) emacs "$file" --batch -u "$USER" -f org-latex-export-to-pdf ;;
	py) python "$file" ;;
	[rR]md) Rscript -e "rmarkdown::render('$file', quiet=TRUE)" ;;
	rs) cargo build ;;
	sass) sassc -a "$file" "$base.css" ;;
	scad) openscad -o "$base".stl "$file" ;;
	sent) setsid -f sent "$file" 2>/dev/null ;;
	tex) textype "$file";;
	*) sed -n '/^#!/s/^#!//p; q' "$file" | xargs -r -I % "$file" ;;
esac

echo -e "\n words: $(cat "$file" | wc -w)"
lines_with_colour="$(cat $file | grep '\\color{' | wc -w)"
lines_without_colour="$(cat "$file" | grep --invert-match '\\' | wc -w)"
words_without_headings="$(($lines_with_colour + $lines_without_colour))"
echo -e "\n words without headings: $words_without_headings"
