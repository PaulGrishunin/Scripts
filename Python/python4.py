#!/usr/bin/python
# -*- coding: UTF-8 -*-

# Pavel Hryshunin, grupa 1

import sys
import os
import re

path = []
expr = []
flag = 0  
work = 0
hasv = 0

def getFiles(dirName):
    fileList = os.listdir(dirName)     #список файлов и директорий в папке
    allFiles = list()
    for entry in fileList:
        fullPath = os.path.join(dirName, entry)      #соединяет пути с учётом особенностей операционной системы
        if os.path.isdir(fullPath):                  #проверка является ли путь директорией
            allFiles = allFiles + getFiles(fullPath)
        else:
            allFiles.append(fullPath)
    return allFiles

def searchFile(fileName, exprl):
    r = 0
    with open(fileName) as fileDesc:
        r = fileDesc.read().count(exprl)
    return r                              #возвращаем кол-во повторений

for i in range(len(sys.argv)):            #считываем переданные аргументы командной строки
        
    if (sys.argv[i][0] == '-'):
        for c in range(len(sys.argv[i])):
            if sys.argv[i][c] == 'v':
                hasv = 1;
    
    if (flag == 2) and (sys.argv[i][0] != '-'):  #считываем arg выражение, следующее за путем и добавляем его в expr
        
        expr.append(sys.argv[i])
       
        if i+1 >= len(sys.argv):       #если следующий аргумент это "-" или конец строки, выполняем вывод
            work = 1
        else:
            if sys.argv[i+1][0] == '-':
                work = 1
                
    if flag == 1:                           
        path.append(sys.argv[i]);           #arg это путь, добавляем его в список
        flag = 2 
        
    if sys.argv[i][0] == '-':
        for c in range(len(sys.argv[i])):
            if sys.argv[i][c] == 'd':
                flag = 1           #с этим флагом будем читать путь из arg
    
    
        
    if work == 1:      #start working
        work = 0
        for e in range(len(expr)):
            count = 0
            for i in range(len(path)):
                fileList = getFiles(path[i])
                for f in range(len(fileList)):
                    count = count + searchFile(fileList[f], expr[e])
                    if (hasv == 1):
                        print("search:", fileList[f], expr[e], searchFile(fileList[f], expr[e]))
                print(expr[e], " ", count);
        
        # clear all
        path = [];
        expr = [];
