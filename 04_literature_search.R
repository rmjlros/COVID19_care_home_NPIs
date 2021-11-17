rm(list=ls())
library(tidyverse)
# start with bioRxiv
# calculate total number of COVID-19 papers on bioRxiv
data_raw <- jsonlite::read_json("https://api.biorxiv.org/covid19/0")
total_papers <- data_raw$messages[[1]]$total

results <- list()
for (i in 1:ceiling(total_papers / 30)){
    this_string <- paste0("https://api.biorxiv.org/covid19/", (i-1)*30)
    data_raw <- jsonlite::read_json(this_string) 
    
    results <- append(results, data_raw$collection)
    print(i)
}

results_df <- data.frame(Reduce(rbind, results))

data_tibble <- results_df %>%
    dplyr::tibble() %>%
    dplyr::select(title = rel_title,
                  abstract = rel_abs,
                  links = rel_link)

results_by_abstract <- data_tibble %>%
    dplyr::filter(stringr::str_detect(.$abstract, "(COVID-19) | (SARS-CoV-2) | (coronavirus)") == "TRUE" &
                      stringr::str_detect(.$abstract, "(care home) | (LTCF) | (long term care facility) | (nursing home)") == "TRUE" &
                      stringr::str_detect(.$abstract, "(model)") == "TRUE")



results_by_title <- data_tibble %>%
    dplyr::filter(stringr::str_detect(.$title, "(COVID-19) | (SARS-CoV-2) | (coronavirus)") == "TRUE" &
                      stringr::str_detect(.$title, "(care home) | (LTCF) | (long term care facility) | (nursing home)") == "TRUE" &
                      stringr::str_detect(.$title, "(model)") == "TRUE")


results_final <- dplyr::full_join(results_by_abstract, results_by_title)

urls <- results_final$links
num_to_browse <- length(results_final$title)

for(i in 1:num_to_browse){
    browseURL(as.character(urls[i])) 
}

# tmp <- readr::read_txt()
# tmp <- system.file("../covidm_MTPs/mini_review/pubmed_results_abstracts_short_list.txt", package = "readtext")