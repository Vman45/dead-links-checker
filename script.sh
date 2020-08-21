#!/bin/bash

websites=(
    'cbd.cmu.edu'
    'mohimanilab.cbd.cmu.edu'
    'cellorganizer.org'
    'pfenninglab.cbd.cmu.edu'
    'careers.cbd.cmu.edu'
    'compeau.cbd.cmu.edu'
    'bic.cs.cmu.edu'
    'compbio.cmu.edu'
    'msas.cbd.cmu.edu'
    'kingsfordlab.cbd.cmu.edu'
)

for website in ${websites[@]};do
	echo $website | toilet -f term -F border --gay
	./check_dead_links.sh $website
done
