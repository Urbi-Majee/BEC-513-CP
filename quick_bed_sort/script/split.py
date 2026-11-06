import sys

with open("selection.tsv") as f:
    selection = [line.strip() for line in f if line.strip()]

fp = {chrom: open(f"{chrom}.bed", "w") for chrom in selection}

for line in sys.stdin:
    try:
        fp[line.split()[0]].write(line)
    except (IndexError, KeyError):
        pass
