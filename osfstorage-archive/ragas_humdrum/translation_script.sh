#### translation script
###this translates raga encodings into an octave agnostic scale degrees.
####create loads of files to go through:
grep -l '\*k\[]' *.txt > no_accs
grep -l '\*k\[b-,e-]' *.txt > file_lists/bes_es
grep -l '\*k\[b-]' *.txt > file_lists/bes
grep -l '\*k\[b-,e-,a-]' *.txt > file_lists/bes_es_aes
grep -l '\*k\[b-,e-,a-,d-]' *.txt > file_lists/bes_es_aes_des
grep -l '\*k\[a-,d-]' *.txt > file_lists/aes_des
grep -l '\*k\[f#]' *.txt > file_lists/fis
grep -l '\*k\[a-,d-,f#]' *.txt > file_lists/aes_des_fis
grep -l '\*k\[f#,d-]' *.txt > file_lists/fis_des
grep -l '\*k\[e-]' *.txt > file_lists/es
grep -l '\*k\[e-,a-]' *.txt > file_lists/es_aes
grep -l '\*k\[d-,f#]' *.txt > file_lists/des_fis
grep -l '\*k\[e-,a-,#f]' *.txt > file_lists/es_aes_fis
grep -l '\*k\[b-,d-]' *.txt > file_lists/bes_des
grep -l '\*k\[e-,a-,d-]' *.txt > file_lists/es_aes_des
grep -l '\*k\[e-,f#]' *.txt > file_lists/es_fis
grep -l '\*k\[d-]' *.txt > file_lists/des
grep -l '\*k\[e-,a-,d-]' *.txt > file_lists/es_aes_bes
grep -l '\*k\[e-,a-,d-]' *.txt > file_lists/es_aes_des
grep -l '\*k\[e-,a-,b-]' *.txt > file_lists/es_aes_bes
grep -l '\*k\[a-,b-,f#]' *.txt > file_lists/aes_bes_fis
grep -l '\*k\[a-,d-,f#]' *.txt > file_lists/aes_des_fis
grep -l '\*k\[e-,a-,d-,f#]' *.txt > file_lists/es_aes_des_fis
#####NB: This script gets rid of all grace notes! 

##### this one is for if the key has no sharps and no flats.

for file in `cat file_lists/no_accs`
do	
	grep -v 'discrep' $file | grep -v 'linebreak' | sed 's/q.*q//g' | sed 's/[\/\.)(,]//g' | sed 's/-//g' | grep -v '^$' | sed 's/[sS].*/1/g' | 
	sed  's/[rR].*/2/g' | sed  's/[gG].*/3/g' | sed  's/[mM].*/4/g' | sed  's/[pP].*/5/g' |
	sed  's/[dD].*/6/g' | sed  's/[nN].*/7/g' | sed 's/b\([0-9]\)/\1-/g' | 
	sed 's/#\([0-9]\)/\1+/g' | sed 's/\([0-9]\)b/\1-/g' | sed 's/\([0-9]\)#/\1+/g' > $file.deg
done


for file1 in `cat file_lists/bes_es`		
do
grep -v 'discrep' $file1 | grep -v 'linebreak' | sed 's/q.*q//g' | sed 's/[\/\.)(,]//g' | sed 's/-//g' | grep -v '^$' | sed 's/[sS].*/1/g' | 
	sed  's/[rR].*/2/g' | sed  's/[gG]h.*/3/g' | sed 's/h[gG].*/3/g' |
	sed  's/#[gG].*/3+/g'| sed  's/[gG]#.*/3+/g' | sed  's/[gG].*/3-/g' | 
	sed  's/[mM].*/4/g' | sed  's/[pP].*/5/g' |
	sed  's/[dD].*/6/g' | sed  's/[nN]h.*/7/g' | sed 's/h[nN].*/7/g' |
	sed  's/#[nN].*/7+/g'| sed  's/[nN]#.*/7+/g' | sed  's/[nN].*/7-/g' |
	sed 's/b\([0-9]\)/\1-/g' | sed 's/#\([0-9]\)/\1+/g' | sed 's/\([0-9]\)b/\1-/g' | sed 's/\([0-9]\)#/\1+/g' > $file1.deg
done
  

