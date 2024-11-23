#' @rdname scale_date_reverse
#' @export

scale_x_time_reverse <- function (
    name = waiver(), breaks = waiver(), minor_breaks = waiver(),
    labels = waiver(), limits = NULL, expand = waiver(), oob = scales::censor,
    na.value = NA_real_, guide = waiver(), position = "bottom",
    sec.axis = waiver()) {
  scale_x_continuous(
    name = name, breaks = breaks, labels = labels,
    minor_breaks = minor_breaks, limits = limits, expand = expand,
    oob = oob, na.value = na.value, guide = guide, position = position,
    trans = scales::compose_trans(scales::hms_trans(), scales::reverse_trans()),
    sec.axis = sec.axis
  )
}

#' @rdname scale_date_reverse
#' @export

scale_y_time_reverse <- function (
    name = waiver(), breaks = waiver(), minor_breaks = waiver(),
    labels = waiver(), limits = NULL, expand = waiver(), oob = scales::censor,
    na.value = NA_real_, guide = waiver(), position = "left",
    sec.axis = waiver()) {
  scale_y_continuous(
    name = name, breaks = breaks, labels = labels,
    minor_breaks = minor_breaks, limits = limits, expand = expand,
    oob = oob, na.value = na.value, guide = guide, position = position,
    trans = scales::compose_trans(scales::hms_trans(), scales::reverse_trans()),
    sec.axis = sec.axis
  )
}
