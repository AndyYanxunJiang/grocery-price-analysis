#### Preamble ####
# Purpose: Downloads and saves the data from spotify
# Author: Andy Jiang
# Date: 10 October 2024
# Contact: ayx.jiang@mail.utoronto.ca
# Pre-requisites: None


#### Workspace setup ####
library(tidyverse)
library(spotifyr)
library(readr)

#### Download data ####
radiohead <- get_artist_audio_features("radiohead")
saveRDS(radiohead, "data/01-raw_data/radiohead.rds")

coldplay <- get_artist_audio_features("coldplay")
saveRDS(coldplay, "data/01-raw_data/coldplay.rds")

beyonce <- get_artist_audio_features("beyonce")
saveRDS(beyonce, "data/01-raw_data/beyonce.rds")

