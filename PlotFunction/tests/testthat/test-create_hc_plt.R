test_that("create_hc_plt function returns a ggplot object", {
  plt <- create_hc_plt(
    x_var = "x_column_name",
    y_var = "y_column_name",
    color_var = "color_column_name",
    plt_title = "Test Plot Title",
    x_var_title = "X Axis Title"
  )
  expect_true("gg" %in% class(plt))
})