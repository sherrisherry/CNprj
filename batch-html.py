# import package will be used
from bs4 import BeautifulSoup
import csv

#Import data
## load import data
# use BeautifulSoup to read lxml file
htmlcodes = open('i50220197.txt', encoding = 'utf-8').read()
soup = BeautifulSoup(htmlcodes, 'lxml')
## overview the length of the file
nrow = soup.p.span.text # the 1st p has number of rows of the table in span

for trow in soup.select('tr'):
    tmp = trow.find_all('div', class_ = 'th-line')
    tmp[4] = tmp[4].get('title')
    tmp[6] = tmp[6].get('title')

# create a list object in order to store each row records in HTML table object, and transform it into a dataframe
data = []

# use for loop to loop throw all the 'table row' tag
for trow in soup.find_all('tr'):
    # find all the data in each column of that row
    cols = trow.find_all('td')
    # use function to only extract the text object of that record, and put them in a list
    cols = [ele.div.text.strip() for ele in cols]
    # change '—' to '-'
    cols = ['-' if ele == '—' else ele for ele in cols]
    # change " to '
    cols = [ele.replace('"',"'") if '"' in ele else ele for ele in cols]
    # one row in the table as a list element, then put all the lists in one list
    data.append([ele for ele in cols])

# 'a' append 'a+' create if not exist
# quotechar = from '"' to "'"
with open('import.csv', 'a+', newline='', encoding='utf-8') as f:
    writer = csv.writer(f, quoting = csv.QUOTE_ALL, quotechar = '"', lineterminator = ',\n')
    writer.writerows(data)
    
#Export data
## load export data
# use BeautifulSoup to read lxml file
htmlcodes = open('e50220197.txt', encoding = 'utf-8').read()
soup = BeautifulSoup(htmlcodes, 'lxml')

## overview the length of the file
nrow = soup.p.span.text # the 1st p has number of rows of the table in span

for trow in soup.select('tr'):
    tmp = trow.find_all('div', class_ = 'th-line')
    tmp[4] = tmp[4].get('title')
    tmp[6] = tmp[6].get('title')

# create a list object in order to store each row records in HTML table object, and transform it into a dataframe
data = []

for trow in soup.find_all('tr'):
    # find all the data in each column of that row
    cols = trow.find_all('td')
    # use function to only extract the text object of that record, and put them in a list
    cols = [ele.div.text.strip() for ele in cols]
    # change '—' to '-'
    cols = ['-' if ele == '—' else ele for ele in cols]
    # change " to '
    cols = [ele.replace('"',"'") if '"' in ele else ele for ele in cols]
    # one row in the table as a list element, then put all the lists in one list
    data.append([ele for ele in cols])

# 'a' append 'a+' create if not exist
# quotechar = from '"' to "'"
with open('export.csv', 'a+', newline='', encoding='utf-8') as f:
    writer = csv.writer(f, quoting = csv.QUOTE_ALL, quotechar = '"', lineterminator = ',\n')
    writer.writerows(data)
