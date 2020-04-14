# stata_truncated_chart
 
* Goal: create charts with truncated axis in Stata
* Challenge: Stata always shows all data
* Solution: interpolate data points and show as scatter plot

20200413: Uploaded proof of concept

**The raw chart**

<img src="fig1.png" width="300">

**Often suggested solution 1: use** *yscale*

 *  Challenge: only works for extending the scale, can never be smaller than the data range. 

<img src="fig2.png" width="300">

**Often suggested solution 2: use** *ylab*

 *  Challenge: only affects labels, not axis range.
 

<img src="fig3.png" width="300">

**Often suggested solution 3: use** *if*

 *  Challenge: changes the relationship to show
 

<img src="fig4.png" width="300">


**My solutioon**

* Interpolate data points
* See Stata do file for proof of concept.
* Challenge: line gets a bit rugged...

<img src="fig5.png" width="300">
