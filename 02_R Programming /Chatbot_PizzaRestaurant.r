#R Programming
#Build Chatbot function - Pizza Restaurant

chatbot <- function(){
# create df : restaurant menu
    menu_df <- data.frame(
    menu_num = 1:6,
    name = c("Hawaiian","Seafood Cocktail", "Super Deluxe", "Spicy Super Seafood", "Shrimp Cocktail","Roasted Spinach"),
    price = c(199,299,399,399,299,199)
    )

#Start Chatbot
    print("สวัสดีค่ะ ร้าน TDR Pizza ยินดีต้อนรับค่ะ")
    print("ขออนุญาติแนะนำเมนูของทางร้านค่ะ")
    print(menu_df)

    flush.console()
    contorder <- readline("ต้องการออเดอร์เลือก Y | จบการออเดอร์เลือก N :")
    order_qty <- 0
    order_price <- 0
    total_price <- 0

    while(contorder == "Y") {
        menu_no <- as.numeric(readline("สามารถเลือกตัวเลขเมนูได้เลยค่ะ(1-ุ6): "))
        menu_qty <- as.numeric(readline("เลือกจำนวนที่ต้องการออเดอร์ค่ะ:"))
        order_qty = order_qty + menu_qty
        order_price = order_price + (menu_qty * menu_df[["price"]][menu_no])
        total_price = total_price + order_price

        print(paste("ออเดอร์ที่คุณเลือก: ",menu_df[["name"]][menu_no]))
        print(paste("จำนวนที่ออเดอร์: ",menu_qty))
        contorder <- readline("ขอบคุณค่ะต้องการออเดอร์ต่อ เลือก Y | จบการออเดอร์เลือก N :")

        if (contorder == "Y") {
            order_qty <- 0
            order_price <- 0
        } else if (contorder == "N") {
            print(paste("ขอบคุณสำหรับออเดอร์ค่ะ ขออนุญาติสรุปยอดรวมทั้งหมดนะค่ะ (บาท): ", total_price))
            print("ขอขอบคุณที่ใช้บริการค่ะ")
        }
    }
}
