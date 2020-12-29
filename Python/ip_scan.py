#!/usr/bin/python3
# -*-coding: utf-8 -*-

import subprocess
import threading
from multiprocessing import Queue
import threading, queue

def ipgen(oct1,oct2,oct3,oct4):
    for o1 in range(oct1[0],oct1[1]+1):
        for o2 in range(oct2[0],oct2[1]+1):
            for o3 in range(oct3[0],oct3[1]+1):
                for o4 in range(oct4[0],oct4[1]+1):
                    yield '%s.%s.%s.%s' % (o1,o2,o3,o4)

def ping2mac(ip):
    subprocess.call(("/bin/ping -c1 -s1 %s &>/dev/null" % ip), \
            shell=True)
    macstr = subprocess.Popen(('arp -an | grep "(%s)"' % ip), \
             shell=True, stdout=subprocess.PIPE)
    mac = macstr.communicate()[0]
    if mac:
        mac = mac.split()[3]
        if mac != '<incomplete>':
            return mac
    return ''

def pinger(que):
    while True:
        ip = que.get()
        mac = ping2mac(ip)
        if mac: print (ip, mac)
        queue.task_done()

if __name__ == '__main__':
    queue = Queue()
    for i in range(20):
        worker = threading.Thread(target=pinger,args=(queue,))
        worker.setDaemon(True)
        worker.start()

    for ip in ipgen((192,192),(168,168),(0,1),(0,255)):
        queue.put(ip)
    queue.join()
