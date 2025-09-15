here::i_am("slides/render_slides.R")

fn <- "excel/excel_first_steps.qmd"

out_fn <- paste0("slides_",
       tools::file_path_sans_ext(basename(fn)),
       ".html")

site_fn <- paste0("_site/", 
       stringr::str_extract(fn, ".*\\/"),
       out_fn)

# add the params

quarto::quarto_render(here::here(fn), output_format = "revealjs",
                      output_file = out_fn,
                      execute_params = list(sl_date = "2025-09-16"),
                      metadata_file = "slides/slide_render.yml")


file.copy(site_fn, paste0("slides/", out_fn), overwrite = T)

