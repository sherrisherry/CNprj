#!/usr/bin/python3
# correct each line; takes utf-8 inputs (default stdin encoding).
# lines not with 12 cells into argv[1]; 12-cell lines correct quotation.
import sys
for line in sys.stdin:
    cells = line.split('","')
    ncel = len(cells)
    if ncel != 12:
        with open(sys.argv[1], 'a+', encoding='utf-8') as f: f.write(line)
    else:
        for idx in range(1, ncel-1): cells[idx] = cells[idx].replace('"', "'")
        print('","'.join(cells), end = '')
