### Lumicycle data reading and analysis

## 1: Import data from directories
library(data.table)
workpath = "~/R/ExcelData"

# Read csv file
lumicycleFile = paste(workpath, "/2018-9-18 BL8-1_Raw.csv", sep = "") 
# Define col names
headers = read.csv(lumicycleFile, skip = 1, header = F, nrows = 1, as.is = T)
# Output raw csv
lumicycleRaw <- read.csv(lumicycleFile, sep = ",", skip = 3, col.names = headers, header = T)
# Subset Raw data - only include data after day 1, counts and time (days)
Lumi <- data.frame(lumicycleRaw[lumicycleRaw$Time..days. >= 1,3:4])


ggplot() + 
  geom_point(data = Lumi, aes(x = Time..days., y = counts.sec), color = "red", se = F) +
  xlab('Time (days)') +
  ylab('counts/sec')

## Branches:
# Oscillation modeling - return amp, phase, period values for each graph/set

# model:
l <- 1
m <- 1
a <- 1 #amplitude
b <- 1
c <- 1 
phi <- 1 #period?
tau <- 1 #phase?
t <- Lumi$Time..days.
counts <- Lumi$counts.sec
# find the parameters for the equation
SS <- getInitial(counts ~ SSlogis(Lumi$counts.sec,alpha,xmid,scale), Lumi)
# Simplified equation
f_simple <- formula(counts ~ A + A1*cos(WT) + B*sin(WT))
# define formula
f <- formula(counts  ~ l*m*t + t^2 + (a + b*t + c*t^2) * sin(2*pi*((t-phi)/tau)))

m <-  nls(f, Lumi, SS)
# batch processing - input 2 directories (each with multiple files). Output anova analysis for 
# Var 1 and Var 2