#!/usr/bin/env bash
mkdir build
cd build

cp -r ../description.json ../data .

sed -i "s/%VERSION%/$GITHUB_REF_NAME/" description.json

files=("data/catnames_male_en.txt" "data/catnames_female_en.txt" "data/catnames_neutral_en.txt")

for file in "${files[@]}"; do
	if [[ -f "$file" ]]; then
		echo "Processing $file..."
		# - grep -v "^#" : removes lines starting with #
		# - grep -v "^$" : removes empty lines
		# - sort         : sorts the remaining lines alphabetically
		# The output is redirected to a temporary file, which then replaces the original.

		grep -v "^#" "$file" | grep -v "^$" | sort >"${file}.tmp" && mv "${file}.tmp" "$file"

		mv $file ${file}.append

		echo "$file has been updated."
	else
		echo "Warning: $file does not exist. Skipping."
	fi
done

cd ..
mv build nazwy_kotkow
zip -r nazwy_kotkow.zip nazwy_kotkow
