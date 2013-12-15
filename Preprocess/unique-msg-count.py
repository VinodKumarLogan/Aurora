#!/usr/bin/env python
import mincemeat

data = []

f = open("unique-msg-count.csv","r")
for l in f:
	data.append(l)

# The data source can be any dictionary-like object
datasource = dict(enumerate(data))

def mapfn(k, v):
    for w in v.split('\n'):
    	w = w.split('$')
    	if len(w) == 2:
    		print w[1]
        	yield w[1], 1

def reducefn(k, vs):
    result = sum(vs)
    return result

s = mincemeat.Server()
s.datasource = datasource
s.mapfn = mapfn
s.reducefn = reducefn

results = s.run_server(password="changeme")

import csv
w = csv.writer(open("../data/unique-msg-count.csv", "w"))
for key, val in results.items():
    w.writerow([key, val])
