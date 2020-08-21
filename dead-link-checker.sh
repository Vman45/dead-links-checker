#!/bin/bash 

### Linkcheck Activation Code ###

#the following setup should only run if linkcheck is not already activated.
#test if linkcheck is up already:
linkcheck example.com > $var
echo $var
#the result of calling linkcheck. 0 if success, 127 not activated
if [[ $var != 0 ]] ; then
    echo "linkcheck not activated"
    #setting up linkcheck
    export PATH="$PATH:/usr/lib/dart/bin"
    #this adds Dart's bin directory to PATH to allow Dart stuff to be used in the next command.
    pub global activate linkcheck
    #activates linkcheck.
    export PATH="$PATH":"$HOME/.pub-cache/bin"
    #again, adds bin directory to PATH so that linkcheck package can be used.
    #this process should take about 15 sec and only applies to the current terminal session.
else
    echo "linkcheck ok"
fi

### Script Code ###

sites=(
    'cbd.cmu.edu'
    'mohimanilab.cbd.cmu.edu'
    'cellorganizer.org'
    'pfenninglab.cbd.cmu.edu'
    'careers.cbd.cmu.edu'
    'compeau.cbd.cmu.edu'
    'bic.cs.cmu.edu'
    'www.compbio.cmu.edu'
    'msas.cbd.cmu.edu'
    'kingsfordlab.cbd.cmu.edu'
)

#setup blank text file for one big email for all websites instead of one email per website

echo "Dead Links Email Report for `date +%Y-%m-%d`

" > email.txt

for site in ${sites[@]};do
    echo "Below is the report for $site :

    " >> email.txt
    linkcheck $site > output.txt
    python3 errorCleanup.py #the output of this goes into log.txt
    cat log.txt >> email.txt
done

mutt -s "[CBD COMPUTING] Dead Links Email Report" icaoberg@andrew.cmu.edu < email.txt

rm email.txt
rm output.txt
rm log.txt

#things I'm not sure about: inclusion of newlines, whether output.txt and log.txt will be replaced each time their scripts are run