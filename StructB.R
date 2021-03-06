Total_ELN_HRV_AR<-read.csv(TS_ELN_HRV_AR)
Total_FARC_HRV_CA<-read.csv(TS_FARC_HRV_CA)

### (9) Structural changes ####

# Create a Time Series Towers, ELN and FARC HRV
library(xts)
library(tseries)
ELN_HRV <- ts(Total_ELN_HRV_AR$ELN_HRV, start=c(1990,1), end=c(2015,12), frequency=12)
plot(ELN_HRV,xaxt="n" ,main="ELN Human Rights Violations in ARAUCA", xlab="Year", ylab="")
axis(1, at=seq(1990,2015, by=1),las=2)
# Run the structural change analysis
library(strucchange)
#bp_ts <- breakpoints(ELN_HRV ~ 1, h=0.25, breaks=2)

bp_ts <- breakpoints(ELN_HRV ~ 1)
summary(bp_ts)

#ci_ts<-confint(bp_ts, breaks = 1)
ci_ts<-confint(bp_ts)
lines(bp_ts)
lines(ci_ts)
legend("topright", c("Breakpoints","Confidence Interval"), # puts text in the legend
       lty=c(2,1), # gives the legend appropriate symbols (lines)
       lwd=c(2.5,2.5),col=c("black","red")) # gives the legend lines the correct color and width

res<-residuals(bp_ts)
acf(res)
pacf(res)

fs.ELN_HRV <- Fstats(ELN_HRV ~ 1)
plot(fs.ELN_HRV)
sctest(fs.ELN_HRV)
lines(breakpoints(fs.ELN_HRV))


FARC_HRV <- ts(Total_FARC_HRV_CA$FARC_HRV, start=c(1990,1), end=c(2015,12), frequency=12)
plot(FARC_HRV,xaxt="n" ,main="FARC Human Rights Violations in Cauca", xlab="Year", ylab="")
axis(1, at=seq(1990,2015, by=1),las=2)


bp_ts <- breakpoints(FARC_HRV ~ 1)
summary(bp_ts)
ci_ts<-confint(bp_ts)
lines(bp_ts)
lines(ci_ts)
legend("topright", c("Breakpoints","Confidence Interval"), # puts text in the legend
       lty=c(2,1), # gives the legend appropriate symbols (lines)
       lwd=c(2.5,2.5),col=c("black","red")) # gives the legend lines the correct color and width

fs.FARC_HRV <- Fstats(FARC_HRV ~ 1)
plot(fs.FARC_HRV)
lines(breakpoints(fs.FARC_HRV))
sctest(fs.FARC_HRV)
