#!/usr/bin/python
# -*- coding: UTF-8 -*-

# Pavel Hryshunin, grupa 1

import sys
import os
from time import time


#def changeToNumber(mark):

     #if "-" in str(mark):  
        #return float(mark(re.compile('[2345]$'))) - 0,25;
     #if "+" in str(mark):  
        #return float(mark(re.compile('[2345]$'))) + 0,25;
   
     #return 0;           
            
          
studs = {};       
       

for i in range(1,len(sys.argv)): 
    if (len(sys.argv) < 1):
        print ("There are no files for reading!");

    f = open(sys.argv[i], "r");

    for line in f:
        words = line.split();
        name = words[0];
        surname = words[1];
        key = surname + " " + name;
        studs.setdefault(key, []).append(words[2]); 
       
        
    group = 0;    
    for key in sorted(studs.keys()):
        print (key,"     \t",); 
        avg = 0;
        
        for i in range(len(studs[key])):
            if "+" in studs[key][i]:
                newstr = studs[key][i].replace("+", ""); 
                studs[key][i] = newstr;
            if "-" in studs[key][i]:
                newstr = studs[key][i].replace("-", ""); 
                studs[key][i] = newstr;
            print(studs[key][i]);
            avg = avg + float(studs[key][i]);
       
        avg = avg/len(studs[key]);
        avg = float(int(avg * 100))/100;
        group = group + avg;
        print (" \t",avg);
    group = group/len(studs);
    group = float(int(group * 100))/100;
    print ("Group avg mark:", group);
    studs.clear();
        
        
f.close()
