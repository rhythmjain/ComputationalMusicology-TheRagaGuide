####alap data for us. will include time theory rules, as well as pitch transition probabilities.
echo "sa,re,lowered_re,ga,lowered_ga,ma,raised_ma,pa,da,lowered_da,ni,lowered_ni"
for file in *.degree
do
	total=$(grep '[1-7]' $file | wc -l)	
	sa=$(grep '1' $file |  wc -l)
	re=$(grep '2$' $file | grep -v '2-' | wc -l)
	lowered_re=$(grep '2-' $file |  wc -l)
	ga=$(grep '3'  $file | grep -v '3-' | wc -l)
	lowered_ga=$(grep '3-' $file | wc -l)
	ma=$(grep '4' $file | grep -v '4+' | wc -l )
	raised_ma=$(grep '4+' $file  | wc -l )
	pa=$(grep '5' $file | wc -l)
	da=$(grep '6' $file | grep -v '6-' | wc -l)
	lowered_da=$(grep '6-' $file | wc -l)
	ni=$(grep '7' $file | grep -v '7-' | wc -l)
	lowered_ni=$(grep '7-' $file | wc -l)

	sa_total=$(echo "scale=3 ; $sa / $total" | bc)
	re_total=$(echo "scale=3 ; $re / $total" | bc)
	lowered_re_total=$(echo "scale=3 ; $lowered_re / $total" | bc)
	ga_total=$(echo "scale=3 ; $ga / $total" | bc)
	lowered_ga_total=$(echo "scale=3 ; $lowered_ga / $total" | bc)
	ma_total=$(echo "scale=3 ; $ma / $total" | bc)
	raised_ma_total=$(echo "scale=3 ; $raised_ma / $total" | bc)
	pa_total=$(echo "scale=3 ; $pa / $total" | bc)
	da_total=$(echo "scale=3 ; $da / $total" | bc)
	lowered_da_total=$(echo "scale=3 ; $lowered_da / $total" | bc)
	ni_total=$(echo "scale=3 ; $ni / $total" | bc)
	lowered_ni_total=$(echo "scale=3 ; $lowered_ni / $total" | bc)
	printf "$file,$sa_total,$re_total,$lowered_re_total,$ga_total,$lowered_ga_total,$ma_total,$raised_ma_total,$pa_total,$da_total,$lowered_da_total,$ni_total,$lowered_ni_total\n" | sed 's/,,/,0,/g'
	# echo $((sa / total))

	# printf "$total\n"
done 
