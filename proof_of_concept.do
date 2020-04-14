sysuse auto,clear
collapse (mean) price, by(weight) fast
* show raw chart
tw (line price weight ,sort) 
graph export "fig1.png",replace
* ad hoc solution
* 1 sort by x axis
	sort weight
* 2 calculate gaps beween observations
	gen difweight=weight[_n+1]-weight
	gen difprice=price[_n+1]-price
* 3 create values for extrapolation, the higher value we multiply with, the more accurate
	expand difweight*100 /* the number of points to interpolate */
	sort weight
* 4 linear interpolation (multiply by same number as above!)
	bys weight: gen counter=_n
	gen interpolate_price=price+difprice*((counter-1)/(difweight*100))
	gen interpolate_weight=weight+difweight*((counter-1)/(difweight*100))
* create chart using interpolation approach
	replace interpolate_price=. if interpolate_price>=10000
	tw (line interpolate_price interpolate_weight   , cmissing(n) ) 
	graph export "fig2.png",replace
