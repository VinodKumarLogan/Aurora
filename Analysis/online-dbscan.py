import csv as csv

def get_distance_from_cluster(cluster,log):
	distance_list = []
	for clog in cluster[1]:
		if clog == log :
			dist = 0
		else :
			dist = ld_listing.get((int(clog),log))
			if dist == None :
				dist = ld_listing.get((log,int(clog)))
		distance_list.append(dist)
	return min(distance_list)

def get_distance_dict(log):
	distance_dict = {}
	for cluster in clusters :
		dist = get_distance_from_cluster(clusters[cluster],log[0])
		distance_dict[dist] = cluster
	return distance_dict

def get_accuracy(cluster_id):
	cluster_details = clusters[cluster_id]
	cluster_name = cluster_details[0]
	count = 0
	for entry in cluster_details[1]:
		if unique_logs[entry] == cluster_name :
			count = count+1
	return count/float(len(cluster_details[1])) 

unique_logs_file = csv.reader(open("../data/unique-msg-count-v2.csv"))
cleaned_logs_file = csv.reader(open("../data/unique-msg-count-v2.csv"))
ld_listing_file = csv.reader(open("../data/ld-listing.csv"))

ld_listing = {}
unique_logs = {}
cleaned_logs = []

for entry in ld_listing_file :
	ld_listing[(int(entry[0]),int(entry[2]))] = float(entry[4])

for log in unique_logs_file :
	unique_logs[int(log[0])] = log[1]

for log in cleaned_logs_file :
	cleaned_logs.append([int(log[0]),log[1]])

clusters = {}
cid = 0
dist_temp = {}

min_distance_threshold = 0.20

print ld_listing

for log,i in zip(cleaned_logs,xrange(len(cleaned_logs))) :
	print "================================================"
	print "log = "+str(i)
	if len(clusters) == 0:
		clusters[cid]=[log[1],set([log[0]])]
		cid = cid+1
	else :
		dist_temp = get_distance_dict(log)
		min_dist = min(dist_temp.keys())
		print "Minimum distance = "+str(min_dist)
		if min_dist <= min_distance_threshold :
			cluster_id = dist_temp[min_dist]
			clusters[cluster_id][1].add(log[0])
			print "match found - adding to cluster - "+str(cluster_id)
		else :
			clusters[cid]=[log[1],set([log[0]])]
			print "New cluster ! - "+str(cid)
			cid = cid+1
	print "=================================================="

clusters_out_file = csv.writer(open("../Results/clusters-t-0.20.csv","a"))
accuracy_file  = csv.writer(open("../Results/accuracy_list-t-0.20","a"))
accuracy_list = []

for cluster in clusters :
	cluster_entries = clusters[cluster]
	outrow = [c for c in cluster_entries]
	outrow.append(cluster)
	outrow.append(cluster_entries[0])
	clusters_out_file.writerow(outrow)
	accuracy_list.append(get_accuracy(cluster))

print accuracy_list
print sum(accuracy_list)/len(accuracy_list)
