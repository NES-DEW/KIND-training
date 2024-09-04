feed_block <- function(title){
  source(here::here("R/bullet_list.R"))
  library(ggplot2)
  
  dat <- readxl::read_excel(here::here("data/KIND_training_feedback.xlsx")) |>
    dplyr::filter(stringr::str_detect(session_title, title))
  
  vars <- c("Too easy", "About right", "Too hard")
  
  results <- dat |>
    dplyr::mutate(describe = stringr::str_trim(stringr::str_remove_all(describe, "/.*$"))) |>
    dplyr::count(describe)
  
  pitcho <- results |>
    dplyr::mutate(score = dplyr::case_when(describe == "About right" ~ 0,
                                           describe == "Too easy" ~ -1,
                                           describe == "Too hard" ~ 1)) |>
    dplyr::mutate(blarn = (n * score)/sum(n)) |>
    dplyr::pull(blarn) |>
    sum(na.rm = T)
  
  plot <- tibble::tibble(xmin = -1, xmax = 1, ymin=0, ymax=.5) |>
    ggplot() +
    geom_rect_pattern(aes(xmin = xmin,
                                     xmax = xmax,
                                     ymin = ymin,
                                     ymax = ymax)) +
    geom_vline(aes(xintercept = pitcho), colour = "#fd8d3c", linewidth = 4) +
    geom_label(aes(x = -.5, y = .25, label = "← Too easy")) +
  geom_label(aes(x = .5, y = .25, label = "Too hard →")) +
    ylim(-0.01,.51) +
    theme_void()
  
  if (nrow(dat) == 0) {
    return(cat("No feedback found for this session"))
  } else {

    rite <- scales::percent((sum(dat$describe == "About right", na.rm = T) / nrow(dat)))
    rec <- scales::percent((sum(dat$recommend == "Yes", na.rm = T) / nrow(dat)))
    
    vec <- c(paste0(nrow(dat), " previous attendees have left feedback"),
             paste0(rec, " would recommend this session to a colleague"),
             paste0(rite, " said that this session was pitched correctly  \n"))
    
    cat("  \n## Previous attendees have said...  \n")
    cat("  \n")
    
    bullet_list(vec)

    cat("  \n")
    print(plot)
    cat("  \n")
    cat("  \n")
    cat(":::{.callout-note}")
    cat("  \n")
    cat("### Three random comments from previous attendees")
    cat("  \n")
    
    bullet_list(dat |>
                  dplyr::filter(!is.na(sentence)) |>
                  dplyr::slice_sample(n = 3) |>
                  dplyr::pull(sentence))
    cat("  \n")
    cat(":::")
    cat("  \n")
  
    }
}