for file2 in `cat file_lists/aes_des_fis`
do
grep -v 'discrep' $file2 | grep -v 'linebreak' | sed 's/q.*q//g' | sed 's/[\/\.)(,]//g' | sed 's/-//g' | grep -v '^$' | sed 's/[sS].*/1/g' | 
	sed  's/[rR].*/2/g' |  sed  's/[gG].*/3/g' |
	sed  's/[mM]h.*/4/g' | sed 's/h[mM].*/4/g' |
	sed  's/b[mM].*/4-/g'| sed  's/[mM]b.*/4-/g' | sed  's/[mM].*/4+/g' | 
	sed  's/[pP].*/5/g' | sed  's/[dD]h.*/6/g' | sed 's/h[dD].*/6/g' |
	sed  's/#[dD].*/6+/g'| sed  's/[dD]#.*/6+/g' | sed  's/[dD].*/6-/g' |  
	sed  's/[nN]h.*/7/g' | sed 's/h[nN].*/7/g' |
	sed  's/#[nN].*/7+/g'| sed  's/[nN]#.*/7+/g' | sed  's/[nN].*/7-/g' |
	sed 's/b\([0-9]\)/\1-/g' | sed 's/#\([0-9]\)/\1+/g' | sed 's/\([0-9]\)b/\1-/g' | sed 's/\([0-9]\)#/\1+/g' > $file2.deg
done

for file3 in `cat file_lists/bes`		
do	
	grep -v 'discrep' $file3 | grep -v 'linebreak' | sed 's/q.*q//g' | sed 's/[\/\.)(,]//g' | sed 's/-//g' | grep -v '^$' | sed 's/[sS].*/1/g' | 
	sed  's/[rR].*/2/g' | sed  's/[gG].*/3/g' | sed  's/[mM].*/4/g' | sed  's/[pP].*/5/g' |
	sed  's/[dD].*/6/g' | 	sed  's/[nN]h.*/7/g' | sed 's/h[nN].*/7/g' |
	sed  's/#[nN].*/7+/g'| sed  's/[nN]#.*/7+/g' | sed  's/[nN].*/7-/g' | sed 's/b\([0-9]\)/\1-/g' | 
	sed 's/#\([0-9]\)/\1+/g' | sed 's/\([0-9]\)b/\1-/g' | sed 's/\([0-9]\)#/\1+/g' > $file3.deg
done

for file4 in `cat file_lists/es`
do
grep -v 'discrep' $file4 | grep -v 'linebreak' | sed 's/q.*q//g' | sed 's/[\/\.)(,]//g' | sed 's/-//g' | grep -v '^$' | sed 's/[sS].*/1/g' | 
	sed  's/[rR].*/2/g' | sed  's/[gG]h.*/3/g' | sed 's/h[gG].*/3/g' |
	sed  's/#[gG].*/3+/g'| sed  's/[gG]#.*/3+/g' | sed  's/[gG].*/3-/g' | 
	sed  's/[mM].*/4/g' | sed  's/[pP].*/5/g' |
	sed  's/[dD].*/6/g' | sed  's/[nN].*/7/g' |
	sed 's/b\([0-9]\)/\1-/g' | sed 's/#\([0-9]\)/\1+/g' | sed 's/\([0-9]\)b/\1-/g' | sed 's/\([0-9]\)#/\1+/g'> $file4.deg
done

for file5 in `cat file_lists/fis`
do
	grep -v 'discrep' $file5 | grep -v 'linebreak' | sed 's/q.*q//g' | sed 's/[\/\.)(,]//g' | sed 's/-//g' | grep -v '^$' | sed 's/[sS].*/1/g' | 
	sed  's/[rR].*/2/g' | sed  's/[gG].*/3/g' | 	sed  's/[mM]h.*/4/g' | sed 's/h[mM].*/4/g' |
	sed  's/b[mM].*/4-/g'| sed  's/[mM]b.*/4-/g' | sed  's/[mM].*/4+/g' | sed  's/[pP].*/5/g' |
	sed  's/[dD].*/6/g' | sed  's/[nN].*/7/g' | sed 's/b\([0-9]\)/\1-/g' | 
	sed 's/#\([0-9]\)/\1+/g' | sed 's/\([0-9]\)b/\1-/g' | sed 's/\([0-9]\)#/\1+/g' > $file5.deg
done

