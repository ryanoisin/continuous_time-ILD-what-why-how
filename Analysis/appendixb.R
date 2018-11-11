##################### Data Preperation ##################################

library(ctsem)

# Data is available from https://osf.io/c6xt4/download #
# Folder is ESMdata

#Load Data#
rawdata<-read.csv("./ESMdata/ESMdata.csv",header=TRUE, stringsAsFactors = FALSE)

#Select only measruements which take place in the control and initial (no medication reduciton) phase
rawdata<-subset(rawdata,rawdata$phase==1|rawdata$phase==2)

#Select only the variables of interest
sel<-c("mood_down","phy_tired")
data<-rawdata[,(names(rawdata) %in% sel)]

# Standardise the selected variables
for(j in 1:dim(data)[2]){
  data[,j]<-(data[,j]-mean(data[,j]))/sd(data[,j])
}

# Create a time vector which represents hours since first measurement
# This is the 'absolute time measurements' required by ctsem function ctIntervalise
t1<-as.POSIXct(paste(rawdata$date,rawdata$resptime_s),format="%d/%m/%y %H:%M:%S")
time<-as.numeric(difftime(t1,t1[1], units="hours"))

# Attach this time variable to the selected items
data$time=time

# Create an ID variable
data$id=rep(1,dim(data)[1])

# Rename pat_agitate = Y1, and event_import= Y2 for use with ctsem
colnames(data)=c("Y1","Y2","time","id")
# Get data in wide format for ctsem
datawide<-ctLongToWide(datalong=data,id="id",time="time",manifestNames=c("Y1","Y2"))

# Create time-interval variable
datawide<-ctIntervalise(datawide=datawide,Tpoints=dim(data)[1],
                        n.manifest=2,manifestNames=c("Y1","Y2"))

##################### Data analysis #####################################

# First specify the bivariate model, with 2 observed variables 
model <- ctModel(n.manifest = 2, n.latent= 2, Tpoints = 286,
                 LAMBDA = diag(nrow=2), 
                 MANIFESTMEANS = matrix(data=0, nrow=2, ncol=1), 
                 MANIFESTVAR = matrix(data=0, nrow=2, ncol=2),
                 DRIFT = "auto", 
                 CINT = matrix(data=0, nrow=2, ncol=1), 
                 DIFFUSION = "auto", 
                 TRAITVAR = NULL, 
                 MANIFESTTRAITVAR = NULL, 
                 startValues = NULL) 

# Fit the model to the data using carefulFit to get initial values
fit <- ctFit(dat = datawide, ctmodelobj = model, objective = "Kalman",
             stationary = c("T0VAR", "T0MEANS"), 
            iterationSummary = T, carefulFit = T, showInits = F, asymptotes = F,
             meanIntervals = F, 
             plotOptimization = F, nofit = F, discreteTime = F, 
             verbose = 0)

results<-summary(fit)

save(results,file="results.RData")
