sysuse auto,clear
* actual case
tw (line price weight ,sort) , title("Original: we want to truncate y axis ")
graph export "fig1.png",replace
* using yscale
tw (line price weight ,sort ),yscale(r(0 10000)) title("Using 'yscale(r(0 10000)' ")
graph export "fig2.png",replace
* using ylab
tw (line price weight ,sort ), ylab(0(2500)10000) title("using 'ylab(0(2500)10000)'")
graph export "fig3.png",replace
* using "if"
tw (line price weight if price<10000,sort ),title("using if price<10000'")
graph export "fig4.png",replace
* ad hoc solution
* 1 collapse to have one observation per value on the x axis
	collapse (mean) price, by(weight) fast
	sort weight
* 2 calculate gaps beween observations
	gen difweight=weight[_n+1]-weight
	gen difprice=price[_n+1]-price
* 3 create values for extrapolation, the higher value we multiply with, the more accurate
	expand difweight*1000
	sort weight
* 4 linear interpolation (multiply by same number as above!)
	bys weight: gen counter=_n
	gen interpolate_price=price+difprice*((counter-1)/(difweight*1000))
	gen interpolate_weight=weight+difweight*((counter-1)/(difweight*1000))
* create chart using small dots
tw (scatter interpolate_price interpolate_weight if interpolate_price<10000 , msize(vtiny) msymbol(.)) ///
	,title("Using 'manual approach'")
	graph export "fig5.png",replace
