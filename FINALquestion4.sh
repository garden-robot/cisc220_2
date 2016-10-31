echo IP Address			Domain Name
for ((i=1; i<256; i++)); do
	for ((j=0; j<256; j++)); do
		lookup=$(nslookup 130.15.$i.$j | grep 'name = *' | cut -f 2 -d '=' )
		if [[ $lookup != ' ' && $lookup != '' ]]; then
			echo 130.15.$i.$j		$lookup
		fi
	done
done
