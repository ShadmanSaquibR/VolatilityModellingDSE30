import excel "C:\Users\Shadman Rahman\Desktop\Study_Materials\Semester 8\Monograph exploration\Data\Mainframe.xlsx", sheet("Sheet1") cellrange(A1:B139) firstrow clear
br
gen monthdate = mofd( date)
format monthdate %tm
br
tsset monthdate
*outlier test
graph box DSE30
rename DSE30 price
*Lag selection for ADF test
varsoc price, maxlag(15)
*Results show max lag is 2, let's use it for Dickey Fuller test
dfuller price, nocons lags(2)
dfuller price, drift lags(2)
dfuller price, regress trend lags(2)

gen returns = D.price
tsline returns

dfuller returns, nocons lags(2)
dfuller returns, drift lags(2)
dfuller returns,regress trend lags(2)

*Box Jenkins time 
ac returns, saving(acr)
pac returns, saving(pacr)
graph combine acr.gph pacr.gph 
*helps produce multiple graphs at once
*Results point to MA(4)?
arimaauto returns, nocons arima 

*Box Jenkins time
arima returns, ma(1) nocons
predict uhat1, residual
wntestq uhat1
estat ic

arima returns, ma(2) nocons
predict uhat2, residual
wntestq uhat2
estat ic

arima returns, ma(3) nocons
predict uhat3, residual
wntestq uhat3
estat ic

arima returns, ma(4) nocons
predict uhat4, residual
wntestq uhat4
estat ic

arima returns, ma(5) nocons
predict uhat5, residual
wntestq uhat5
estat ic

arima returns, ar(1) nocons
predict u1, residual
wntestq u1
estat ic 

arima returns, ar(2) nocons
predict u2, residual
wntestq u2
estat ic 

arima returns, ar(3) nocons
predict u3, residual
wntestq u3
estat ic 

arima returns, ar(5) nocons
predict u5, residual
wntestq u5
estat ic 


arima returns, ar(1) ma(1) nocons
predict u11, residual
wntestq u11
estat ic 

arima returns, ar(1) ma(2) nocons
predict u12, residual
wntestq u12
estat ic 

arima returns, ar(2) ma(1) nocons
predict u21, residual
wntestq u21
estat ic

arima returns, ar(2) ma(2) nocons
predict u22, residual
wntestq u22
estat ic

arima returns, ar(2) ma(3) nocons
predict u23, residual
wntestq u23
estat ic

arima returns, ar(2) ma(4) nocons
predict u24, residual
wntestq u24
estat ic

arima returns, ar(2) ma(5) nocons
predict u25, residual
wntestq u25
estat ic

arima returns, ar(3) ma(2) nocons
predict u32, residual
wntestq u32
estat ic

arima returns, ar(3) ma(3) nocons
predict u33, residual
wntestq u33

estat ic

arima returns, ar(3) ma(4) nocons
predict u34, residual
wntestq u34
estat ic

arima returns, ar(3) ma(1) nocons
predict u31, residual
wntestq u31
estat ic

arima returns, ar(4) ma(1) nocons
predict u41, residual
wntestq u41
estat ic

arima returns, ar(4) ma(2) nocons
predict u42, residual
wntestq u42
estat ic

arima returns, ar(4) ma(3) nocons
predict u43, residual
wntestq u43
estat ic

arima returns, ar(4) ma(4) nocons
predict u44, residual
wntestq u44
estat ic

arima returns, ar(4) ma(5) nocons
predict u45, residual
wntestq u45
estat ic

arima returns, ar(1) ma(3) nocons
predict u13, residual
wntestq u13
estat ic

arima returns, ar(1) ma(4) nocons
predict u14, residual
wntestq u14
estat ic

arima returns, ar(1) ma(5) nocons
predict u15, residual
wntestq u15
estat ic

arima returns, ar(1) ma(6) nocons
predict u16, residual
wntestq u16
estat ic

