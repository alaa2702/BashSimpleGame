#!/bin/bash

# Stage 6: Temple Collapse Escape
# Educational Focus: File Operations and System Interactions

# Load helper scripts
source utils/helpers.sh
source utils/player.sh
source utils/logs.sh

mistakes=0
survival_attempts=0
Max_mistakes=5

# Task: Read Configuration Files
define_escape_route() {
    echo "Reading escape route configuration..."
    if [[ -f "escape_routes.txt" ]]; then
        echo "Escape routes file found."
        local route=$(grep -i "safe" escape_routes.txt | head -n 1)
        if [[ -n "$route" ]]; then
            echo "Found a safe route: $route"
            log_action "Safe route identified: $route"
        else
            echo "No safe routes identified!"
            ((mistakes++))
            check_mistakes
        fi
    else
        echo "Escape routes file missing!"
        ((mistakes++))
        check_mistakes
    fi
}

# Task: Write Progress Logs
log_escape_progress() {
    local message=$1
    echo "Logging progress: $message"
    echo "$(date): $message" >> escape_progress.log
}

# Task: Check File and Directory Existence
validate_path() {
    local path=$1
    echo "Checking path: $path"
    if [[ -d "$path" ]]; then
        echo "Directory exists: $path"
    elif [[ -f "$path" ]]; then
        echo "File exists: $path"
    else
        echo "Path does not exist: $path"
        ((mistakes++))
        check_mistakes
    fi
}

# Task: Combine Codex Fragments
combine_codex_fragments() {
    echo "Combining Codex fragments..."
    local fragments=(fragment_*.txt)
    if (( ${#fragments[@]} == 8 )); then
        cat "${fragments[@]}" > Codex_of_Computis.txt
        echo "Codex fully restored!"
        log_action "Codex fully restored"
    else
        echo "Not all fragments found. Fragments missing: $((8 - ${#fragments[@]}))"
        ((mistakes++))
        check_mistakes
    fi
}

# Survival Task: Clear Debris to Escape
survival_task() {
    echo "SURVIVAL TASK: Clearing debris to escape!"
    for obstacle in debris_*.txt; do
        echo "Clearing $obstacle..."
        rm "$obstacle" || {
            echo "Failed to clear $obstacle!"
            ((survival_attempts++))
            if ((survival_attempts >= 2)); then
                echo "You failed to survive. Trapped in the temple forever!"
                exit 1
            fi
        }
    done
    echo "Debris cleared. Escape route accessible."
    log_action "Survival task completed"
}

# Check for Mistakes
check_mistakes() {
    if ((mistakes >= Max_mistakes)); then
        echo "Too many mistakes! Initiating survival task."
        survival_task
    fi
}

# Stage Entry Point
function stage6() {
    display_stage_banner "Temple Collapse Escape"

    echo "Analyzing escape options..."
    define_escape_route

    echo "Validating paths..."
    validate_path "./exit"

    echo "Writing progress logs..."
    log_escape_progress "Escape route identified and validated."

    echo "Combining Codex fragments..."
    combine_codex_fragments

    # Successful Completion
    if ((mistakes < Max_mistakes)); then
        echo "You successfully escape the collapsing temple!"
        log_action "Stage 6 completed"
        update_score 50
        save_stage_progress "Stage 6"
    fi
}

stage6
