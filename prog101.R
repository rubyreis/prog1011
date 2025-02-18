##########################################################################
## Driver: (Name) (GitHub Handle)                                       ##
## Navigator: (Name) (GitHub Handle)                                    ##
## Date: (YYYY-MM-DD)                                                   ##
##########################################################################

library(marinecs100b)

# Guiding questions -------------------------------------------------------

# What does KEFJ stand for?
#Kenai Fyords National Park

# How was temperature monitored?
#HOBO loggers

# What's the difference between absolute temperature and temperature anomaly?
#Absolute temperature is the measurement recorded by the sensor
#The anomaly is the average temperate

# Begin exploring ---------------------------------------------------------

# How many kefj_* vectors are there?
# 6
# How long are they?
# 1295038

# What do they represent?
# Temperature , the time of reading, the date, tide and what season it is

# Link to sketch

harris_datetime <- kefj_datetime[kefj_site == "Harris"]
harris_interval <- harris_datetime[2:length(harris_datetime)] - harris_datetime[1:length(harris_datetime)-1]
table(harris_interval)


# Problem decomposition ---------------------------------------------------

# When and where did the hottest and coldest air temperature readings happen?

# Link to sketch

# Plot the hottest day

hottest_idx <- which.max(kefj_temperature)
hottest_time <- kefj_datetime[hottest_idx]
hottest_site <- kefj_site[hottest_idx]
hotday_start <- as.POSIXct("2018-07-03 00:00", tz = "Etc/GMT+8")
hotday_end <- as.POSIXct("2018-07-04 00:00", tz = "Etc/GMT+8")
hotday_idx <- kefj_site == hottest_site &
  kefj_datetime >= hotday_start &
  kefj_datetime <= hotday_end
hotday_datetime <- kefj_datetime[hotday_idx]
hotday_temperature <- kefj_temperature[hotday_idx]
hotday_exposure <- kefj_exposure[hotday_idx]
plot_kefj(hotday_datetime, hotday_temperature, hotday_exposure)

# Repeat for the coldest day
coldest_idx <- which.min(kefj_temperature)
coldest_time <- kefj_datetime[coldest_idx]
coldest_site <- kefj_site[coldest_idx]
coldday_start <- as.POSIXct("2013-01-27 00:00", tz = "Etc/GMT+8")
coldday_end <- as.POSIXct("2013-01-28 00:00", tz = "Etc/GMT+8")
coldday_idx <- kefj_site == coldest_site &
  kefj_datetime >= coldday_start &
  kefj_datetime <= coldday_end
coldday_datetime <- kefj_datetime[coldday_idx]
coldday_temperature <- kefj_temperature[coldday_idx]
coldday_exposure <- kefj_exposure[coldday_idx]
plot_kefj(coldday_datetime, coldday_temperature, coldday_exposure)

# What patterns do you notice in time, temperature, and exposure? Do those
# patterns match your intuition, or do they differ?
# In both graphs, when only exposed to water, the temperature is more neutral, but temperature
# reaches more extremes when exposed to air. This does match my intuition because
# temperature is often more regulated in water.

# How did Traiger et al. define extreme temperature exposure?

# Translate their written description to code and calculate the extreme heat
# exposure for the hottest day.
extreme_time_hot <- kefj_site == hottest_site &
  kefj_datetime <= hotday_start &
  kefj_datetime <= hotday_end

extreme_temp_hot <- kefj_temperature[extreme_time_hot] <= -4

extreme_temp_exp_hot <- (extreme_temp_hot == "TRUE") / 2
extreme_temp_exp_hot
sum(extreme_temp_exp_hot)

# Compare your answer to the visualization you made. Does it look right to you?

# Repeat this process for extreme cold exposure on the coldest day.
extreme_time_cold <- kefj_site == coldest_site &
  kefj_datetime <= coldday_start &
  kefj_datetime <= coldday_end

extreme_temp_cold <- kefj_temperature[extreme_time_cold] <= -4

extreme_temp_exp_cold <- (extreme_temp_cold == "TRUE") / 2
extreme_temp_exp_cold
sum(extreme_temp_exp_cold)


# Putting it together -----------------------------------------------------

# Link to sketch

# Pick one site and one season. What were the extreme heat and cold exposure at
# that site in that season?

# Repeat for a different site and a different season.

# Optional extension: Traiger et al. (2022) also calculated water temperature
# anomalies. Consider how you could do that. Make a sketch showing which vectors
# you would need and how you would use them. Write code to get the temperature
# anomalies for one site in one season in one year.
