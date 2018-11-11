# To create Figures 2 and 4 of the book chapter - Vector fields
library(phaseR)

# First load the estimated drift matrix
#setwd("C:/Users/F111848/Dropbox/CT Book chapter/Empirical Example/Analysis")
#load("results.RData")
#Drift<-results$DRIFT


Drift<-matrix(c(-0.9949479,  0.5726656,
 0.3754729, -2.4164793),2,2,byrow=T)

# Set directory ot the figures folder
# setwd("C:/Users/F111848/Dropbox/CT Book chapter/Figures")

# Define a function reflecitng the differential equation
OU <- function(t, y, parameters) {
  x <- y[1]
  y <- y[2]
  A11 <- parameters[1]
  A12 <- parameters[2]
  A21 <- parameters[3]
  A22 <- parameters[4]
  dy <- numeric(2)
  dy[1] <- A11*x + A12*y
  dy[2] <- A21*x + A22*y
  list(dy)
}

# Set a range - axis limits of the vector field plot
Range = 1
xlim = c(-Range, Range)
ylim = c(-Range, Range)

###################### Figure 2 ########################

# Parameters to pass in flowField()
parameters_mxA = c(Drift[1,1], Drift[1,2], Drift[2,1], Drift[2,2])
setwd("C:/Users/F111848/surfdrive/Work/Research/Presentations/CCS Sep 2018")
  # pdf("VF_gen.pdf", width=6.83,height=6.83,useDingbats=F)
 pdf("VF_gen_traj.pdf", width=6.83,height=6.83,useDingbats=F)

OU.flowField <- flowField(OU, xlim = xlim, ylim = ylim,
                          parameters = parameters_mxA, points = 11, add = FALSE,
                          arrow.type = "proportional",
                          xlab=expression(Y[1](t)),ylab=expression(Y[2](t)),cex=10,font.lab=5,
                          yaxt="n",xaxt="n",
                          cex.lab=1.5, mgp=c(2,1,.5))
grid()
OU.nullclines <- nullclines(OU, xlim = c(xlim[1]-Range/5, xlim[2]+Range/5), ylim = c(ylim[1]-Range/5, ylim[2]+Range/5),
                            parameters = parameters_mxA, points = 500, col=c("red","blue"),
                            add.legend=F)

start_values<-matrix(c(1,0,
                       0,1,
                       1,1,
                       1,-1),4,2,byrow=TRUE)
# sv_labels<-c("a)","b)","c)","d)")

# Position the labels slightly offset from the trajectory starting point
# sv_labels_pos<-start_values
# # sv_labels_pos<-matrix(c(1.1,0,
#                         0,1.1,
#                         1,1.1,
#                         1,-1.1),4,2,byrow=TRUE)


 for(i in 1:dim(start_values)[1]){

  OU.trajectory <- trajectory(OU, y0 = start_values[i,], tlim= c(0,100), # t.end = 10
                              parameters = parameters_mxA, col = rep("black", 3),
                              add = TRUE)
  # text(x=sv_labels_pos[i,1],y=sv_labels_pos[i,2],labels=sv_labels[i])
}
dev.off()


###################### Figure 4 ########################
Driftalt<-Drift
Driftalt[2,1]=-2

parameters_mxA = c(Driftalt[1,1], Driftalt[1,2], Driftalt[2,1], Driftalt[2,2])

pdf("stablespiralVF.pdf", width=6.83,height=6.83,useDingbats=F)

OU.flowField <- flowField(OU, x.lim = xlim, y.lim = ylim,
                          parameters = parameters_mxA, points = 20, add = FALSE,
                          arrow.type = "proportional",
                          xlab=expression(y[1](t)),ylab=expression(y[2](t)),cex=1.25,font.lab=2)
grid()
OU.nullclines <- nullclines(OU, x.lim = c(xlim[1]-Range/5, xlim[2]+Range/5), y.lim = c(ylim[1]-Range/5, ylim[2]+Range/5),
                            parameters = parameters_mxA, points = 500,colour=c("blue","red"))

start_values<-matrix(c(1,0,
                       0,1,
                       1,1,
                       1,-1),4,2,byrow=TRUE)

for(i in 1:dim(start_values)[1]){
  OU.trajectory <- trajectory(OU, y0 = start_values[i,], t.end = 100, # t.end = 10
                              parameters = parameters_mxA, colour = rep("black", 3),
                              add = TRUE)
  text(x=sv_labels_pos[i,1],y=sv_labels_pos[i,2],labels=sv_labels[i])
}
dev.off()


