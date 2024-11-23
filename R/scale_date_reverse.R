#' Position scale for date/time reverse data
#'
#' @description
#' A composition of the [`scale_x_date()`][ggplot2::scale_x_date()] etc. and
#' [`scale_x_reverse()`][ggplot2::scale_x_reverse()] 'ggplot2' scales.
#'
#' @inheritParams ggplot2::scale_x_date
#'
#' @seealso [datetime_reverse_scale()]
#'
#' @rdname scale_date_reverse
#' @inherit geom_planner examples
#' @export

scale_x_date_reverse <- function(
    name = waiver(), breaks = waiver(), date_breaks = waiver(),
    labels = waiver(), date_labels = waiver(), minor_breaks = waiver(),
    date_minor_breaks = waiver(), limits = NULL, expand = waiver(),
    oob = scales::censor, guide = waiver(), position = "bottom", sec.axis = waiver()) {
  sc <- datetime_reverse_scale(
    c("x", "xmin", "xmax", "xend"), "date",
    name = name, palette = identity, breaks = breaks, date_breaks = date_breaks,
    labels = labels, date_labels = date_labels, minor_breaks = minor_breaks,
    date_minor_breaks = date_minor_breaks, guide = guide,
    limits = limits, expand = expand, oob = oob, position = position
  )
  ggplot2:::set_sec_axis(sec.axis, sc)
}

#' @rdname scale_date_reverse
#' @export

scale_y_date_reverse <- function(
    name = waiver(), breaks = waiver(), date_breaks = waiver(),
    labels = waiver(), date_labels = waiver(), minor_breaks = waiver(),
    date_minor_breaks = waiver(), limits = NULL, expand = waiver(),
    oob = scales::censor, guide = waiver(), position = "left", sec.axis = waiver()) {
  sc <- datetime_reverse_scale(
    c("y", "ymin", "ymax", "yend"), "date",
    name = name, palette = identity, breaks = breaks, date_breaks = date_breaks,
    labels = labels, date_labels = date_labels, minor_breaks = minor_breaks,
    date_minor_breaks = date_minor_breaks, guide = guide,
    limits = limits, expand = expand, oob = oob, position = position
  )
  ggplot2:::set_sec_axis(sec.axis, sc)
}
