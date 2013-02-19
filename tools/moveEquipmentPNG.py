#!/usr/bin/env python

import shutil
import os
import sys

def replaceStringInFile(fn, fname, newpath):
    f = open(fn,'r')
    lines = f.readlines()
    f.close()

    f = open(fn,'w')
    for line in lines:
        if fname in line:
            line = line.replace(fname, newpath)
        f.write(line)
    f.close()

def movePNG(fname, newdir, newbasename=""):
    if newbasename == "":
        newbasename = fname.split(r"/")[-1]

    newfname=newdir+newbasename
    print fname, "->", newfname
    try:
        os.makedirs(newdir)
    except:
        pass
    shutil.copyfile(fname, newfname)
    os.remove(fname)
    for (dirpath, dirnames, filenames) in os.walk("sprites"):
        #print dirpath , dirnames, filenames
        for filename in filenames:
            fn = os.path.join(dirpath, filename)
            if fn.endswith('png'):
                continue
            replaceStringInFile(fn, fname[8:], newfname[8:]) # [8:] removes "sprites/"

    replaceStringInFile("AUTHORS.txt", fname[8:], newfname[8:])# [8:] removes "sprites/"
    # npcs.xml monsters.xml and items.xml not needed.

for x in sys.argv[1:-1]:
    print x
    movePNG(x, sys.argv[-1])
