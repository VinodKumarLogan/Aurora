import re

txt='40a3bd002c6a43a38bb819520b1101d7'

re1='(\\d+)'	# Integer Number 1
re2='((?:[a-z][a-z]*[0-9]+[a-z0-9]*))'	# Alphanum 1

rg = re.compile(re1+re2,re.IGNORECASE|re.DOTALL)
m = rg.search(txt)
if m:
    int1=m.group(1)
    alphanum1=m.group(2)
    print "("+int1+")"+"("+alphanum1+")"+"\n"