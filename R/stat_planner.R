#' @rdname geom_planner
#' @export

stat_planner <- function(
    mapping = NULL, data = NULL, geom = "planner", position = "identity",
    ..., na.rm = FALSE, orientation = NA, show.legend = NA,
    inherit.aes = TRUE) {
  ggplot2::layer(data = data, mapping = mapping, stat = StatPlanner, geom = geom,
        position = position, show.legend = show.legend, inherit.aes = inherit.aes,
        params = rlang::list2(na.rm = na.rm, orientation = orientation, ...))
}

StatPlanner <- ggplot2::ggproto(
  "StatPlanner", ggplot2::Stat,
  extra_params = c("na.rm", "orientation"),
  required_aes = c("x|y", "ystart|xstart"),
  optional_aes = c("ystop", "xstop"),
  default_aes = ggplot2::aes(
    x = after_stat(time),
    y = after_stat(time),
    xmin = after_stat(if(flipped_aes[1]) time),
    ymin = after_stat(if(!flipped_aes[1]) time),
    xmax = after_stat(if(flipped_aes[1]) timemax),
    ymax = after_stat(if(!flipped_aes[1]) timemax)
  ),
  setup_params = function(data, params) {
    has_xstart <- !(is.null(data$xstart) && is.null(params$xstart))
    has_ystart <- !(is.null(data$ystart) && is.null(params$ystart))
    has_xstop <- !(is.null(data$xstop) && is.null(params$xstop))
    has_ystop <- !(is.null(data$ystop) && is.null(params$ystop))
    if (!has_xstart && !has_ystart) {
      cli::cli_abort("{.fn stat_planner} requires an {.field xstart} or {.field ystart} aesthetic.")
    }
    if (has_xstart && has_ystart) {
      cli::cli_abort("{.fn stat_planner} must only have an {.field xstart} {.emph or} {.field ystart} aesthetic.")
    }
    params$flipped_aes <- if (!(is.null(params$orientation) || is.na(params$orientation))) {
      params$orientation == "y"
    } else {
      has_xstart
    }
    params
  },
  setup_data = function(data, params) {
    data$flipped_aes <- params$flipped_aes
    data
  },
  compute_group = function(data, scales) {
    flipped_aes <- data$flipped_aes[1]
    if(flipped_aes) {
      start <- data$xstart
      stop <- data$xstop
    } else {
      start <- data$ystart
      stop <- data$ystop
    }
    data$time <- hms::as_hms(start)
    data$timemax <- if(is.null(stop)) data$time else hms::as_hms(stop)
    data
  }
)

environment(environment(
  StatPlanner$compute_group
)$compute_group)$decimal_hour <- function(x) {
  x <- as.POSIXlt(x)
  x$hour + x$min / 60
}
