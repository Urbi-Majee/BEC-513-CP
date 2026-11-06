set terminal pngcairo size 800,600 enhanced font 'Arial,10'
set output 'plot_r.png'

set xlabel 'Fragment length'
set ylabel 'Normalized frequency'
set xrange [0:700]
set yrange [0:0.025]

set key top right
set key spacing 1.2

set style line 1 lc rgb '#2ec27e' lt 1 lw 2.0
set style line 2 lc rgb '#1a5fb4' pt 7 ps 0.85

plot 'reference.hist' using 1:2 with lines ls 1 title 'Reference', \
     'sampled.hist' using 1:2 with points ls 2 title 'Rescaled query'
