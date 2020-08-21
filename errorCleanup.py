# This python script takes output.txt from running linkcheck on a website and removes irrelevant errors.
# It then puts that result into a text file called log.txt.

string = open("output.txt", encoding='utf-8')
line = string.readline()
parentURL = ""
firstHTTP = False

log = open("log.txt","w", encoding='utf-8')

'''
errors to look for: 404, 410, connection failed
within those errors, ignore /wp-content/ (this is just wordpress content) and fonts, esp. fonts.googleapis.com
'''
while line:
    line.strip()
    if line.startswith("Perfect"):
        log.write("No errors.")
    elif line.startswith("http://") and not firstHTTP:
        #the topmost http url is the website this script was run on.
        parentURL = line
        log.write("Checking errors on "+line+"\n")
        firstHTTP = True
    elif line.startswith("http://") and firstHTTP:
        #other topmost http url is the parent url of an error
        parentURL = line
        else:
        #starts with hyphen so it's an error url
        if "(HTTP 404)" in line or "(connection failed)" in line or "(HTTP 410)" in line:
            if "/wp-content/" in line or "fonts.googleapis" in line:
                line = string.readline()
                continue
            else:
                log.write("ERROR:\n"+line[2:])
                log.write("OCCURED ON PAGE:\n"+parentURL+"\n\n")
    line = string.readline()
string.close()
log.close()