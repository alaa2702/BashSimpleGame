#!/bin/bash


function check_file_exist() {
    log_file_name="../assets/logs/${player_name}_log_${current_date}.log"
    if [ ! -f $log_file_name ]
    then
        touch "$log_file_name"
    fi
}

function creat_file_for_player() {
    player_name=$1
    current_date=$(date +%F)
    check_file_exist
}



# Append a log entry with a timestamp
function log_action() {
    local message=$1
    echo "$(date '+%Y-%m-%d %H:%M:%S'): $message" >> "$log_file_name"
}


#log stage completion
function log_stage_completion() {
    local stage=$1
    local health=$2
    log_action "Stage $stage completed. Remaining health: $health."
}

# Log errors encountered during gameplay
function log_error() {
    local error_message=$1
    echo "$(date '+%Y-%m-%d %H:%M:%S') [ERROR]: $error_message" >> "$log_file_name"
}

# Display a hint for the current stage
function display_hint() {
    local stage=$1
    hint=$(grep "^$stage:" assets/hints.txt | cut -d':' -f2-)
    if [[ -n "$hint" ]]; then
        echo "Hint for Stage $stage: $hint"
        log_action "Hint displayed for Stage $stage: $hint"
    else
        echo "No hints available for this stage."
        log_error "Hint requested for Stage $stage but not found."
    fi
}

# Print a banner for a stage
function display_stage_banner() {
    local stage_name=$1
    echo "========================================"
    echo "          $stage_name"
    echo "========================================"
    log_action "Entered $stage_name."
}
