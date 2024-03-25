#' Generating a plot of hc, industrialization, and a categorial variable.
#'
#' @param x_var A numeircal data.table column.
#' @param y_var A numerical data.table column.
#' @param color_var A categorial data.table column.
#' @param plt_title The plot's title.
#' @param x_var_title X-axis title.
#'
#' @return A plot presenting the correlation between x_var and y_var given the different values of color_var.
#' @export
#'
#' @examples
#' myfunc("urban_share", "birth_rate", "Region", "Urbanization and birth rates", "Urban share")

create_hc_plt <- function(x_var, y_var, color_var, plt_title, x_var_title){
gender <- ifelse(grepl("female", y_var, ignore.case = TRUE), "female", "male")
plt <- merged_dt |>
ggplot(aes_string(x = x_var, y = y_var, color = color_var)) +
geom_point(size = 2.4) + 
geom_smooth(method = "lm", se = FALSE, color = "#010111ee", linewidth = 1.4) +
labs(title = plt_title, 
x = x_var_title, y = "") +
theme_economist() +
theme(
axis.title = element_text(size = 8),
axis.text = element_text(size = 8),
plot.title = element_text(size = 14),
legend.text = element_text(size = 8)
    )
  return(plt)
}