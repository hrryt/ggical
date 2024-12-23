
<!-- README.md is generated from README.Rmd. Please edit that file -->

# ggical

<!-- badges: start -->
<!-- badges: end -->

ggical extends ggplot2 to make plotting calendar data easy.

A ggplot2 geom, stat and theme are provided to plot the time of day of
events, designed to work with `ical` dataframes generated from the
calendar package.

ggical also provides reverse date, datetime, and time ggplot2 scales.

## Installation

You can install the development version of ggical like so:

``` r
# install.packages("devtools")
devtools::install_github("hrryt/ggical")
```

## Example

This is a basic example which shows you how to plot a weekly planner:

``` r
library(ggplot2)
library(ggical)

calendar <- timetable
calendar$date <- as.Date(calendar$DTSTART)
today <- as.Date("2024-11-24")                # Sys.Date()
now <- as.POSIXct("2024-11-24 20:20:00 GMT")  # Sys.time()

ggplot(calendar) +
  geom_planner(aes(date, ystart = DTSTART, ystop = DTEND, fill = SUMMARY)) +
  geom_planner(aes(today, ystart = now), col = "red", linewidth = 0.1) +
  scale_x_date(
    date_breaks = "1 day", labels = ~weekdays(.x, abbreviate = TRUE),
    limits = today + c(-0.5, 6.5)) +
  scale_y_time_reverse(
    breaks = hms::hms(hours = 21:9), labels = ~format(as.POSIXlt(.x), format = "%H:%M"),
    limits = hms::hms(hours = c(21, 9))) +
  theme_planner()
```

<img src="man/figures/README-x-1.png" width="100%" />

``` r
ggplot(calendar) +
  geom_planner(aes(y = date, xstart = DTSTART, xstop = DTEND, fill = SUMMARY)) +
  geom_planner(aes(y = today, xstart = now), col = "red", linewidth = 0.1) +
  scale_x_time(
    breaks = hms::hms(hours = 9:21), labels = ~format(as.POSIXlt(.x), format = "%H:%M"),
    limits = hms::hms(hours = c(9, 21)), guide = guide_axis(angle = 45)) +
  scale_y_date_reverse(
    date_breaks = "-1 day", labels = weekdays,
    limits = today + c(6.5, -0.5)) +
  theme_planner("y")
```

<img src="man/figures/README-y-1.png" width="100%" />
