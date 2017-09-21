# SNARF
SnP Variable Repeat Finder

#### Extended Methods

The purpose of the experiment was to find repeats in PCR sequences that had been sequenced using Illumina for further analysis as Variable Number Tandem Repeats (VNTR).

First, the reads were downloaded from Galaxy by parsing the webpage for the Galaxy hashed identifier, then using curl to mass download the reads (see below).

Next, a [perl](https://github.com/disulfidebond/SNARF/blob/master/snarfSeq.pl) script was used as part of a two step process.  First, it grabbed all reads that matched any possible pairs of nucleotides, then filtered for only repeated nucldotides.

Finally, a [python](https://github.com/disulfidebond/SNARF/blob/master/parseData4Excel.py) script formatted the output into an Excel-compatible spreadsheet


       # Code to parse Galaxy
       sed -n '/#/{n;p;}' tmpDocParsed_useGalaxy.txt # where '#' is an identifier from a partially-parsed XML file
       
       declare -a CURLARR 
       
       CURLARR=($(<fileOfIdentifiers.txt))

       for i in "${CURLARR[@]}" ; do 
           echo "Downloading ${i}" ;  # note using curl -J has security implications and should not be used cavalierly 
           curl -O -J https://usegalaxy.org/datasets/${i}/display?to_ext=fastqsanger > ${i}.txt ; 
           let RANDSLEEP=($RANDOM % 3) ; 
           sleep $RANDSLEEP ; 
       done
