---
title: "HW - Data Visualization"
author: "Soe"
date: "`r Sys.Date()`"
output: pdf_document
---

**Chart#1: Number of car model released by manufacturer between 1999 and 2008**
```{r, message=FALSE, out.width = "70%"}
library(tidyverse)
library(ggthemes)
library(patchwork)

mpg$year <- as.factor(mpg$year)
ggplot(mpg, aes(y=manufacturer, fill=year))+
  geom_bar() +
  theme_minimal() +
  #scale_fill_brewer(palette = "Set2") +
  scale_fill_manual(values = c("green","blue"))+
  labs(
  x= "Number of released models",
  y= "Car Manufacturer"
  )
```

**Summary:** Dodge, Toyota, and Volkswagen are top 3 of car manufacturer 
releasing number of models in 1999 and 2008
\newpage

**Chart#2: Top 3 of type of transimission vs. Avg. City/Highway Mile per Gallon, 
Car models released in 1999 and 2008**

```{r, message=FALSE, out.width = "70%"}

avg1 <- mpg %>%
  group_by(trans) %>%
  summarise(AvgCTY = mean(cty), n = n()) %>%
  head(3) %>%
  ggplot(data = ., mapping=aes(x=AvgCTY,y=trans, fill= trans))

avg2 <- mpg %>%
  group_by(trans) %>%
  summarise(AvgHWY = mean(hwy), n = n()) %>%
  head(3) %>%
  ggplot(data = ., mapping=aes(x=AvgHWY,y=trans, fill= trans))

cty1 <- avg1+geom_col() +
  theme_minimal() +
  labs(
  x= "Average City Mile per Gallon",
  y= "Type of Transmission"
  )

hwy1 <- avg2+geom_col() +
  theme_minimal() +
  labs(
  x= "Average Highway Mile per Gallon",
  y= "Type of Transmission"
  )
cty1/hwy1

```

**Summary:** auto(av), auto(I3), and auto(I4) are top 3 of type of transmission,
having high fuel saving efficiency and high average mile per gallon
(City & Highway)
\newpage

**Chart#3: Top 3 of car manufacturer having high Avg. Mile per Gallon, 
Car models released in 1999 and 2008**

```{r,message=FALSE, out.width = "70%"}

avg3 <- mpg %>%
  group_by(manufacturer) %>%
  summarise(AvgCTY = mean(cty), n = n()) %>%
  head(3) %>%
  ggplot(data = ., mapping=aes(x=AvgCTY,y=manufacturer, fill= manufacturer))

avg4 <- mpg %>%
  group_by(manufacturer) %>%
  summarise(AvgHWY = mean(hwy), n = n()) %>%
  head(3) %>%
  ggplot(data = ., mapping=aes(x=AvgHWY,y=manufacturer, fill= manufacturer))

cty2 <- avg3+geom_col() +
  theme_minimal() +
  labs(
  x= "Average City Mile per Gallon",
  y= "Car Manufacturer"
  )

hwy2 <- avg4+geom_col() +
  theme_minimal() +
  labs(
  x= "Average Highway Mile per Gallon",
  y= "Car Manufacturer"
  )
cty2/hwy2
```

**Summary:** Audi, Chevrolet, and Dodge are top 3 of car manufacturer 
having high average city and highway mile per gallon for their car models 
released in 1999 and 2008
\newpage

**Chart#4** Average City/Highway Mile Per Gallon by Year 1999 and 2008

```{r, message=FALSE, out.width = "70%"}
library(patchwork)
mpg$year <- as.factor(mpg$year)
cty3 <- mpg %>%
  group_by(year) %>%
  summarise(AvgCTY = mean(cty))

hwy3 <- mpg %>%
  group_by(year) %>%
  summarise(AvgHWY = mean(hwy))

line1 <- ggplot(cty3,aes(year,AvgCTY,ymin=15,ymax=20,group=1))+
  geom_line(color="blue",linewidth=1)+
  theme_minimal() + 
  labs(
  y= "Avg City MPG",
  x= "Year"
  )

line2 <- ggplot(hwy3,aes(year,AvgHWY,ymin=15,ymax=30,group=1))+
  geom_line(color="blue",linewidth=1)+
  theme_minimal() +
  labs(
  y= "Avg Highway MPG",
  x= "Year"
  )

line1/line2
```

**Summary:** No improvement of Average Mile per Gallon for car models released 
in year 1999 and 2008
\newpage

**Chart#5: Relationship between City/Highway Mile Per Gallon 
and engine displacement & number of cylinders**

```{r, message=FALSE, out.width = "70%"}
library(patchwork)
p1 <- ggplot(mpg, aes(displ,cty)) +
  geom_point(alpha = 0.2, color="red") +
 # geom_smooth(method = "lm") +
  geom_smooth(formula = y ~ x, method = "lm") +
  theme_minimal()

p2 <- ggplot(mpg, aes(displ,hwy)) +
  geom_point(alpha = 0.2, color="red") +
 # geom_smooth(method = "lm") +
  geom_smooth(formula = y ~ x, method = "lm") +
  theme_minimal()

p3 <- ggplot(mpg, aes(cyl,cty)) +
  geom_point(alpha = 0.2, color="gold") +
 # geom_smooth(method = "lm") +
  geom_smooth(formula = y ~ x, method = "lm") +
  theme_minimal()

p4 <- ggplot(mpg, aes(cyl,hwy)) +
  geom_point(alpha = 0.2, color="gold") +
 # geom_smooth(method = "lm") +
  geom_smooth(formula = y ~ x, method = "lm") +
  theme_minimal()

(p1+p2)/(p3+p4)
```

**Summary:** Negative slope. From trend line, the more numbers of engine 
displacement and cylinders, the lower city and highway mile per gallon,
car models released in 1999 and 2008
