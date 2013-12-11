import csv as csv

logs = csv.reader(open("../data/cleaned_logs_v3.csv","r"))
ldpairs = csv.reader(open("./ld-listing.csv","r"))
outstats = csv.writer(open("./ld-total-stats.csv","w"))

ld_listing = {}
msgs = []

for row in ldpairs:
	ld_listing[(int(row[0]),int(row[2]))] = float(row[4])

for log in logs:
	msgs.append(int(log[0]))

distances = []
for i in range(10):
	distances.append(0)

count = len(msgs)
for i in xrange(count) :
	for j in xrange(count) :
		if msgs[i]!=msgs[j] :
			print "i = "+str(i)+" j = "+str(j)
			if ld_listing.get((msgs[i],msgs[j])) :
				dist = ld_listing[(msgs[i],msgs[j])]
			else :
				dist = ld_listing[(msgs[j],msgs[i])]
			if dist == 0:
				bin = 0
			elif dist == 1:
				bin = 9
			else :
				bin = int(dist*10%10)
			distances[bin] = distances[bin]+1

outstats.writerow(distances)