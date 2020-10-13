require(data.table)
require(magrittr)
require(tidyverse)
require(lubridate)

t <-
  fread(
    "household_power_consumption.txt",
    header = TRUE,
    sep = ";",
    na.strings = "?",
    colClasses = c(
      'character',
      'character',
      'numeric',
      'numeric',
      'numeric',
      'numeric',
      'numeric',
      'numeric',
      'numeric'
    )
  )

## Format date to Type Date
t <- t[, Date := dmy(Date)]

## Filter data set from Feb. 1, 2007 to Feb. 2, 2007
t <- t[Date >= dmy('01/02/2007') & Date <= dmy('02/02/2007')]


## Remove incomplete observation
t <- t[complete.cases(t), ]

## Combine Date and Time column
dateTime <- paste(t[, Date], t[, Time])

## Name the vector
dateTime <- setNames(dateTime, "DateTime")

## Remove Date and Time column
t <- t[, c("Date", "Time") := NULL]

## Add DateTime column
t <- cbind(dateTime, t)

## Format dateTime Column
t <- t[, dateTime := ymd_hms(dateTime)]