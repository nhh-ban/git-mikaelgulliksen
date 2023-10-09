library(tidyverse)

raw_file <- readLines(con = "http://www.sao.ru/lv/lvgdb/article/suites_dw_Table1.txt")

substr(x = raw_file, start = 1 , stop = 2 )

L <-
  (substr(x =raw_file, start = 1, stop = 2) == "--") %>%
  which(L)

cat(readLines(con = "http://www.sao.ru/lv/lvgdb/article/suites_dw_Table1.txt", n = L), sep = "\n", file = "description.txt")

variable_names <-
  str_split(string = raw_file, pattern = "\\|") %>% 
  unlist() %>% 
  str_trim()

comma_separated_values <- 
  raw_file %>% 
  gsub("\\|", ",", .) %>% 
  gsub(" ", "", .)

comma_separated_values_with_names <- 
  c(paste(variable_names, collapse = ","),
    comma_separated_values)

cat(comma_separated_values_with_names, sep = "\n", file = "not_raw_file.csv")

galaxies <- read_csv("not_raw_file.csv")