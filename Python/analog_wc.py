#!/usr/bin/python
# -*- coding: UTF-8 -*-

# Pavel Hryshunin, grupa 1

import sys
import os
import re

arg_c = 0;
arg_l = 0;
arg_w = 0;
arg_m = 0;
arg_e = 0;
arg_i = 0;
arg_d = 0;
opts = 0;

file = 0;

words = 0;
Twords = 0;

chars = 0;
Tchars = 0;

size = 0;
Tsize = 0;

lines = 0;
Tlines = 0;

ints = 0;
Tints = 0;

numb = 0;
Tnumb = 0;

intRegExp = re.compile('[-+]?\d+$');
number1RegExp = re.compile('[-+]?\d*[,.]?\d+$');
number2RegExp = re.compile('[-+]?\d*[,.]?\d+[eEdDqQ^]+[+-]?\d*[,.]?\d+$');

def checkInt(var):
    n = 0;
    words = var.split();
    for word in words:
        if(intRegExp.match(word)):
            n=n+1;
    return n;

def checkNumber(var):
    n = 0;
    words = var.split();
    for word in words:
        if(number1RegExp.match(word)):
            n=n+1;
        if(number2RegExp.match(word)):
            n=n+1;
    return n;

for i in range(len(sys.argv)):
    #Reading arguments
    if (sys.argv[i][0] == '-'):
        for n in range(len(sys.argv[i])):
            if sys.argv[i][n] == 'n':
                arg_c=1;
                opts = opts+1;
            if sys.argv[i][n] == 'l':
                arg_l=1;
                opts = opts+1;
            if sys.argv[i][n] == 'w':
                arg_w=1;
                opts = opts+1;
            if sys.argv[i][n] == 'm':
                arg_m=1;
                opts = opts+1;
            if sys.argv[i][n] == 'e':
                arg_e=1;
                opts = opts+1;
            if sys.argv[i][n] == 'i':
                arg_i=1;
                opts = opts+1;
            if sys.argv[i][n] == 'd':
                arg_d=1;
                opts = opts+1;

    if (opts == 0):
        arg_c = 1;
        arg_l = 1;
        arg_w = 1;
    #End of arguments; Open file
    if (i != 0) and (sys.argv[i][0] != '-'):
        f = open(sys.argv[i], "r")
        
        for line in f:
            #print line,
            
            if (arg_e == 1) and (line[0] == '#'):
                next
            
            if (arg_l == 1):
                lines = lines + 1;
                Tlines = Tlines + 1;
                
            if (arg_w == 1):
                wordList = line.split();
                words = words + len(wordList);
                Twords = Twords + len(wordList);
                
            if (arg_c == 1):
                chars = chars + len(line);
                Tchars = Tchars + len(line);
            
            if (arg_i == 1):
                ints = ints + checkInt(line);
                
            if (arg_d == 1):
                numb = numb + checkNumber(line);
                
        #end of file
        # output
        print "",;
        if (arg_l == 1):
            print lines,;
        if (arg_w == 1):
            print words,;
        if (arg_m == 1):
            print chars,;
        if (arg_c == 1):
            size = os.path.getsize("./"+sys.argv[i]);
            Tsize = Tsize + size;
            print size,;
        if (arg_i == 1):
            print ints,;
        if (arg_d == 1):
            print numb,;

        print sys.argv[i]
        # restart counters
        lines = 0;
        words = 0;
        chars = 0;
        Tints = Tints + ints;
        ints = 0;
        Tnumb = Tnumb + numb;
        numb = 0;
        file = file + 1;
    
### View totals (if more than one file devered)

print "",;
if (file > 1):
    if (arg_l == 1):
        print Tlines,;
    if (arg_w == 1):
        print Twords,;
    if (arg_m == 1):
        print Tchars,;
    if (arg_c == 1):
        print Tsize,;
    if (arg_i == 1):
        print Tints,;
    if (arg_d == 1):
        print Tnumb,;
    print "razem\n",;
    
    
    
