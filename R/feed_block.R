feed_block <- function(title){
  source(here::here("R/bullet_list.R"))

  dat <- readxl::read_excel(here::here("data/KIND_training_feedback.xlsx")) |>
  janitor::clean_names() |>
  dplyr::filter(stringr::str_detect(session_title, title))
  
  if (nrow(dat) == 0) {
    return(cat("No feedback found for this session"))
  } else {
    names(dat)[5:7] <- c("recommend", "describe", "sentence")
    
    rite <- scales::percent((sum(dat$describe == "About right", na.rm = T) / nrow(dat)))
    rec <- scales::percent((sum(dat$recommend == "Yes", na.rm = T) / nrow(dat)))
    
    cat("  \n## Previous attendees have said...  \n")
    
    vec <- c(paste0(nrow(dat), " previous attendees have left feedback"),
             paste0(rite, " said that this session was pitched correctly"), 
             paste0(rec, " would recommend this session to a colleague"))
    
    bullet_list(vec)
    
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