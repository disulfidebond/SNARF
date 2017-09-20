#!/usr/bin/python

import time
l = []
with open('concatenatedFile.txt') as f:
    for i in f:
        l.append(i)
itms = []
d = {}
dName = {}
dkey = ""
for i in l:
    lItem = i.rstrip('\r\n')
    if not lItem:
        continue
    elif lItem == '####':
        dName[dkey] = d
        itms.append(dName)
        d = {}
        dName = {}
        dkey = ""
        continue
    else:
        lItemLine = lItem.split(',')
        if len(lItemLine) == 1:
            dkey = lItemLine[0]
            continue
        if lItemLine[0] not in d:
            d[lItemLine[0]] = [1,lItemLine[1]]
        else:
            tmpList = d[lItemLine[0]]
            tmpList[0] += 1
            d[lItemLine[0]] = tmpList
print('sample_name,repeat_type,occurrence,repeat_count')
for mDictK in itms:
    for mDictKey,mDictValue in mDictK.items():
        s = mDictKey.split('.')
        sampleName = s[0] + '_' + s[2]
        outputStringAsKey = sampleName + ','
        for k,v in mDictValue.items():
            outputString = k + ',' + str(v[0]) + ',' + str(v[1])
            print(outputStringAsKey + outputString)
