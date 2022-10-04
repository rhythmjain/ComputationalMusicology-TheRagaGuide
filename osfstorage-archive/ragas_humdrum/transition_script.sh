for file in *.deg
do
	trans_prob=$(grep -v '\*' $file | grep -v '!!' | context -n 2 | sortcount -p | awk '{print $2"_"$3,$1}' | sort)
	printf "$file,$trans_prob\n"
done
