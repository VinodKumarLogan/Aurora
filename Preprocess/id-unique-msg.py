import csv as csv

unique_logs = {}
cleaned_logs = {}

unique_logs_file = csv.reader(open("../data/unique-msg-count.csv"))
cleaned_logs_file = csv.reader(open("../data/cleaned_logs_v3.csv"))
unique_logs_file_v2 = csv.writer(open("../data/unique-msg-count-v2.csv","a"))

for log in cleaned_logs_file :
	cleaned_logs[int(log[0])] = log[1]

for log in unique_logs_file :
	unique_logs_file_v2.writerow([log[2],cleaned_logs[int(log[2])],log[0],log[1]])










