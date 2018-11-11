############# Figures 1 and 3 ############
library(expm)

# First load the estimated drift matrix
load("./Analysis/results.RData")
Drift<-results$DRIFT

# Adjust size of plotting text
par(cex=1.25)

# set maximum delta t of interest
maxdt<-4

# create sequence of delta t's
dt<-seq(0,maxdt,.01)


################################### Create IRFs - Figure 1 ####################################

impulse_values<-matrix(c(1,0,
                         0,1,
                         1,1,
                         1,-1),4,2,byrow=TRUE)

for(i in 1:dim(impulse_values)[1]){
  blankirf<-array(data=NA,dim=c(dim(Drift)[2],1,length(dt)))
  for(j in 1:length(dt)){
    blankirf[,,j]<-expm(Drift*dt[j])%*%impulse_values[i,]
  }
  # Create name for plot based on impulse value
  name<-paste0("IRF",impulse_values[i,1],impulse_values[i,2],".pdf")
  
  # Write Image directly to PDF
  # pdf(name, width=6.83,height=6.83,useDingbats=F)
  plot(y=blankirf[1,1,],x=dt,
       type="l", ylim=c(-1, 1), 
       col="red",lwd=3, lty=1,
       xlab="t",ylab="Y(t)",
       font.lab=2)
  abline(h=0)
  lines(y=blankirf[2,1,],x=dt,col="blue",lwd=3, lty=2)
  legend(3.25,1, # places a legend at the appropriate place 
         c("Do(t)","Ti(t)"), # puts text in the legend
         lty=c(1,2), # gives the legend appropriate symbols (lines)
         lwd=c(3,3),
         col=c("red","blue")) # gives the legend lines the correct color and width
  # dev.off()
}


################################### Create IRFs - Figure 3 ####################################

# create blank array to hold expm(A*Delta t) for range of dt
blank<-array(data=NA,dim=c(2,2,length(dt)))

# Calculcate lagged effects at different delta t's 
for(i in 1:length(dt)){
  blank[,,i]<-expm(Drift*dt[i]) }

# pdf("laggedeffects.pdf", width=6.83,height=6.83,useDingbats=F)

plot(y=blank[1,1,],x=dt,type="l", ylim=c(min(blank), max(blank)),
        col="red",lwd=3, lty=6,
        xlab=expression(paste("Time-Interval ",Delta,"t")),ylab=expression(paste(Phi,"(",Delta,"t)")), font.lab=2)
abline(h=0)
lines(y=blank[2,2,],x=dt,col="blue",lwd=3, lty=3)
lines(y=blank[1,2,],x=dt, col="orange",lwd=3,lty=4)
lines(y=blank[2,1,],x=dt,col="purple",lwd=3,lty=5)
legend(3.25,1, # places a legend at the appropriate place 
       c(expression(paste(phi[11],"(",Delta,"t)")),expression(paste(phi[22],"(",Delta,"t)")),
       expression(paste(phi[12],"(",Delta,"t)")),expression(paste(phi[21],"(",Delta,"t)"))), # puts text in the legend
       lty=c(6,3,4,5), # gives the legend appropriate symbols (lines)
       lwd=c(3,3,3,3),
       col=c("red","blue","orange","purple")) # gives the legend lines the correct color and width
# dev.off()

