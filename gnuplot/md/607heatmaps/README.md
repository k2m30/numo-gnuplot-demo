## 2D and 3D heat maps
[Original Demo](http://gnuplot.sourceforge.net/demo_4.6/heatmaps.html)

### 1

```ruby
# # Two ways of generating a 2D heat map from ascii data
# #
# 
# set title "Heat Map generated from a file containing Z values only"
# unset key
# set tic scale 0
# 
# # Color runs from white to green
# set palette rgbformula -7,2,-7
# set cbrange [0:5]
# set cblabel "Score"
# unset cbtics
# 
# set xrange [-0.5:4.5]
# set yrange [-0.5:4.5]
# 
# set view map
# splot '-' matrix with image
# 5 4 3 1 0
# 2 2 0 0 1
# 0 0 0 1 0
# 0 0 0 2 3
# 0 1 2 4 3
# e
# 
# set title "Heat Map generated by 'plot' from a stream of XYZ values"\
#          ."\nNB: Rows must be separated by blank lines!"

Numo.gnuplot do
  set title:"Heat Map generated from a file containing Z values only"
  unset :key
  set :tic, :scale, 0
  set :palette, rgbformula:[-7,2,-7]
  set cbrange:0..5
  set cblabel:"Score"
  unset :cbtics
  set xrange:-0.5..4.5
  set yrange:-0.5..4.5
  set view:'map'
  run <<EOL
splot '-' matrix with image
5 4 3 1 0
2 2 0 0 1
0 0 0 1 0
0 0 0 2 3
0 1 2 4 3
e
e
EOL
  set title:"Heat Map generated by 'plot' from a stream of XYZ values"+"\nNB: Rows must be separated by blank lines!"
end
```
![607heatmaps/001](https://raw.github.com/ruby-numo/gnuplot-demo/master/gnuplot/md/607heatmaps/image/001.png)

### 2

```ruby
# plot '-' using 2:1:3 with image
# 0 0 5
# 0 1 4
# 0 2 3
# 0 3 1
# 0 4 0
# 
# 1 0 2
# 1 1 2
# 1 2 0
# 1 3 0
# 1 4 1
# 
# 2 0 0
# 2 1 0
# 2 2 0
# 2 3 1
# 2 4 0
# 
# 3 0 0
# 3 1 0
# 3 2 0
# 3 3 2
# 3 4 3
# 
# 4 0 0
# 4 1 1
# 4 2 2
# 4 3 4
# 4 4 3
# e
# 
# reset

Numo.gnuplot do
  run <<EOL
plot '-' using 2:1:3 with image
0 0 5
0 1 4
0 2 3
0 3 1
0 4 0
1 0 2
1 1 2
1 2 0
1 3 0
1 4 1
2 0 0
2 1 0
2 2 0
2 3 1
2 4 0
3 0 0
3 1 0
3 2 0
3 3 2
3 4 3
4 0 0
4 1 1
4 2 2
4 3 4
4 4 3
e
EOL
  reset
end
```
![607heatmaps/002](https://raw.github.com/ruby-numo/gnuplot-demo/master/gnuplot/md/607heatmaps/image/002.png)

### 3

```ruby
# # Demonstrate use of 4th data column to color a 3D surface.
# # Also demonstrate use of the pseudodata special file '++'.
# # This plot is nice for exploring the effect of the 'l' and 'L' hotkeys.
# #
# set view 49, 28, 1, 1.48
# set xrange [ 5 : 35 ] noreverse nowriteback
# set yrange [ 5 : 35 ] noreverse nowriteback
# # set zrange [ 1.0 : 3.0 ] noreverse nowriteback
# set ticslevel 0
# set format cb "%4.1f"
# set colorbox user size .03, .6 noborder
# set cbtics scale 0
# 
# set samples 25, 25
# set isosamples 50, 50
# 
# set title "4D data (3D Heat Map)"\
#           ."\nIndependent value color-mapped onto 3D surface"  offset 0,1
# set xlabel "x" offset 3, 0, 0 
# set ylabel "y" offset -5, 0, 0
# set zlabel "z" offset 2, 0, 0 
# set pm3d implicit at s
# 
# Z(x,y) = 100. * (sinc(x,y) + 1.5)
# sinc(x,y) = sin(sqrt((x-20.)**2+(y-20.)**2))/sqrt((x-20.)**2+(y-20.)**2)
# color(x,y) = 10. * (1.1 + sin((x-20.)/5.)*cos((y-20.)/10.))
# 
# splot '++' using 1:2:(Z($1,$2)):(color($1,$2)) with pm3d title "4 data columns x/y/z/color"

Numo.gnuplot do
  set view:[49,28,1,1.48]
  set xrange:5..35, noreverse:true, nowriteback:true
  set yrange:5..35, noreverse:true, nowriteback:true
  set ticslevel:0
  set format_cb:"%4.1f"
  set :colorbox, "user", size:[0.03,0.6], noborder:true
  set :cbtics, :scale, 0
  set samples:[25,25]
  set isosamples:[50,50]
  set title:"4D data (3D Heat Map)"+"\nIndependent value color-mapped onto 3D surface", offset:[0,1]
  set xlabel:"x", offset:[3,0,0]
  set ylabel:"y", offset:[-5,0,0]
  set zlabel:"z", offset:[2,0,0]
  set :pm3d, "implicit", at:"s"
  run "Z(x,y) = 100. * (sinc(x,y) + 1.5)"
  run "sinc(x,y) = sin(sqrt((x-20.)**2+(y-20.)**2))/sqrt((x-20.)**2+(y-20.)**2)"
  run "color(x,y) = 10. * (1.1 + sin((x-20.)/5.)*cos((y-20.)/10.))"
  splot "'++'", using:'1:2:(Z($1,$2)):(color($1,$2))', with:"pm3d", title:"4 data columns x/y/z/color"
end
```
![607heatmaps/003](https://raw.github.com/ruby-numo/gnuplot-demo/master/gnuplot/md/607heatmaps/image/003.png)

### 4

```ruby
# set title "4D data (3D Heat Map)"\
#           ."\nZ is contoured. Independent value is color-mapped"  offset 0,1
# 
# set view map
# 
# set contour base
# splot '++' using 1:2:(Z($1,$2)):(color($1,$2)) with pm3d title "4 data columns x/y/z/color"

Numo.gnuplot do
  set title:"4D data (3D Heat Map)"+"\nZ is contoured. Independent value is color-mapped", offset:[0,1]
  set view:'map'
  set contour:"base"
  splot "'++'", using:'1:2:(Z($1,$2)):(color($1,$2))', with:"pm3d", title:"4 data columns x/y/z/color"
end
```
![607heatmaps/004](https://raw.github.com/ruby-numo/gnuplot-demo/master/gnuplot/md/607heatmaps/image/004.png)