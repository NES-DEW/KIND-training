# feed_gauge <- function(title){
#   
#   library(plotly)
#   
#   dat <- readxl::read_excel(here::here("data/KIND_training_feedback.xlsx")) |>
#     dplyr::filter(stringr::str_detect(session_title, title))
#   
#   vars <- c("Too easy", "About right", "Too hard")
#   
#   results <- dat |>
#     dplyr::mutate(describe = stringr::str_trim(stringr::str_remove_all(describe, "/.*$"))) |>
#     dplyr::count(describe)
#   
#   if (nrow(dat) != 0) {
#     
#   pitcho <- results |>
#   dplyr::mutate(score = dplyr::case_when(describe == "About right" ~ 0,
#                                          describe == "Too easy" ~ -1,
#                                          describe == "Too hard" ~ 1)) |>
#   dplyr::mutate(blarn = (n * score)/sum(n)) |>
#   dplyr::pull(blarn) |>
#   sum(na.rm = T)
# 
#   m <- list(
#     l = 40,
#     r = 40,
#     b = 40,
#     t = 40,
#     pad = 20
#   )
# 
# # plot_plotly <- function(x) plot_ly(x=x, type = "indicator")
# plot_ly(width = 500, 
#              height = 200,
#              domain = list(x = c(0, 2), y = c(0, 2)),
#              gauge = list(
#                color = "gradient",
#                axis = list(
#                  range = list(-1,1),
#                  showticklabels = TRUE,
#                  tickmode="array",
#                  tickvals=c(-0.6,0,0.6),
#                  ticktext=c("Too easy","About right","Too hard"),
#                  tickfont = list(size = 10)),
#                steps = list(
#                  list(range = c(-1,1), color = "#2780E3")),
#                threshold = list(
#                  line = list(color = "#ECF4FC", width = 10),
#                  thickness = 0.75,
#                  value = pitcho)
#              ),
#              title = list(text = "Pitched correctly?"),
#              type = "indicator",
#              mode = "gauge")
#   }
# }
# feed_gauge("Excel first steps")
