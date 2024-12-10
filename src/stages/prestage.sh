#!/bin/bash
#this stage to help the player prepare for the expedition to the temple, and get familiar with the game mechanics.

# Load helper scripts
source ../utils/helpers.sh
source ../utils/inventory.sh
source ../utils/player.sh
source ../utils/scoring.sh
source ../utils/logs.sh
function task1_Navigation() {
    echo "Task 1: Navigate through the jungle."
    echo "You are surrounded by dense vegetation. You need to find your way out."
    echo "Which direction would you like to go?"
    echo "a) North"
    echo "b) South"
    echo "c) East"
    echo "d) West"
    echo "you can use 'map' to view the map and navigate through the jungle."
    while true ; do
        read -p "> " player_input
        case "$player_input" in
        a) echo "You chose to go North."
            log_action "Player chose to go North."
            break
            ;;
        b) echo "You chose to go South."
            log_action "Player chose to go South."
            break
            ;;
        c) echo "You chose to go East."
            log_action "Player chose to go East."
            break
            ;;
        d) echo "You chose to go West."
            log_action "Player chose to go West."
            break
            ;;
        map) check_for_commands "map" "Pre-Stage" "Task 1"
            ;;
        *) echo "Invalid choice. Choose a, b, c, or d."
            ;;
        esac
    done
   
}
function collect_supplies() {
    echo "Task 2: Gather supplies for the expedition."
    # introduce the player to the inventory system and scan the place
    # scan the place to find the supplies
    echo "You arrived at an abandoned campsite, use 'scan' to search for supplies."

    while true ; do
        read -p "> " player_input
        case "$player_input" in
        scan) check_for_commands "scan" "Pre-Stage" "Task 2"
            break
            ;;
        *) echo "Invalid choice. Use 'scan' to scan the compsite."
            ;;
        esac
    done
    # Display player inventory
    echo "You can use 'inventory' to view your inventory."
    while true ; do
        read -p "> " player_input
        case "$player_input" in
        inventory) view_inventory
            break
            ;;
        *) echo "Invalid choice. Use 'inventory' to view your inventory."
            ;;
        esac
    done



}
function next_path() {
    echo "Task 3: Choose the next path."
    echo "You reached a fork in the road. Which path would you like to take?"
    echo "a) East"
    echo "b) North"

    while true ; do
        read -p "> " player_input
        case "$player_input" in
        a) echo "You chose to go East."
            log_action "Player chose to go East."
            Enter_the_Temple
            break
            ;;
        b) echo "You chose to go North."
           river_crossing
           break
            ;;   
        *) check_for_commands "$player_input" "Pre-Stage" "Task 3"
            ;;
        esac
    done
}

function river_crossing() {
    echo "Task 4: Cross the river."
    echo "You reached a river. There is a bridge to the North"
    echo "Would you like to cross the bridge to the other side?"
    echo "a) Yes"
    echo "b) No"
    #if the player chooses to cross the river, the brigde will collapse and the player will lose health points
    while true ; do
        read -p "> " player_input
        case "$player_input" in
        a) echo "You chose to cross the bridge."
            log_action "Player chose to cross the bridge."
            trigger_trap "bridge" 20
            break
            ;;
        b) echo "You chose not to cross the bridge."
            log_action "Player chose not to cross the bridge."
            break
            ;;
        *) check_for_commands "$player_input" "Pre-Stage" "Task 5"
            ;;
        esac
    done
}
function Enter_the_Temple() {
    echo "Task 4: going deep into jungle ."
    echo "You are now deep in the jungle. You can see a small stone pillar stands here, covered in ancient carvings that glow faintly in the light."
    echo "You can use 'scan' to examine the carvings."
    while true ; do
        read -p "> " player_input
        case "$player_input" in
        scan) check_for_commands "scan" "Pre-Stage" "Task 4"
            break
            ;;
        *) echo "Invalid choice. Use 'scan' to examine the carvings."
            ;;
        esac
    done
    echo "The ground beneath your feet rumbles slightly, then a section of the ground slides away to reveal a hidden chamber."
    echo "You found a weird looking stone with a button on it."
    echo "You pressed the button and a secret passage opened."
    echo "Welcome, Explorer. Master the ancient commands to uncover the secrets of the Codex of Computis."
    log_action "Player pressed the button and opened a secret passage."
    
}


# Initialize pre-stage
function pre_stage() {
    # Display banner
    display_stage_banner "Pre-Stage: Jungle Trek"

    # Initialize player
    echo "Welcome, adventurer! Please enter your name:"
    read player_name
    init_player "$player_name"
    initialize_score
    creat_file_for_player "$player_name"

    echo "You are deep in the jungle. Your goal is to prepare for the expedition to the temple."
    # Task 1: Navigation
    task1_Navigation
    # Task 2: Collect supplies
    collect_supplies
    # Task 3: Choose the next path
    next_path    

    # Pre-stage Completion
    echo "You are ready to continue your journey into the temple."
    log_action "Pre-stage completed."
}

# Run the pre-stage
pre_stage
