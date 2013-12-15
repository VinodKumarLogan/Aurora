f1 = open("/home/rmr/aurora/logs/log/nova/nova-api.log")
f2 = open("/home/rmr/aurora/logs/log/nova/nova-cert.log")
f3 = open("/home/rmr/aurora/logs/log/nova/nova-compute.log")
f4 = open("/home/rmr/aurora/logs/log/nova/nova-conductor.log")
f5 = open("/home/rmr/aurora/logs/log/nova/nova-consoleauth.log")
f6 = open("/home/rmr/aurora/logs/log/nova/nova-scheduler.log")
f7 = open("/home/rmr/aurora/logs/log/libvirt/libvirtd.log")
f8 = open("/home/rmr/aurora/logs/log/glance/api.log")
f9 = open("/home/rmr/aurora/logs/log/glance/registry.log")

out = open("/home/rmr/aurora/data/aglogs-1.log","a")

print("starting 1...")
for l in f1 :
	out.write(l)

print("starting 2...")
for l in f2 :
	out.write(l)

print("starting 3...")
for l in f3 :
	out.write(l)

print("starting 4...")
for l in f4 :
	out.write(l)

print("starting 5...")
for l in f5 :
	out.write(l)

print("starting 6...")
for l in f6 :
	out.write(l)

print("starting 7...")
for l in f7 :
	out.write(l)

print("starting 8...")
for l in f8 :
	out.write(l)

print("starting 9...")
for l in f9 :
	out.write(l)
