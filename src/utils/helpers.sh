#!/bin/bash
#utils/helpers

source utils/player.sh
source utils/logs.sh


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

# function used to check if the player enter a command that from the list of commands
function check_command() {
    local command=$1
    local current_stage=$2
    case "$command" in
    "cat map.txt")
        echo "Checking available files:"
        cat assets/playing_files/map.txt
        log_action "Player checked the map."
        return 1
        ;;
    "cat status.txt")
        echo "Checking player status:"
        cat assets/playing_files/status.txt
        log_action "Player checked their status."
        return 1
        ;;
    "cat inventory.txt")
        echo "Checking inventory contents:"
        cat assets/playing_files/inventory.txt
        log_action "Player checked their inventory."
        return 1
        ;;
    "quit")
        echo "Exiting the game..."
        save_stage_progress $current_stage
        exist 0
        log_action "Player exited the game."
    *)
        echo "Invalid choice."
        return 0
        ;;
    esac

}
