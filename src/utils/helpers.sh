#!/bin/bash
#utils/helpers

source ../utils/player.sh
source ../utils/logs.sh

# Display a hint for the current stage
function display_hint() {
    local stage_name=$1
    local task=$2
    # Check if a hint is available for the current stage and task
    local hint_file="../assets/hints/${stage_name}_hints.txt"
    #search for the task hint in the file
    hint=$(grep -i "$task" "$hint_file" | cut -d ":" -f 2) #search for the task hint in the file 
    if [[ -n "$hint" ]]; then
        echo "Hint for Stage $stage: $hint"
        log_action "Hint displayed for Stage $stage: $hint"
        return 1
    else
        echo "No hints available for this stage."
        log_error "Hint requested for Stage $stage but not found."
        return 0
    fi
}

# Print a banner for a stage
function display_stage_banner() {
    local stage_name=$1
    echo "========================================"
    echo "          $stage_name"
    echo "========================================"
   # log_action "Entered $stage_name."
}
# function used to set a trap for the player 
function trigger_trap() {
    local trap_name=$1
    local damage=$2
    player_health=$((player_health - damage))
    echo "You triggered a $trap_name trap! -$damage health points."
    log_action "Player triggered a $trap_name trap. -$damage health points."
 }
#function to pause the game
function pause_game() {
    echo "Game paused."
    log_action "Game paused."
    read -p "Press Enter to continue..."
}
#function to display the player inventory
function view_inventory() {
    echo "Inventory: ${player_inventory[*]}"
    log_action "Player inventory displayed: ${player_inventory[*]}."
}
#function to display the player health
function check_health() {
    echo "Health: $player_health"
    log_action "Player health displayed: $player_health."
}

#function to quit the game
function quit_game() {
    echo "Exiting game..."
    log_action "Player quit the game."
    exit 0
}
#function to scan the place
function scan_place() {
    local stage_name=$1
    local task=$2
    echo "Scanning the area..."
    sleep 2
    case "$stage_name" in
    "Pre-Stage")
        case "$task" in
        "Task 1")
            echo "You found a hidden path to the North."
            log_action "Player scanned the area for Stage $stage_name, Task $task."
            ;;
        "Task 2")
            echo "You found a crate with supplies."
            echo "You received: 1x Water bottle, 1x First aid kit, 1x Flashlight."
            log_action "Player scanned the area for Stage $stage_name, Task $task."
            add_to_inventory "Water bottle" 1
            add_to_inventory "First aid kit" 1
            add_to_inventory "Flashlight" 1
            ;;
        "Task 3")
           echo "You see distant trees opening into a clearing to the east and hear the sound of rushing water to the north."
            log_action "Player scanned the area for Stage $stage_name, Task $task."
            ;;
        "task 4")
            echo "You discover carvings resembling ancient commands."
            echo "Commands: 'ls', 'cd', 'cat', 'pwd', 'echo', 'grep', 'chmod', 'mv', 'rm', 'cp', 'touch', 'mkdir', 'rmdir', 'clear'"
            echo "You feel a strange energy emanating from the carvings."
            echo "You sense that the commands may be useful later on."
            
            log_action "Player scanned the area for Stage $stage_name, Task $task."
            ;;
        "task 5")
            echo "the bridge is broken, you need to find another way to cross the river or going back."
            log_action "Player scanned the area for Stage $stage_name, Task $task."

        esac
        ;;
       esac

    log_action "Player scanned the area for Stage $stage_name, Task $task."
}
#function to check if the player used one of the game commands
function check_for_commands() {
    local command=$1
    local stage_name=$2
    local task=$3
    local player_input=$4
    case "$command" in
    pause)
        pause_game
        ;;
    inventory)
        view_inventory
        ;;
    scan)
        scan_place "$stage_name" "$task"
        ;;
    hint)
        display_hint "$stage_name" "$task"
        ;;
    health)
        check_health
        ;;
    map)
        cat ../assets/map.txt
        ;;

    quit)
        quit_game
        ;;
    
    *)
        echo "Invalid command."
        ;;
esac

}

