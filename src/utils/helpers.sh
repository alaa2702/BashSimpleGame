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

# function used to check if the player enter a command that from the list of commands
function check_command() {
    local command=$1
    local current_stage=$2
    case "$command" in
    "cat map.txt")
        echo "Checking available files:"
        cat ../assets/playing_files/map.txt
        log_action "Player checked the map."
        return 1
        ;;
    "cat status.txt")
        echo "Checking player status:"
        cat ../assets/playing_files/status.txt
        log_action "Player checked their status."
        return 1
        ;;
    "cat hints.txt")
        echo "Checking available files:"
        display_hint "$current_stage" "hints"
        log_action "Player checked the hints."
        return 1
        ;;
    "cat inventory.txt")
        echo "Checking inventory contents:"
        cat ../assets/playing_files/inventory.txt
        log_action "Player checked their inventory."
        return 1
        ;;
    *)
        echo "Invalid choice."
        return 0
        ;;
    esac

}
