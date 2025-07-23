#/bin/env pyton
from glob import glob
from pprint import pprint
import re

DIR = "/home/eugeneai/.emacs.d/private/snippets/logtalk-mode/*[!py]"

files = glob(DIR)

TAB = "   "


def count_spaces(s):
    cn = 0
    i = 0
    for c in s:
        if c == " ":
            cn += 1
            i += 1
        if c == "\t":
            cn += 4
            cn = cn // 4
            cn = cn * 4
            i += 1
        else:
            break
    return cn, s[i:]


for file in files:
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
                w = c // 4
                p = c % 4
                l = TAB*w+rest
                o.write(l)
                continue
        else:
            skip = False
            o.write(l)
            continue
    o.close()
