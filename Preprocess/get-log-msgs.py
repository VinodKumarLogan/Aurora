import time

def get_msg_level(m) :
	global dc
	global ic
	global ac
	global wc
	global ec
	global cc
	global tc
	if 'DEBUG' in m:
		dc=dc+1
		return "DEBUG"
	elif 'INFO' in m:
		ic=ic+1
		return "INFO"
	elif 'AUDIT' in m:
		ac=ac+1
		return "AUDIT"
	elif 'WARNING' in m:
		wc=wc+1
		return "WARNING"
	elif 'ERROR' in m:
		ec=ec+1
		return "ERROR"
	elif 'CRITICAL' in m:
		cc=cc+1
		return "CRITICAL"
	elif 'TRACE' in m:
		tc=tc+1
		return "TRACE"

f = open("/home/rmr/aurora/data/aglogs-1.log","r")
out = open("/home/rmr/aurora/data/log-msgs.log","a")

ccount = 0
ecount = 0

dc = 0
ic = 0
ac = 0
wc = 0
ec = 0
cc = 0
tc = 0

for l in f:
	l = l.split('[-]')
	if len(l) == 2:
		ccount = ccount + 1
		level = get_msg_level(l[0])
		out.write(level.encode('utf-8')+'$'+l[1].encode('utf-8')+'\n')
	else :
		if l[0] != '\n' :
			#print l
			#time.sleep(0.25)
			ecount = ecount + 1

print "ccount = "
print ccount
print "ecount = "
print ecount
print "ac = "
print ac
print "cc = "
print cc
print "dc = "
print dc
print "ec = "
print ec
print "ic = "
print ic
print "tc = "
print tc
print "wc = "
print wc








