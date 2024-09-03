feed_block <- function(title){
  source(here::here("R/bullet_list.R"))

  dat <- readxl::read_excel(here::here("data/KIND_training_feedback.xlsx")) |>
    dplyr::filter(stringr::str_detect(session_title, title))
  
  vars <- c("Too easy", "About right", "Too hard")
  
  results <- dat |>
    dplyr::mutate(describe = stringr::str_trim(stringr::str_remove_all(describe, "/.*$"))) |>
    dplyr::count(describe) 
  
  plot <- tibble::tibble(
    describe = vars
  ) |> 
    dplyr::left_join(results) |>
    dplyr::mutate(n = tidyr::replace_na(n, 0), 
           describe = factor(describe, levels = vars)) |>
    ggplot2::ggplot() +
    ggplot2::geom_col(ggplot2::aes(x = factor(describe), y = n), fill = "steelblue") +
    ggplot2::geom_label(ggplot2::aes(label = describe, x = describe, y = max(n)/2), size = 3) +
    ggplot2::theme_void()
  
  if (nrow(dat) == 0) {
    return(cat("No feedback found for this session"))
  } else {

    rite <- scales::percent((sum(dat$describe == "About right", na.rm = T) / nrow(dat)))
    rec <- scales::percent((sum(dat$recommend == "Yes", na.rm = T) / nrow(dat)))
    
    cat("  \n## Previous attendees have said...  \n")
    
    vec <- c(paste0(nrow(dat), " previous attendees have left feedback"),
             paste0(rec, " would recommend this session to a colleague"),
             paste0(rite, " said that this session was pitched correctly:  \n"))
    
    bullet_list(vec)
    
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





