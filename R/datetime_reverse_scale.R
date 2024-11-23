#' Date/time reverse scale constructor
#'
#' @inheritParams ggplot2::datetime_scale
#'
#' @seealso [scale_x_date_reverse()], [ggplot2::datetime_scale()].

datetime_reverse_scale <- function(
    aesthetics, trans, palette, breaks = pretty_breaks(),
    minor_breaks = waiver(), labels = waiver(), date_breaks = waiver(),
    date_labels = waiver(), date_minor_breaks = waiver(), timezone = NULL,
    guide = "legend", ...) {
  scale <- ggplot2::datetime_scale(
    aesthetics, trans, palette, breaks = breaks,
    minor_breaks = minor_breaks, labels = labels, date_breaks = date_breaks,
    date_labels = date_labels, date_minor_breaks = date_minor_breaks,
    timezone = timezone, guide = guide, ...
  )
  new_trans <- scales::reverse_trans()
  scale$trans <- scales::compose_trans(scale$trans, new_trans)
  if (!is.null(scale$limits) && !is.function(scale$limits)) {
    scale$limits <- new_trans$transform(scale$limits)
  }
  scale
}
