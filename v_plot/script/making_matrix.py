import sys

min_offset = -500
max_offset = 499
min_length = 30
max_length = 350

counts = {}

for line in sys.stdin:
    cols = line.split()
    if len(cols) < 12 or cols[0].startswith("#"):
        continue

    site_start = int(cols[2])
    site_end = int(cols[3])
    site_mid = (site_start + site_end) // 2

    f_start = int(cols[8])
    f_end = int(cols[9])
    length = f_end - f_start
    f_mid = (f_start + f_end) // 2

    offset = f_mid - site_mid

    strand = cols[6]
    if strand == "-":
        offset = -offset

    if min_offset <= offset <= max_offset and min_length <= length <= max_length:
        pair = (offset, length)
        counts[pair] = counts.get(pair, 0) + 1

for offset in range(min_offset, max_offset + 1):
    for length in range(min_length, max_length + 1):
        count = counts.get((offset, length), 0)
        print(offset, length, count, sep="\t")
    print()
