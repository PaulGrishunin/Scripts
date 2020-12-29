#!/usr/bin/python
# -*- coding: UTF-8 -*-

# Pavel Hryshunin, grupa 1

import sys
import os
import re


opt_c = 0;
opt_N = 0;
opt_p = 0;

lines = 0;
Tlines = 0;


# Check for args
for i in range(len(sys.argv)):
    if (sys.argv[i][0] == '-'):
        for a in range(len(sys.argv[i])):
            if sys.argv[i][a] == 'c': 
                opt_c=1;
            if sys.argv[i][a] == 'N': 
                opt_N=1;
            if sys.argv[i][a] == 'p': 
                opt_p=1;    
          
          
# Open file args for read
    if (len(sys.argv) < 2):
        print ("There are no files for reading!");
    if (i != 0) and (sys.argv[i][0] != '-'):
        f = open(sys.argv[i], "r")

        for line in f:
    
            if (opt_N == 1) and (line[0] == '#'):
                next
            else:
                
                if (opt_p == 1):
                    lines = lines + 1;
                    print (lines," ");
                
                print(line,);
                
               


        print;
        lines = 0;

