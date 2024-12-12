#! /bin/bash
# Load helper scripts
source utils/helpers.sh
source utils/player.sh
source utils/logs.sh

#announce the game
echo " "
echo "Welcome to the Adventure of the Computis temple"
echo " "

# get the player name and initaize the player
echo "Please enter your name: "
read player_name
init_player "$player_name"

# start the game    
echo " "
# run the stages file
./stages/prestage.sh
echo " "
./stages/stage1.sh
echo " "
./stages/stage2.sh
echo " "
./stages/stage3.sh
echo " "
./stages/stage4.sh
echo " "
./stages/stage5.sh
echo " "
./stages/stage6.sh
