def levenshtein(seq1, seq2):
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

lseq2 = 3
lseq1 = 3
print len("rbdstorecephconf = <path>".split())
print levenshtein("rbdstorecephconf = <path>".split()," scrubberdatadir = <path>".split())