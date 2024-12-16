#! /bin/bash
# utils/logs.sh


function creat_Log_file_for_player() {
    player_name=$1
    current_date=$(date +%F)
    check_log_file_exist

}

function check_log_file_exist() {
    log_file_name="assets/logs/${player_name}_log_${current_date}.log"
    if [ ! -f $log_file_name ]
    then
        touch "$log_file_name"
    fi
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
