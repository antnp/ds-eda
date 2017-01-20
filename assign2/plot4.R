# plot4.R

setwd("~/Dropbox/code/coursera/ds-eda/assign2")

library(dplyr)
library(ggplot2)
library(stringr)

# Load data
NEI <- readRDS("./data/exdata%2Fdata%2FNEI_data/summarySCC_PM25.rds")
SCC <- readRDS("./data/exdata%2Fdata%2FNEI_data/Source_Classification_Code.rds")

# Merge the NEI and SCC data
NEISCC <- merge(NEI, SCC, by = "SCC")

# confirm row count match
nrow(NEI) == nrow(NEISCC)

# Across the United States, how have emissions from coal combustion-related sources changed from 1999-2008?

# Create a row indicator for Coal using the stringr function
indCoal <- which(str_detect(NEISCC$EI.Sector, "Coal"))

# Group and summarize data for only records for Coal
by_year_coal <- NEISCC[indCoal,] %>%
  group_by(year) %>%
  summarise(
    rec_count = n(),
    sum_emission = sum(Emissions)
  )

# plot graph

png("plot4.png")
ggplot(data = by_year_coal, aes(year, sum_emission)) +
  geom_line() + geom_point() +
  xlab("Year") + ylab(expression('Total PM'[2.5]*" Emissions")) +
  ggtitle("Total US Coal Emissions")
dev.off()