for file6 in `cat file_lists/bes_es_aes`	
do
grep -v 'discrep' $file6 | grep -v 'linebreak' | sed 's/q.*q//g' | sed 's/[\/\.)(,]//g' | sed 's/-//g' | grep -v '^$' | sed 's/[sS].*/1/g' | 
	sed  's/[rR].*/2/g' | sed  's/[gG]h.*/3/g' | sed 's/h[gG].*/3/g' |
	sed  's/#[gG].*/3+/g'| sed  's/[gG]#.*/3+/g' | sed  's/[gG].*/3-/g'  | sed  's/[mM].*/4/g' | sed  's/[pP].*/5/g' |
	sed  's/[dD]h.*/6/g' | sed 's/h[dD].*/6/g' |
	sed  's/#[dD].*/6+/g'| sed  's/[dD]#.*/6+/g' | sed  's/[dD].*/6-/g' |  
	sed  's/[nN]h.*/7/g' | sed 's/h[nN].*/7/g' |
	sed  's/#[nN].*/7+/g'| sed  's/[nN]#.*/7+/g' | sed  's/[nN].*/7-/g'  | 
	sed 's/b\([0-9]\)/\1-/g' | sed 's/#\([0-9]\)/\1+/g' | sed 's/\([0-9]\)b/\1-/g' | sed 's/\([0-9]\)#/\1+/g' > file6.deg
done

for file7 in `cat file_lists/es_aes_bes`	
do
grep -v 'discrep' $file7 | grep -v 'linebreak' | sed 's/q.*q//g' | sed 's/[\/\.)(,]//g' | sed 's/-//g' | grep -v '^$' | sed 's/[sS].*/1/g' | 
	sed  's/[rR].*/2/g' | sed  's/[gG]h.*/3/g' | sed 's/h[gG].*/3/g' |
	sed  's/#[gG].*/3+/g'| sed  's/[gG]#.*/3+/g' | sed  's/[gG].*/3-/g'  | sed  's/[mM].*/4/g' | sed  's/[pP].*/5/g' |
	sed  's/[dD]h.*/6/g' | sed 's/h[dD].*/6/g' |
	sed  's/#[dD].*/6+/g'| sed  's/[dD]#.*/6+/g' | sed  's/[dD].*/6-/g' |  
	sed  's/[nN]h.*/7/g' | sed 's/h[nN].*/7/g' |
	sed  's/#[nN].*/7+/g'| sed  's/[nN]#.*/7+/g' | sed  's/[nN].*/7-/g'  | 
	sed 's/b\([0-9]\)/\1-/g' | sed 's/#\([0-9]\)/\1+/g' | sed 's/\([0-9]\)b/\1-/g' | sed 's/\([0-9]\)#/\1+/g' > file7.deg
done

for file8 in `cat file_lists/es_fis`		
do
grep -v 'discrep' $file8 | grep -v 'linebreak' | sed 's/q.*q//g' | sed 's/[\/\.)(,]//g' | sed 's/-//g' | grep -v '^$' | sed 's/[sS].*/1/g' | 
	sed  's/[rR].*/2/g' | sed  's/[gG]h.*/3/g' | sed 's/h[gG].*/3/g' |
	sed  's/#[gG].*/3+/g'| sed  's/[gG]#.*/3+/g' | sed  's/[gG].*/3-/g' | 
	sed  's/[mM]h.*/4/g' | sed 's/h[mM].*/4/g' |
	sed  's/b[mM].*/4-/g'| sed  's/[mM]b.*/4-/g' | sed  's/[mM].*/4+/g'  | sed  's/[pP].*/5/g' |
	sed  's/[dD].*/6/g' | sed  's/[nN].*/7/g' |
	sed 's/b\([0-9]\)/\1-/g' | sed 's/#\([0-9]\)/\1+/g' | sed 's/\([0-9]\)b/\1-/g' | sed 's/\([0-9]\)#/\1+/g' > $file8.deg
done

for file9 in `cat file_lists/es_aes_fis`	
do
grep -v 'discrep' $file9 | grep -v 'linebreak' | sed 's/q.*q//g' | sed 's/[\/\.)(,]//g' | sed 's/-//g' | grep -v '^$' | sed 's/[sS].*/1/g' | 
	sed  's/[rR].*/2/g' | sed  's/[gG]h.*/3/g' | sed 's/h[gG].*/3/g' |
	sed  's/#[gG].*/3+/g'| sed  's/[gG]#.*/3+/g' | sed  's/[gG].*/3-/g' | 
	sed  's/[mM]h.*/4/g' | sed 's/h[mM].*/4/g' |
	sed  's/b[mM].*/4-/g'| sed  's/[mM]b.*/4-/g' | sed  's/[mM].*/4+/g'  | sed  's/[pP].*/5/g' |
	sed  's/[dD]h.*/6/g' | sed 's/h[dD].*/6/g' |
	sed  's/#[dD].*/6+/g'| sed  's/[dD]#.*/6+/g' | sed  's/[dD].*/6-/g' | sed  's/[nN].*/7/g' |
	sed 's/b\([0-9]\)/\1-/g' | sed 's/#\([0-9]\)/\1+/g' | sed 's/\([0-9]\)b/\1-/g' | sed 's/\([0-9]\)#/\1+/g' > $file9.deg
