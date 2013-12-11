import re

txt='migration7367236_get_in_progress_by_host_and_node'

re1='((?:[a-z][a-z]*[0-9]+[a-z0-9]*))'	# Alphanum 1

rg = re.compile(re1,re.IGNORECASE|re.DOTALL)
m = rg.search(txt)
if m:
    alphanum1=m.group(1)
    print "("+alphanum1+")"+"\n"