# slide render script
# created an appropriately dated version of the slides in this slide subdirectory

# set the file and the session date ----
fn <- "excel/tidy_data_in_excel.qmd" # path relative to project wd
session_date <- "2025-09-10" #in this format, don't fool with it

out_fn <- paste0("slides_",
       tools::file_path_sans_ext(basename(fn)),
       ".html")

site_fn <- paste0("_site/", 
       stringr::str_extract(fn, ".*\\/"),
       out_fn)

quarto::quarto_render(fn,
                      output_format = "revealjs",
                      output_file = out_fn,
                      execute_params = list(sl_date = session_date),
                      metadata_file = "slides/slide_render.yml")

file.copy(site_fn, paste0("slides/", out_fn), overwrite = T)
unlink(site_fn)

# quarto::quarto_render(fn, output_format = "html")