done

for file9a in `cat file_lists/es_aes_des_fis`	
do
grep -v 'discrep' $file9a | grep -v 'linebreak' | sed 's/q.*q//g' | sed 's/[\/\.)(,]//g' | sed 's/-//g' | grep -v '^$' | sed 's/[sS].*/1/g' | 
	sed  's/[rR]h.*/2/g' | sed 's/h[rR].*/2/g' |
	sed  's/#[rR].*/2+/g'| sed  's/[rR]#.*/2+/g' | sed  's/[rR].*/2-/g' | sed  's/[gG]h.*/3/g' | sed 's/h[gG].*/3/g' |
	sed  's/#[gG].*/3+/g'| sed  's/[gG]#.*/3+/g' | sed  's/[gG].*/3-/g' | 
	sed  's/[mM]h.*/4/g' | sed 's/h[mM].*/4/g' |
	sed  's/b[mM].*/4-/g'| sed  's/[mM]b.*/4-/g' | sed  's/[mM].*/4+/g'  | sed  's/[pP].*/5/g' |
	sed  's/[dD]h.*/6/g' | sed 's/h[dD].*/6/g' |
	sed  's/#[dD].*/6+/g'| sed  's/[dD]#.*/6+/g' | sed  's/[dD].*/6-/g' | sed  's/[nN].*/7/g' |
	sed 's/b\([0-9]\)/\1-/g' | sed 's/#\([0-9]\)/\1+/g' | sed 's/\([0-9]\)b/\1-/g' | sed 's/\([0-9]\)#/\1+/g' > $file9a.deg
done

for file10 in `cat file_lists/es_aes`		
do
grep -v 'discrep' $file10 | grep -v 'linebreak' | sed 's/q.*q//g' | sed 's/[\/\.)(,]//g' | sed 's/-//g' | grep -v '^$' | sed 's/[sS].*/1/g' | 
	sed  's/[rR].*/2/g' | sed  's/[gG]h.*/3/g' | sed 's/h[gG].*/3/g' |
	sed  's/#[gG].*/3+/g'| sed  's/[gG]#.*/3+/g' | sed  's/[gG].*/3-/g' | 
	sed  's/[mM].*/4/g'  | sed  's/[pP].*/5/g' |
	sed  's/[dD]h.*/6/g' | sed 's/h[dD].*/6/g' |
	sed  's/#[dD].*/6+/g'| sed  's/[dD]#.*/6+/g' | sed  's/[dD].*/6-/g' | sed  's/[nN].*/7/g' |
	sed 's/b\([0-9]\)/\1-/g' | sed 's/#\([0-9]\)/\1+/g' | sed 's/\([0-9]\)b/\1-/g' | sed 's/\([0-9]\)#/\1+/g' > $file10.deg
done

for file11 in `cat file_lists/des`		
do
grep -v 'discrep' $file11 | grep -v 'linebreak' | sed 's/q.*q//g' | sed 's/[\/\.)(,]//g' | sed 's/-//g' | grep -v '^$' | sed 's/[sS].*/1/g' | 
	sed  's/[rR]h.*/2/g' | sed 's/h[rR].*/2/g' |
	sed  's/#[rR].*/2+/g'| sed  's/[rR]#.*/2+/g' | sed  's/[rR].*/2-/g'  | 
	sed  's/[gG].*/3/g' | sed  's/[mM].*/4/g' | sed  's/[pP].*/5/g' |
	sed  's/[dD].*/6/g' | sed  's/[nN].*/7/g' | sed 's/b\([0-9]\)/\1-/g' | sed 's/#\([0-9]\)/\1+/g' | 
	sed 's/\([0-9]\)b/\1-/g' | sed 's/\([0-9]\)#/\1+/g' > $file11.deg
done

