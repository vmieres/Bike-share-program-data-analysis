install.packages(c('readr', 'ggplot2', 'tidyr'))
# # # # # # # # # # # # # # # # # # # # # # # 
# Install required packages
# tidyverse for data import and wrangling
# libridate for date functions
# ggplot for visualization
# # # # # # # # # # # # # # # # # # # # # # #  
library(tidyverse)  #helps wrangle data
library(lubridate)  #helps wrangle date attributes
library(ggplot2)  #helps visualize data
getwd() #displays your working directory
setwd('/cloud/project/Resources') #sets your working directory to simplify calls to data)

#=====================
# STEP 1: COLLECT DATA
#=====================
# Upload Divvy datasets (csv files) here
q1_2019 <- read_csv("Divvy_Trips_2019_Q1.csv")
q2_2019 <- read_csv("Divvy_Trips_2019_Q2.csv")
q3_2019 <- read_csv("Divvy_Trips_2019_Q3.csv")
q4_2019 <- read_csv("Divvy_Trips_2019_Q4.csv")

#====================================================
# STEP 2: WRANGLE DATA AND COMBINE INTO A SINGLE FILE
#====================================================
# Compare column names each of the files
# While the names don't have to be in the same order, they DO need to match perfectly before we can use a command to join them into one file
colnames(q1_2019)
colnames(q2_2019)
colnames(q3_2019)
colnames(q4_2019)

# Rename columns  to make them consistent with q4_2019 (as this will be the supposed going-forward table design for Divvy)

(q3_2019 <- rename(q3_2019
                   ,ride_id = trip_id 
                   ,rideable_type = bikeid 
                   ,started_at = start_time  
                   ,ended_at = end_time  
                   ,start_station_name = from_station_name 
                   ,start_station_id = from_station_id 
                   ,end_station_name = to_station_name 
                   ,end_station_id = to_station_id 
                   ,member_casual = usertype))
(q2_2019 <- rename(q2_2019
                   ,ride_id = ride_id
                   ,rideable_type = rideable_type 
                   ,started_at = started_at  
                   ,ended_at = ended_at  
                   ,start_station_name = start_station_name 
                   ,start_station_id = start_station_id
                   ,end_station_name = end_station_name 
                   ,end_station_id = end_station_id
                   ,member_casual = member_casual))

(q1_2019 <- rename(q1_2019
                   ,ride_id = ride_id
                   ,rideable_type = rideable_type
                   ,started_at = started_at  
                   ,ended_at = ended_at  
                   ,start_station_name = start_station_name 
                   ,start_station_id = start_station_id 
                   ,end_station_name = end_station_name 
                   ,end_station_id = end_station_id 
                   ,member_casual = member_casual))

# Inspect the dataframes and look for incongruencies
str(q1_2019)
str(q4_2019)
str(q3_2019)
str(q2_2019)

# Convert ride_id and rideable_type to character so that they can stack correctly
q3_2019 <-  mutate(q3_2019, ride_id = as.character(ride_id)
                   ,rideable_type = as.character(rideable_type)) 

q2_2019 <-  mutate(q2_2019, ride_id = as.character(ride_id)
                   ,rideable_type = as.character(rideable_type)) 

q1_2019 <-  mutate(q1_2019, ride_id = as.character(ride_id)
                   ,rideable_type = as.character(rideable_type)) 

# Stack individual quarter's data frames into one big data frame
all_trips <- bind_rows(q2_2019, q3_2019, q4_2019, q1_2020)

