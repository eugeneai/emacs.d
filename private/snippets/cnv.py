#/bin/env pyton
from glob import glob
from pprint import pprint
import re

DIR = "/home/eugeneai/.emacs.d/private/snippets/logtalk-mode/*"
#DIR = "/home/eugeneai/.emacs.d/private/snippets/logtalk-mode/category"

files = glob(DIR)

TAB = "\t"
TAB_SIZE=3


def count_spaces(s):
    cn = 0
    i = 0
    for c in s:
        if c == " ":
            cn += 1
            i += 1
        elif c == "\t":
            cn += TAB_SIZE
            en = cn % TAB_SIZE
            cn -= en
            i += 1
        else:
            break
    return cn, s[i:]


for file in files:
    print("File:{}".format(file))
    ls = open(file).readlines()
    o = open(file, "w")
    skip = True
    for l in ls:
        l = l.rstrip()
        if not l:
            o.write("\n")
            continue
        l += "\n"
        if not l.startswith("# --"):
            if skip:
                o.write(l)
                continue
            else:
                if l.startswith("$0"):
                    l = TAB + l
                    o.write(l)
                    continue
                c, rest = count_spaces(l)
                w = c // TAB_SIZE
                p = c % TAB_SIZE
                print(c,'-',repr(l))
                print('-','-',repr(rest))
                l = (TAB*w) +rest
                o.write(l)
                print(w,p, repr(l))
                continue
        else:
            skip = False
            o.write(l)
            continue
    o.close()