for file12 in `cat file_lists/des_fis`		
do
grep -v 'discrep' $file12 | grep -v 'linebreak' | sed 's/q.*q//g' | sed 's/[\/\.)(,]//g' | sed 's/-//g' | grep -v '^$' | sed 's/[sS].*/1/g' | 
	sed  's/[rR]h.*/2/g' | sed 's/h[rR].*/2/g' |
	sed  's/#[rR].*/2+/g'| sed  's/[rR]#.*/2+/g' | sed  's/[rR].*/2-/g'  | 
	sed  's/[gG].*/3/g' | sed  's/[mM]h.*/4/g' | sed 's/h[mM].*/4/g' |
	sed  's/b[mM].*/4-/g'| sed  's/[mM]b.*/4-/g' | sed  's/[mM].*/4+/g'  | sed  's/[pP].*/5/g' |
	sed  's/[dD].*/6/g' | sed  's/[nN].*/7/g' | sed 's/b\([0-9]\)/\1-/g' | sed 's/#\([0-9]\)/\1+/g' | 
	sed 's/\([0-9]\)b/\1-/g' | sed 's/\([0-9]\)#/\1+/g' > $file12.deg
done

for file12a in `cat file_lists/fis_des`
do
grep -v 'discrep' $file12a | grep -v 'linebreak' | sed 's/q.*q//g' | sed 's/[\/\.)(,]//g' | sed 's/-//g' | grep -v '^$' | sed 's/[sS].*/1/g' | 
	sed  's/[rR]h.*/2/g' | sed 's/h[rR].*/2/g' |
	sed  's/#[rR].*/2+/g'| sed  's/[rR]#.*/2+/g' | sed  's/[rR].*/2-/g'  | 
	sed  's/[gG].*/3/g' | sed  's/[mM]h.*/4/g' | sed 's/h[mM].*/4/g' |
	sed  's/b[mM].*/4-/g'| sed  's/[mM]b.*/4-/g' | sed  's/[mM].*/4+/g'  | sed  's/[pP].*/5/g' |
	sed  's/[dD].*/6/g' | sed  's/[nN].*/7/g' | sed 's/b\([0-9]\)/\1-/g' | sed 's/#\([0-9]\)/\1+/g' | 
	sed 's/\([0-9]\)b/\1-/g' | sed 's/\([0-9]\)#/\1+/g' > $file12a.deg
done

for file13 in `cat file_lists/aes_des`		
do
grep -v 'discrep' $file13 | grep -v 'linebreak' | sed 's/q.*q//g' | sed 's/[\/\.)(,]//g' | sed 's/-//g' | grep -v '^$' | sed 's/[sS].*/1/g' | 
	sed  's/[rR]h.*/2/g' | sed 's/h[rR].*/2/g' |
	sed  's/#[rR].*/2+/g'| sed  's/[rR]#.*/2+/g' | sed  's/[rR].*/2-/g'  | 
	sed  's/[gG].*/3/g' | sed  's/[mM].*/4/g' | sed  's/[pP].*/5/g' |
	sed  's/[dD]h.*/6/g' | sed 's/h[dD].*/6/g' |
	sed  's/#[dD].*/6+/g'| sed  's/[dD]#.*/6+/g' | sed  's/[dD].*/6-/g' | 
	sed  's/[nN].*/7/g' | sed 's/b\([0-9]\)/\1-/g' | sed 's/#\([0-9]\)/\1+/g' | 
	sed 's/\([0-9]\)b/\1-/g' | sed 's/\([0-9]\)#/\1+/g' > $file13.deg
done

for file14 in `cat file_lists/bes_des`
do
grep -v 'discrep' $file14 | grep -v 'linebreak' | sed 's/q.*q//g' | sed 's/[\/\.)(,]//g' | sed 's/-//g' | grep -v '^$' | sed 's/[sS].*/1/g' | 
	sed  's/[rR]h.*/2/g' | sed 's/h[rR].*/2/g' |
	sed  's/#[rR].*/2+/g'| sed  's/[rR]#.*/2+/g' | sed  's/[rR].*/2-/g'  | 
	sed  's/[gG].*/3/g' | sed  's/[mM].*/4/g' | sed  's/[pP].*/5/g' |
	sed  's/[dD].*/6/g' | 	sed  's/[nN]h.*/7/g' | sed 's/h[nN].*/7/g' |
	sed  's/#[nN].*/7+/g'| sed  's/[nN]#.*/7+/g' | sed  's/[nN].*/7-/g'  | 
	sed 's/b\([0-9]\)/\1-/g' | sed 's/#\([0-9]\)/\1+/g' | 
	sed 's/\([0-9]\)b/\1-/g' | sed 's/\([0-9]\)#/\1+/g' > $file14.deg
