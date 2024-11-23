#' @rdname scale_date_reverse
#' @export

scale_x_datetime_reverse <- function(
    name = waiver(), breaks = waiver(), date_breaks = waiver(),
    labels = waiver(), date_labels = waiver(), minor_breaks = waiver(),
    date_minor_breaks = waiver(), timezone = NULL, limits = NULL,
    expand = waiver(), oob = scales::censor, guide = waiver(), position = "bottom",
    sec.axis = waiver()) {
  sc <- datetime_reverse_scale(
    c("x", "xmin", "xmax", "xend"), "time",
    name = name, palette = identity, breaks = breaks, date_breaks = date_breaks,
    labels = labels, date_labels = date_labels, minor_breaks = minor_breaks,
    date_minor_breaks = date_minor_breaks, timezone = timezone,
    guide = guide, limits = limits, expand = expand, oob = oob,
    position = position
  )
  ggplot2:::set_sec_axis(sec.axis, sc)
}

#' @rdname scale_date_reverse
#' @export

scale_y_datetime_reverse <- function(
    name = waiver(), breaks = waiver(), date_breaks = waiver(),
    labels = waiver(), date_labels = waiver(), minor_breaks = waiver(),
    date_minor_breaks = waiver(), timezone = NULL, limits = NULL,
    expand = waiver(), oob = scales::censor, guide = waiver(), position = "left",
    sec.axis = waiver()) {
  sc <- datetime_reverse_scale(
    c("y", "ymin", "ymax", "yend"), "time",
    name = name, palette = identity, breaks = breaks, date_breaks = date_breaks,
    labels = labels, date_labels = date_labels, minor_breaks = minor_breaks,
    date_minor_breaks = date_minor_breaks, timezone = timezone,
    guide = guide, limits = limits, expand = expand, oob = oob,
    position = position
  )
  ggplot2:::set_sec_axis(sec.axis, sc)
}
