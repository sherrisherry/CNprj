#!/usr/bin/python3

from bs4 import BeautifulSoup
import csv
import os

os.chdir(os.path.expanduser("~") + '/cn_prj')
in_dir = 'download'; out_dir = 'outputs'
yr = str(2019); mth = str(8)
cty = str(502)
ie = {'i':'import', 'e':'export'}
for mx in ie:
    htmlcodes = open(in_dir + '/' + mx + cty + yr + mth + '.txt', encoding = 'utf-8').read()
    soup = BeautifulSoup(htmlcodes, 'lxml')
    nrow = soup.p.span.text # the 1st p has number of rows of the table in span
    for trow in soup.select('tr'):
        tmp = trow.find_all('div', class_ = 'th-line')
        # .string fails when nothing between tags
        txt = tmp[4].get('title')
        if tmp[4].text != '' and txt is not None: tmp[4].string = txt
        txt = tmp[6].get('title')
        if tmp[6].text != '' and txt is not None: tmp[6].string = txt
    data = []
    for trow in soup.find_all('tr'):
        cols = trow.find_all('td')
        cols = [ele.div.text.strip() for ele in cols]
        cols = ['-' if ele == '—' else ele for ele in cols]
        cols = [ele.replace('"',"'") if '"' in ele else ele for ele in cols]
        data.append([ele for ele in cols])
    if len(data) != int(nrow):
        with open('batch.log', 'w+') as f: f.write("# of rows error\n")
        continue
    tmp = [i for i in data if len(i[3]) != 8]
    if len(tmp) != 0:
        with open('batch.log', 'a+') as f: f.writelines(tmp)
        continue
    with open(out_dir + '/' + ie[mx] + '.csv', 'a+', newline='', encoding='utf-8') as f:
        writer = csv.writer(f, quoting = csv.QUOTE_ALL, quotechar = '"', lineterminator = ',\n')
        writer.writerows(data)
