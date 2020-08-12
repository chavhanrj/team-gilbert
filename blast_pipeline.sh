#!/bin/bash
rm -f mycoplasma*

# Making blastdb out of proteome sequences 
ls *.fasta | parallel makeblastdb -in {} -dbtype prot

# We are running blast and grabbing only the first sequence to the table
for i in *.fasta; do blastp -query query/Phylogeny_proteins.fasta -db $i -evalue 1e-10 -qcov_hsp_perc 0.5 -out $i.out -max_target_seqs 1 -num_threads 4 -outfmt 6; done

# Then we are extracting the second column from blast output (subjects)
for i in *.out; do awk '{print $2}' $i > $i.awk; done

# Fasta sequences of the proteins for every proteome now are in one line
for i in *.fasta; do awk '/^>/ {printf("\n%s\n",$0);next; } { printf("%s",$0);}  END {printf("\n");}' $i > $i.line; done

# Then we are using grep to find paterns (extracted subject column) in the certain proteome and extract this line and line after it (line after a header is a protein sequence)
rm -f *.result
for i in *.fasta; do while read p;do grep -A1 $p $i.line >> $i.result;done <$i.out.awk;done

# At last we are concatenating all sequenses in every proteome

for i in *.result; do cat $i | grep -v '^\s*--'| grep -v '^>' | grep '^.' | tr -d '[:blank:]' | tr -d '\n' | cat <( echo ">$i") | sed 's/\.fasta\.result//g'   >  $i.conc; done

#Adding empty line to the end of the concatenated sequeces for subsequent file concatenation
for i in *.conc; do echo "" >> $i; done

#Concatenate all the files to the master one!
cat *.conc > mycoplasma.fasta
