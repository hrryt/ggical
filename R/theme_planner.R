#' Planner Theme
#'
#' A modification of the [ggplot2::theme_linedraw()] complete theme.
#' Intended for use with `geom_planner()`.
#'
#' @inheritParams ggplot2::theme_linedraw
#' @param orientation which major grid lines should be removed?
#' @inherit geom_planner examples
#'
#' @export
theme_planner <- function(orientation = c("x", "y"), base_size = 11, base_family = "",
                          base_line_size = base_size/22, base_rect_size = base_size/22) {
  th <- ggplot2::theme_linedraw(
    base_size = base_size, base_family = base_family,
    base_line_size = base_line_size, base_rect_size = base_rect_size
  ) %+replace% switch(
    match.arg(orientation),
    x = ggplot2::theme(panel.grid.major.x = ggplot2::element_blank()),
    y = ggplot2::theme(panel.grid.major.y = ggplot2::element_blank())
  )
}
