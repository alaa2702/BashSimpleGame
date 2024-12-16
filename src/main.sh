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
#check if the player is new or not
if [ -f assets/player_files/${player_name}_stage_progress ]; then
    echo "Welcome back, $player_name!"
    echo " "
    cat assets/player_files/status.txt
    load_stage_progress
    stage=current_stage
else
    echo "Welcome, $player_name!"
    echo " "
fi
# start the game    
echo " "
case "$stage" in 
    prestage) 
        ./stages/prestage.sh;
        
    stage1) 
        ./stages/stage1.sh;
        
    stage2) 
        ./stages/stage2.sh;
        
    stage3) 
        ./stages/stage3.sh;
    stage4) 
        ./stages/stage4.sh;
    
    stage5) 
        ./stages/stage5.sh;
    stage6) 
        ./stages/stage6.sh;
    *) 
        echo "Invalid stage."
        ;;
esac

