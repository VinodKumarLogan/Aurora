import re

def clean_msg(msg) :
	p = re.compile("[ ]+")
	msg = p.sub(" ",msg)
	p = re.compile(r"u'.*'")
	msg = p.sub("<x>",msg)
	p = re.compile(r"http://.*")
	msg = p.sub("<url>",msg)
	p = re.compile("[0-9]+[.]+[0-9]+[.]+[0-9]+[.]+[0-9]+")
	msg = p.sub("<ip>",msg)
	p = re.compile("[0-9]+")
	msg = p.sub("<num>",msg)
	p = re.compile(r"/.*")
	msg = p.sub("<path>",msg)
	p = re.compile(r"(:|,|{|}|\[|\]|\_|\(|\)|[.]|\*|\'|\")+")
	msg = p.sub("",msg)
	p = re.compile("[.]+")
	msg = p.sub("",msg)
	if msg.count('<num>') >= 3 :
		return '<y>'
	return msg.lower()

f = open("../data/log-msgs.log","r")
out = open("../data/cleaned-log-msgs-v1.log","a")

for l in f:
	parts = l.split('$')
	if len(parts) == 2 :
		parts[1] = clean_msg(parts[1])
		output = parts[0].encode('utf-8')+'$'+parts[1].encode('utf-8')
		if '\n' not in output:
			out.write(output+'\n')
		else :
			out.write(output)