arima returns, ar(1) ma(7) nocons
predict u17, residual
wntestq u17
estat ic

arima returns, ar(2) ma(5) nocons
predict u25, residual
wntestq u25
estat ic

arima returns, ar(3) ma(5) nocons
predict u35, residual
wntestq u35
estat ic

arima returns, ar(4) ma(5) nocons
predict u45, residual
wntestq u45
estat ic

arima returns, ar(5) ma(1) nocons
predict u51, residual
wntestq u51
estat ic

arima returns, ar(5) ma(2) nocons
predict u52, residual
wntestq u52
estat ic

arima returns, ar(5) ma(3) nocons
predict u53, residual
wntestq u53
estat ic

arima returns, ar(5) ma(4) nocons
predict u54, residual
wntestq u54
estat ic


arima returns, ar(5) ma(5) nocons
predict u55, residual
wntestq u55
estat ic

*From the models test, only ARMA(1,5), passed the Q-test to ensure the residuals follow a white-noise process 
*Using Akaike Information Criterion (AIC) and Bayesian Information Criterion (BIC), ARMA (1,2) has the lowest score
*Now that we know that returns (difference in daily price) follows a stationary ARMA(1,2), we can check if the series is homoskedastic 
gen u15sq = u15*u15
tsline u15sq
histogram u15, normal 
*from the graph it is apparent that residual squared or the variance of the time series: returns is HETEROSKEDASTIC 
*from the histogram we can see it doesn't follow normal distribution either
*Carrying out ARCH LM test to see if this model is suitable
reg u15
estat archlm, lags(1/15)

*Results show ARCH/GARCH model maynot be suitable as Prob>Chi2 is way greater than 0.05 for all lag values 
arch returns ,arch(1)
estat ic

arch returns ,arch(2)
estat ic

arch returns, arch(3)
estat ic

arch returns, arch(4)
estat ic

arch returns, arch(5)
estat ic

arch returns, arch(6)
estat ic
*Garch


arch returns,arch(1) garch(1)
estat ic
*garch(1,2)
arch returns,arch(1) garch(2)
estat ic

arch returns,arch(1) garch(3)
estat ic

arch returns,arch(1) garch(4)
estat ic

arch returns,arch(1) garch(5)
estat ic

arch returns,arch(1) garch(6)
estat ic

arch returns,arch(1/2) garch(1)
estat ic

arch returns,arch(1/2) garch(2)
estat ic

arch returns,arch(1/3) garch(1)
estat ic

arch returns,arch(1/4) garch(1)
estat ic
*egarch 
arch returns, earch(1/1) egarch(1/1)
estat ic

arch returns, earch(1/2) egarch(1)
estat ic

arch returns, earch(1/3) egarch(1)
estat ic

arch returns, earch(1/4) egarch(1)
estat ic

arch returns, earch(1) egarch(1/2)
estat ic

arch returns, earch(1/2) egarch(1/2)
estat ic

arch returns, earch(1/2) egarch(1/2)
estat ic

arch returns, earch(1/3) egarch(1/2)
estat ic

arch returns, earch(1/4) egarch(1/2)
estat ic

arch returns, earch(1) egarch(1/3)
estat ic

arch returns, earch(2) egarch(1/3)
estat ic
*tarch
arch returns, abarch(1/1) atarch(1/1) sdgarch(1/1)
estat ic

arch returns, abarch(1/1) atarch(1/1) sdgarch(1/2)
estat ic

arch returns, abarch(1/2) atarch(1/1) sdgarch(1/1)
estat ic

*ARMA-ARCH

arch returns , ar(1) ma(5) arch(1)
estat ic

arch returns , ar(1) ma(5) arch(2)
estat ic

arch returns , ar(1) ma(5) arch(3)
estat ic

arch returns , ar(1) ma(5) arch(5)
estat ic

arch returns , ar(1) ma(5) arch(6)
estat ic

arch returns , ar(1) ma(5) arch(7)
estat ic

arch returns , ar(1) ma(4) arch(1)
estat ic

