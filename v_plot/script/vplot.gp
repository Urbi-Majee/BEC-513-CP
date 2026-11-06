set terminal pngcairo size 1000,750 enhanced font 'Arial,12'
set output 'vplot.png'

set title 'cfDNA Fragment Length vs Distance from CTCF Motif' font 'Arial-Bold,14'
set xlabel 'Distance from CTCF Center (bp)' offset 0,-0.5 font 'Arial,12'
set ylabel 'Fragment Length (bp)' offset -0.5,0 font 'Arial,12'

set xrange [-500:500]
set yrange [30:350]

set tics out nomirror
set mxtics 5
set mytics 5

set view map
set pm3d map
set pm3d interpolate 0,0

set palette defined ( \
    0 '#ffffff', \
    1 '#313695', \
    2 '#4575b4', \
    3 '#74add1', \
    4 '#abd9e9', \
    5 '#fee090', \
    6 '#fdae61', \
    7 '#f46d43', \
    8 '#d73027', \
    9 '#a50026'  \
)

set cblabel 'Fragment Count' offset 1,0 font 'Arial,11'

splot 'final_matrix.tsv' using 1:2:3 with pm3d notitle
