import gzip
import random

random.seed(42)

ref_prob = {}
for line in open("reference.hist"):
    p = line.split()
    if p:
        ref_prob[int(float(p[0]))] = float(p[1])

q_counts = {}
with gzip.open("query.bed.gz", "rt") as f:
    for line in f:
        p = line.split()
        if len(p) >= 3 and not line.startswith("#"):
            try:
                length = int(p[2]) - int(p[1])
            except ValueError:
                continue
            if length > 0:
                q_counts[length] = q_counts.get(length, 0) + 1

tot_q = sum(q_counts.values())
q_prob = {length: q_counts[length] / tot_q for length in q_counts}

bottleneck = 1.0
for length in ref_prob:
    if length in q_prob and ref_prob[length] > 0.001 and length <= 180:
        ratio = q_prob[length] / ref_prob[length]
        if ratio < bottleneck:
            bottleneck = ratio

keep_prob = {}
for length in ref_prob:
    if length in q_prob:
        keep_prob[length] = min(1.0, bottleneck * ref_prob[length] / q_prob[length])

sampled_counts = {}
with gzip.open("query.bed.gz", "rt") as in_f, open("rescaled_query.bed", "w") as out_bed:
    for line in in_f:
        p = line.split()
        if len(p) >= 3 and not line.startswith("#"):
            try:
                length = int(p[2]) - int(p[1])
            except ValueError:
                continue
            if random.random() < keep_prob.get(length, 0.0):
                out_bed.write(line)
                sampled_counts[length] = sampled_counts.get(length, 0) + 1

tot_sampled = sum(sampled_counts.values())

with open("sampled.hist", "w") as f:
    for length in sorted(sampled_counts):
        f.write(f"{length}\t{sampled_counts[length] / tot_sampled}\n")

with open("query.hist", "w") as f:
    for length in sorted(q_prob):
        f.write(f"{length}\t{q_prob[length]}\n")