arch returns , ar(1) ma(4) arch(2)
estat ic

arch returns , ar(1) ma(4) arch(3)
estat ic

arch returns , ar(1) ma(4) arch(5)
estat ic

arch returns , ar(1) ma(4) arch(6)
estat ic

arch returns , ar(1) ma(4) arch(7)
estat ic

arch returns ,  ar(1) ma(4) arch(1) garch(1)
estat ic 

arch returns ,  ar(1) ma(5) arch(1) garch(1)
estat ic 

arch returns ,  ar(1) ma(5) arch(1) garch(2)
estat ic 

arch returns ,  ar(1) ma(5) arch(1) garch(3)
estat ic 

arch returns ,  ar(1) ma(5) arch(1) garch(4)
estat ic 

arch returns ,  ar(1) ma(5) arch(1) garch(5)
estat ic 

arch returns ,  ar(1) ma(5) arch(1) garch(6)
estat ic 

arch returns ,  ar(1) ma(5) arch(1) garch(7)
estat ic 

arch returns ,  ar(1) ma(5) arch(1) garch(8)
estat ic 

arch returns ,  ar(1) ma(5) arch(1) garch(9)
estat ic 

arch returns ,  ar(1) ma(5) arch(1/2) garch(2)
estat ic

arch returns ,  ar(1) ma(5) arch(1/2) garch(1)
estat ic 

arch returns ,  ar(1) ma(5) arch(1/2) garch(3)
estat ic 

arch returns ,  ar(1) ma(5) arch(1/7) garch(1)
estat ic 

arch returns ,  ar(1) ma(5) arch(1/9) garch(1)
estat ic 

arch returns , ar(1) ma(5) arch(1/10) garch(1)
estat ic 

arch returns ,  ar(1) ma(5) arch(1/11) garch(1)
estat ic 

arch returns ,  ar(1) ma(5) arch(1/13) garch(1)
estat ic 

*ARMA-GARCH

arch returns, ar(1) ma(4) earch(1/1) egarch(1/1)
estat ic

arch returns, ar(1) ma(4) earch(1/2) egarch(1)
estat ic

arch returns, ar(1) ma(5) earch(1/1) egarch(1/1)
estat ic

arch returns, ar(1) ma(5) earch(1/4) egarch(1)
estat ic

*wait

arch returns, ar(1) ma(5) earch(1/2) egarch(1)
estat ic

arch returns, ar(1) ma(5) earch(1/3) egarch(1)
estat ic

arch returns, ar(1) ma(5) earch(1/4) egarch(1)
estat ic

arch returns, ar(1) ma(5) earch(1/5) egarch(1)
estat ic

arch returns, ar(1) ma(5) earch(1) egarch(1/2)
estat ic

arch returns, ar(1) ma(5) earch(1/2) egarch(1/2)
estat ic

arch returns, ar(1) ma(5) earch(1/3) egarch(1/2)
estat ic
*ARMA-TARCH\
arch returns, abarch(1/1) atarch(1/1) sdgarch(1/1)
estat ic

arch returns, abarch(1/2) atarch(1/1) sdgarch(1/1)
estat ic

arch returns, abarch(1) atarch(1/2) sdgarch(1/1)
estat ic

arch returns, abarch(1) atarch(1/3) sdgarch(1/1)
estat ic

*Results show that for GARCH(13,1) model, flat log likelihood has been encountered so this model is overdetermined

arch returns ,  ar(1) ma(5) arch(1/5) garch(2)
estat ic 

arch returns ,  ar(1) ma(5) arch(1/2) garch(2)
estat ic 

*best model is ARMA(1,5) GARCH(2,5)
arch returns ,  ar(1) ma(5) arch(1/5) garch(2)
estat ic 
tsappend, add(6)
predict varhat,variance 

*even better model
arch returns, earch(1) egarch(1/3)
estat ic 
predict varfork, variance 
*Forecasting 
tsline u15sq varegarch13

