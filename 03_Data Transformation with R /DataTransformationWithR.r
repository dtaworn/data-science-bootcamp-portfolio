## Use library nycflights13 and work with 2 data data frames of flights and airlines to transform data and find data insights

library(tidyverse)
library(nycflights13)
library(glue)
library(lubridate)

data("flights")
data("airlines")

##Q1 : Top 5 Airlines operates flights at NYC in 2013
flights %>%
  count(carrier) %>%
  arrange(desc(n)) %>%
  head(5) %>%
  left_join(airlines)

##Q1 Result
Joining with `by = join_by(carrier)`
# A tibble: 5 × 3
  carrier     n name                    
  <chr>   <int> <chr>                   
1 UA      58665 United Air Lines Inc.   
2 B6      54635 JetBlue Airways         
3 EV      54173 ExpressJet Airlines Inc.
4 DL      48110 Delta Air Lines Inc.    
5 AA      32729 American Airlines Inc.
  
##Q2 : Top 5 destinations of flights operated from NYC in 2013
flights %>%
  count(dest) %>%
  arrange(desc(n)) %>%
  head(5)

##Q2 Result
dest      n
  <chr> <int>
1 ORD   17283
2 ATL   17215
3 LAX   16174
4 BOS   15508
5 MCO   14082

##Q3 Top 5 airports customers used in NYC in 2013
flights %>%
  count(origin) %>%
  arrange(desc(n)) %>%
  head(5)

##Q3 Result
origin      n
  <chr>   <int>
1 EWR    120835
2 JFK    111279
3 LGA    104662

##Q4 : Top Airlines with high average of delays to depart / Not good history
flights %>%
  left_join(airlines) %>%
  filter(dep_delay > 0) %>%
  select(name, dep_delay) %>%
  group_by(name) %>%
  summarise(sum_delay_mins = sum(dep_delay),
            mean_delay_mins = mean(dep_delay)) %>%
  arrange(desc(mean_delay_mins)) %>%
  head(5)

##Q4 Result
Joining with `by = join_by(carrier)`
# A tibble: 5 × 3
  name                     sum_delay_mins mean_delay_mins
  <chr>                             <dbl>           <dbl>
1 SkyWest Airlines Inc.               522            58  
2 Mesa Airlines Inc.                12338            53.0
3 ExpressJet Airlines Inc.        1164581            50.3
4 Endeavor Air Inc.                345522            48.9
5 Frontier Airlines Inc.            15392            45.1

##Q5 : Peak Periods of the year 2013 by months (No. of flights)
charmonths <- c("Jan","Feb","Mar",
              "Apr","May","Jun",
              "Jul","Aug","Sep",
              "Oct","Nov","Dec")
flights %>%
  mutate(month_name = charmonths[month]) %>%
  count(month_name) %>%
  arrange(desc(n))

##Q5 Result
# A tibble: 12 × 2
   month_name     n
   <chr>      <int>
 1 Jul        29425
 2 Aug        29327
 3 Oct        28889
 4 Mar        28834
 5 May        28796
 6 Apr        28330
 7 Jun        28243
 8 Dec        28135
 9 Sep        27574
10 Nov        27268
11 Jan        27004
12 Feb        24951
