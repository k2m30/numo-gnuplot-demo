require "numo/narray"
require "numo/gsl"
require "numo/gnuplot"

def gplot(plot_args,setting,fn)
  Numo.gnuplot do
    set xlabel:"x", ylabel:"y"
    set setting
    plot(*plot_args)
    pause mouse:"any"
    output fn+".png"
    reset
  end
end

sz = 150
x = Numo::DFloat.new(sz).seq(1)/sz*30

y = 6.times.map{|n| [x,Numo::GSL::Sf.bessel_Jn(n,x),w:"l",t:"bessel_J#{n}"]}
s = {title:"Regular Cylindrical Bessel Functions"}
gplot(y,s,"bessel_Jn")

y = 6.times.map{|n| [x,Numo::GSL::Sf.bessel_Yn(n,x),w:"l",t:"bessel_Y#{n}"]}
s = {title:"Irregular Cylindrical Bessel Functions",yrange:-2..1}
gplot(y,s,"bessel_Yn")

y = 6.times.map{|n| [x,Numo::GSL::Sf.bessel_In(n,x),w:"l",t:"bessel_I#{n}"]}
s = {title:"Regular Modified Cylindrical Bessel Functions",logscale:"xy"}
gplot(y,s,"bessel_In")

y = 6.times.map{|n| [x,Numo::GSL::Sf.bessel_Kn(n,x),w:"l",t:"bessel_K#{n}"]}
s = {title:"Irregular Modified Cylindrical Bessel Functions",logscale:"xy"}
gplot(y,s,"bessel_Kn")

y = 6.times.map{|n| [x,Numo::GSL::Sf.bessel_jl(n,x),w:"l",t:"bessel_j#{n}"]}
s = {title:"Regular Spherical Bessel Functions"}
gplot(y,s,"bessel_jl")

y = 6.times.map{|n| [x,Numo::GSL::Sf.bessel_yl(n,x),w:"l",t:"bessel_y#{n}"]}
s = {title:"Irregular Spherical Bessel Functions",yrange:-2..1}
gplot(y,s,"bessel_yl")

y = 6.times.map{|n| [x,Numo::GSL::Sf.bessel_il_scaled(n,x),w:"l",t:"bessel_i#{n}"]}
s = {title:"Regular Modified Spherical Bessel Functions",logscale:"xy"}
gplot(y,s,"bessel_il")

y = 6.times.map{|n| [x,Numo::GSL::Sf.bessel_kl_scaled(n,x),w:"l",t:"bessel_k#{n}"]}
s = {title:"Irregular Modified Spherical Bessel Functions",logscale:"xy"}
gplot(y,s,"bessel_kl")