#R Programming
#Build Game function - Rock Paper Scissor

game <- function() {
    print("Welcome to Rock paper scissor game")
    print("Rule : Please choose R for Rock, P for Paper, and S for Scissors (Note : This is case sensitive)")

    hands <- c("R","P","S")
    player_scores <- 0
    comp_scores <- 0
    draw_scores <- 0
    rounds <- 1
    cont <- "y"

    while(cont == "y") {

    print(paste("***** Begin Round# ***** : ", rounds))
    flush.console()
    player_hand <- readline("Choose your hand:")
    comp_hand <- sample(hands,1)

    hand_pics <- c("R" = "🔨","P" = "📃" ,"S" = "✂️")
    print(paste("Your hand is ",hand_pics[player_hand]))
    print(paste("Comp hand is ",hand_pics[comp_hand]))

    if (player_hand == "R" && comp_hand == "P"){
        print("Opps..Sorry, You lose")
        comp_scores = comp_scores +1

    } else if (player_hand == "R" && comp_hand == "S") {
        print("Yeah..Congratulation, You Win !!")
        player_scores = player_scores +1

    } else if (player_hand == "P" && comp_hand == "R") {
        print("Yeah..Congratulation, You Win !!")
        player_scores = player_scores +1

    } else if (player_hand == "P" && comp_hand == "S") {
        print("Opps..Sorry, You lose")
        comp_scores = comp_scores +1

    } else if (player_hand == "S" && comp_hand == "R") {
        print("Opps..Sorry, You lose")
        comp_scores = comp_scores +1

    } else if (player_hand == "S" && comp_hand == "P") {
        print("Yeah..Congratulation, You Win !!")
        player_scores = player_scores +1

    } else if (player_hand == comp_hand) {
        print("Even, You draw")
        draw_scores = draw_scores +1
    }

    flush.console()
    cont <- readline("Input y to continue playing, and n to stop:")

    if(cont == "y") {
        rounds = rounds+1
    } else if (cont == "n" ) {
    print("***** Summary of your plays *****")
    print(paste("Your total win score: ", player_scores))
    print(paste("Comp total win score: ", comp_scores))
    print(paste("Draw score: ", draw_scores))
    }

    } # Close While
} # Close function
