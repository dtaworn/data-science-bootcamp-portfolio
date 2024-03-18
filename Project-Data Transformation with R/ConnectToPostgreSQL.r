##Set up tables with data in R and then connect to PostgreSQL to write tables

library(RPostgreSQL)
library(tidyverse)

#Create connection to PostgreSQL
con <- dbConnect(
  PostgreSQL(),
  host = "arjuna.db.elephantsql.com",
  dbname = "ujtatqxj",
  user = "ujtatqxj",
  password = "bItcN1R5byrl7vTU1n0iNRS8ovpTGmpC",
  port = 5432
)

#Set up tables and data
customers <- tribble(
  ~cust_id, ~first_name, ~last_name, ~mobile, 
  1, "Ali", "Beck", "0812345678",
  2, "Verge", "Vanden", "0982345678",
  3, "Luis", "Camacho", "0898765432",
  4, "Mo", "Salaz", "0876543210",
  5, "Lucie", "Wick", "0996543210"
)

menus <- tribble(
  ~menu_id, ~menu_name, ~menu_category, ~menu_price, 
  1, "Hawaiian", "Pizza", 199,
  2, "Seafood Cocktail", "Pizza", 299,
  3, "Super Deluxe", "Pizza", 399,
  4, "Spicy Super Seafood", "Pizza", 399,
  5, "Shrimp Cocktail", "Pizza", 299,
  6, "Roasted spinach", "Pizza", 199
)

orders <- tribble(
  ~order_id, ~order_date, ~cust_id, ~menu_id, ~quantity,
  1, "2023-08-01", 1, 1, 1,
  2, "2023-08-01", 2, 2, 2,
  3, "2023-08-01", 3, 3, 1,
  4, "2023-08-01", 4, 4, 2,
  5, "2023-08-01", 5, 5, 1,
  6, "2023-08-02", 1, 6, 2
)

##db Write Tables
dbWriteTable(con, "customers", customers)
dbWriteTable(con, "menus", menus)
dbWriteTable(con, "orders", orders)

##db List Tables
dbListTables(con)

##db Get Data
dbGetQuery(con, "select cust_id, first_name, last_name, mobile from customers")
dbGetQuery(con, "select menu_id, menu_name, menu_category, menu_price from menus")
dbGetQuery(con, "select order_id, order_date, cust_id, menu_id, quantity from orders")

dbDisconnect(con)

##Result
> ##db List Tables
> dbListTables(con)
[1] "customers" "menus"     "orders"   
> 
> ##db Get Data
> dbGetQuery(con, "select cust_id, first_name, last_name, mobile from customers")
  cust_id first_name last_name     mobile
1       1        Ali      Beck 0812345678
2       2      Verge    Vanden 0982345678
3       3       Luis   Camacho 0898765432
4       4         Mo     Salaz 0876543210
5       5      Lucie      Wick 0996543210
> dbGetQuery(con, "select menu_id, menu_name, menu_category, menu_price from menus")
  menu_id           menu_name menu_category menu_price
1       1            Hawaiian         Pizza        199
2       2    Seafood Cocktail         Pizza        299
3       3        Super Deluxe         Pizza        399
4       4 Spicy Super Seafood         Pizza        399
5       5     Shrimp Cocktail         Pizza        299
6       6     Roasted spinach         Pizza        199
> dbGetQuery(con, "select order_id, order_date, cust_id, menu_id, quantity from orders")
  order_id order_date cust_id menu_id quantity
1        1 2023-08-01       1       1        1
2        2 2023-08-01       2       2        2
3        3 2023-08-01       3       3        1
4        4 2023-08-01       4       4        2
5        5 2023-08-01       5       5        1
6        6 2023-08-02       1       6        2
