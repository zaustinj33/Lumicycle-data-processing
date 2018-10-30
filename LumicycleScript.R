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
# Subset Raw data
Lumi <- data.frame(lumicycleRaw[,3:4])

ggplot() + 
  geom_line(data = Lumi, aes(x = Time..days., y = counts.sec), color = "red") +
  xlab('Time (days)') +
  ylab('counts/sec')