done

for file15 in `cat file_lists/aes_des_fis`	
do
grep -v 'discrep' $file15 | grep -v 'linebreak' | sed 's/q.*q//g' | sed 's/[\/\.)(,]//g' | sed 's/-//g' | grep -v '^$' | sed 's/[sS].*/1/g' | 
	sed  's/[rR]h.*/2/g' | sed 's/h[rR].*/2/g' |
	sed  's/#[rR].*/2+/g'| sed  's/[rR]#.*/2+/g' | sed  's/[rR].*/2-/g'  | 
	sed  's/[gG].*/3/g' | sed  's/[mM]h.*/4/g' | sed 's/h[mM].*/4/g' |
	sed  's/b[mM].*/4-/g'| sed  's/[mM]b.*/4-/g' | sed  's/[mM].*/4+/g' | sed  's/[pP].*/5/g' |
	sed  's/[dD]h.*/6/g' | sed 's/h[dD].*/6/g' |
	sed  's/#[dD].*/6+/g'| sed  's/[dD]#.*/6+/g' | sed  's/[dD].*/6-/g' | 
	sed  's/[nN].*/7/g' | sed 's/b\([0-9]\)/\1-/g' | sed 's/#\([0-9]\)/\1+/g' | 
	sed 's/\([0-9]\)b/\1-/g' | sed 's/\([0-9]\)#/\1+/g' > $file15.deg
done

for file16 in `cat file_lists/es_aes_des`	
do
grep -v 'discrep' $file16 | grep -v 'linebreak' | sed 's/q.*q//g' | sed 's/[\/\.)(,]//g' | sed 's/-//g' | grep -v '^$' | sed 's/[sS].*/1/g' | 
	sed  's/[rR]h.*/2/g' | sed 's/h[rR].*/2/g' |
	sed  's/#[rR].*/2+/g'| sed  's/[rR]#.*/2+/g' | sed  's/[rR].*/2-/g'  | sed  's/[gG]h.*/3/g' | sed 's/h[gG].*/3/g' |
	sed  's/#[gG].*/3+/g'| sed  's/[gG]#.*/3+/g' | sed  's/[gG].*/3-/g' | 
	sed  's/[mM].*/4/g'  | sed  's/[pP].*/5/g' |
	sed  's/[dD]h.*/6/g' | sed 's/h[dD].*/6/g' |
	sed  's/#[dD].*/6+/g'| sed  's/[dD]#.*/6+/g' | sed  's/[dD].*/6-/g' | sed  's/[nN].*/7/g' |
	sed 's/b\([0-9]\)/\1-/g' | sed 's/#\([0-9]\)/\1+/g' | sed 's/\([0-9]\)b/\1-/g' | sed 's/\([0-9]\)#/\1+/g'  > $file16.deg
done

for file17 in `cat file_lists/bes_es_aes_des`	
do
grep -v 'discrep' $file17| grep -v 'linebreak' | sed 's/q.*q//g' | sed 's/[\/\.)(,]//g' | sed 's/-//g' | grep -v '^$' | sed 's/[sS].*/1/g' | 
	sed  's/[rR]h.*/2/g' | sed 's/h[rR].*/2/g' |
	sed  's/#[rR].*/2+/g'| sed  's/[rR]#.*/2+/g' | sed  's/[rR].*/2-/g'  | sed  's/[gG]h.*/3/g' | sed 's/h[gG].*/3/g' |
	sed  's/#[gG].*/3+/g'| sed  's/[gG]#.*/3+/g' | sed  's/[gG].*/3-/g' | 
	sed  's/[mM].*/4/g'  | sed  's/[pP].*/5/g' |
	sed  's/[dD]h.*/6/g' | sed 's/h[dD].*/6/g' |
	sed  's/#[dD].*/6+/g'| sed  's/[dD]#.*/6+/g' | sed  's/[dD].*/6-/g' | sed  's/[nN]h.*/7/g' | 
	sed 's/h[nN].*/7/g' |
	sed  's/#[nN].*/7+/g'| sed  's/[nN]#.*/7+/g' | sed  's/[nN].*/7-/g'|
	sed 's/b\([0-9]\)/\1-/g' | sed 's/#\([0-9]\)/\1+/g' | sed 's/\([0-9]\)b/\1-/g' | sed 's/\([0-9]\)#/\1+/g' > $file17.deg
done

