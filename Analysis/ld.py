import csv as csv

def levenshtein(seq1, seq2):
    lseq1 = len(seq1)
    lseq2 = len(seq2)
    oneago = None
    thisrow = range(1, lseq2 + 1) + [0]
    for x in xrange(lseq1):
        twoago, oneago, thisrow= oneago, thisrow, [0] * lseq2 + [x + 1]
        for y in xrange(lseq2):
            delcost = oneago[y] + 1
            addcost = thisrow[y - 1] + 1
            subcost = oneago[y - 1] + (seq1[x] != seq2[y])
            thisrow[y] = min(delcost, addcost, subcost)
    return thisrow[lseq2 - 1]

f = csv.reader(open("../data/unique-msg-count.csv","r"))
outvalues = csv.writer(open("./ld-listing.csv","w"))
outstats = csv.writer(open("./ld-stats.csv","w"))

msgs_with_ids = {}
msgs_with_count = {}

for row,i in zip(f,range(1048)):
    msgs_with_ids[row[0]] = i
    msgs_with_count[row[0]] = int(row[1])

msgs = msgs_with_ids.keys()

distances = []
for i in range(10):
    distances.append(0)

print msgs
count = len(msgs)
for i in xrange(count) :
    print "i = "+str(i)
    for j in xrange(i+1,count) :
        print "i = "+str(i)+" j = "+str(j)
        msg1,msg2 = msgs[i].split(), msgs[j].split()
        dist = levenshtein(msg1,msg2)/float(max(len(msg1),len(msg2)))
        if dist == 0:
            bin = 0
        elif dist == 1:
            bin = 9
        else :
            bin = int(dist*10%10)
        distances[bin] = distances[bin] + msgs_with_count[msgs[i]]*msgs_with_count[msgs[j]]
        outvalues.writerow([msgs_with_ids[msgs[i]],msgs[i],msgs_with_ids[msgs[j]],msgs[j],dist])

outstats.writerow(distances)

cleaned_logs = open("../data/cleaned-log-msgs-v1.log","r")
cleaned_logs_v3 = csv.writer(open("../data/cleaned_logs_v3.csv","w"))

for log in cleaned_logs:
    log = log.split('$')
    print log[1]
    cleaned_logs_v3.writerow([msgs_with_ids[log[1][0:-1]],log[0],log[1][0:-1]])

