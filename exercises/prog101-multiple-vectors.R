# What does the following code do?
# Tip: `%%` is the remainder operator. E.g. 10 %% 4 is 2.
instrument_deployed_hm <- c(730, 915, 1345)
#tells you the time the instrument was deployed
instrument_deployed_h <- floor(instrument_deployed_hm / 100)
#changes the time into a decimal
instrument_deployed_hdec <- (instrument_deployed_hm %% 100) / 60
#increments of an hour in decimal
instrument_deployed <- instrument_deployed_h + instrument_deployed_hdec
#it adds the decimals together

# Based on the code above, calculate the duration of instrument deployments
# using the instrument recovery times below. What units do the durations have?
instrument_recovered_hm <- c(1600, 1920, 2015)
instrument_recovered_h <- floor(instrument_recovered_hm / 100)
instrument_recovered_hdec <- (instrument_recovered_hm %% 100) / 60
instrument_recovered <- instrument_recovered_h + instrument_recovered_hdec

instrument_durations <- instrument_recovered - instrument_deployed

# Which site had the longest duration? Use conditional indexing.
site <- c("Santa Cruz", "Santa Rosa", "San Miguel")
instrument_durations == max (instrument_durations)
#santa rosa was the longest duration
