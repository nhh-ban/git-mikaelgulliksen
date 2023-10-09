library(tidyverse)
library(ggplot2)

#connections is alle the lines in the url.
raw_file <- readLines(con = "http://www.sao.ru/lv/lvgdb/article/suites_dw_Table1.txt")

#Start and stop is 1 and 2 for the two first characters.
substr(x = raw_file, start = 1 , stop = 2 )

#1 and 2 for the same reason, and they should be equal to the two char we are trying to find.
L <-
  (substr(x =raw_file, start = 1, stop = 2) == "--") %>%
  which(L)

#The data is the lines in the file until L where the separator is, and
#showcases this in a file
cat(readLines(con = "http://www.sao.ru/lv/lvgdb/article/suites_dw_Table1.txt", n = L), sep = "\n", file = "description.txt")

#string is the raw_data to separate the entire file, and not part of it.
variable_names <-
  str_split(string = raw_file, pattern = "\\|") %>% 
  unlist() %>% 
  str_trim()

#The data here is the file beginning from L and to the bottom of the file.
comma_separated_values <- 
  raw_file[L:length(raw_file)] %>% 
  gsub("\\|", ",", .) %>% 
  gsub(" ", "", .)

comma_separated_values_with_names <- 
  c(paste(variable_names, collapse = ","),
    comma_separated_values)

#Has to be the _with_names for the file to be correct with values and names.
cat(comma_separated_values_with_names, sep = "\n", file = "not_raw_file.csv")

galaxies <- read_csv("not_raw_file.csv")

library(ggplot2)

#The plot showcases the correlation between size and number of galaxies in one md.
#Altough i have some trouble finding a trend however I try to plot the data,
#I would assume from the dataset and the plot that the underrepresentation
#is due to difficulty measuring the smaller galaxies brightness and therefore
#size in the denser areas.
ggplot(galaxies, aes(x = a_26, y = count)) +
  geom_point() +
  labs(x = "Linear Diameter (kpc)", y = "Number of Members") +
  ggtitle("Galaxy Size vs. Number of Members")