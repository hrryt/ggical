#' Day Planner
#'
#' @description
#' A 'ggplot2' geom and stat designed for easy visualization of
#' iCalendar data from [calendar][calendar::calendar].
#'
#' @inheritSection ggplot2::geom_bar Orientation
#'
#' @section Aesthetics:
#' `geom_planner()` understands the following aesthetics
#' (required aesthetics are in bold):
#' * **`x` *or* `y`**
#' * **`ymin` *or* `ymax`**
#' * **`ymax` *or* `xmax`**
#' * `alpha`
#' * `colour`
#' * `group`
#' * `linetype`
#' * `linewidth`
#'
#' Learn more about setting these aesthetics in `vignette("ggplot2-specs")`.
#'
#' `stat_count()` understands the following aesthetics
#' (required aesthetics are in bold):
#' * **`x` *or* `y`**
#' * **`ystart` *or* `xstart`**
#' * `yend`
#' * `xend`
#'
#' `*start` and `*end` aesthetics are coerced to `POSIXlt`.
#'
#' @section Computed variables:
#' These are calculated by the 'stat' part of layers and can be accessed with
#' [delayed evaluation][ggplot2::aes_eval].
#' * `after_stat(time)`\cr
#' time in hours after midnight of the start of each event
#' * `after_stat(timemax)`\cr
#' time in hours after midnight of the end of each event
#'
#' @inheritParams ggplot2::geom_bar
#' @examples
#' library(ggplot2)
#'
#' calendar <- timetable
#' calendar$date <- as.Date(calendar$DTSTART)
#' today <- as.Date("2024-11-24")                # Sys.Date()
#' now <- as.POSIXct("2024-11-24 20:20:00 GMT")  # Sys.time()
#'
#' ggplot(calendar) +
#'   geom_planner(aes(date, ystart = DTSTART, ystop = DTEND, fill = SUMMARY)) +
#'   geom_planner(aes(today, ystart = now), col = "red", linewidth = 0.1) +
#'   scale_x_date(
#'     date_breaks = "1 day", labels = ~weekdays(.x, abbreviate = TRUE),
#'     limits = today + c(-0.5, 6.5)) +
#'   scale_y_time_reverse(
#'     breaks = hms::hms(hours = 21:9), labels = ~format(as.POSIXlt(.x), format = "%H:%M"),
#'     limits = hms::hms(hours = c(21, 9))) +
#'   theme_planner()
#'
#' ggplot(calendar) +
#'   geom_planner(aes(y = date, xstart = DTSTART, xstop = DTEND, fill = SUMMARY)) +
#'   geom_planner(aes(y = today, xstart = now), col = "red", linewidth = 0.1) +
#'   scale_x_time(
#'     breaks = hms::hms(hours = 9:21), labels = ~format(as.POSIXlt(.x), format = "%H:%M"),
#'     limits = hms::hms(hours = c(9, 21)), guide = guide_axis(angle = 45)) +
#'   scale_y_date_reverse(
#'     date_breaks = "-1 day", labels = weekdays,
#'     limits = today + c(6.5, -0.5)) +
#'   theme_planner("y")
#'
#' @export

geom_planner <- function(
    mapping = NULL, data = NULL, stat = "planner", position = "identity",
    ..., fatten = 2.5, na.rm = FALSE, orientation = NA, show.legend = NA,
    inherit.aes = TRUE) {
  layer(data = data, mapping = mapping, stat = stat, geom = GeomPlanner,
        position = position, show.legend = show.legend, inherit.aes = inherit.aes,
        params = rlang::list2(fatten = fatten, na.rm = na.rm, orientation = orientation,
                              ...))
}

GeomPlanner <- ggplot2::ggproto(
  "GeomPlanner", ggplot2::GeomCrossbar,
  default_aes = ggplot2::aes(
    color = "black", fill = "white",
    linewidth = 0.5, linetype = 1, alpha = NA
  ),
  draw_key = ggplot2::draw_key_polygon
)
