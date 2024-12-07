#!/bin/bash
# utils/scoring.sh

# Initialize the player's score
function initialize_score() {
    player_score=0
    echo "Your score is: $player_score"
}

# Update the score based on player actions
function update_score() {
    local points=$1
    player_score=$((player_score + points))
    echo "Your score is now: $player_score"
    log_action "Score updated: +$points, Total score: $player_score"
}

# Deduct points from the score (e.g., for failure or penalties)
function deduct_score() {
    local points=$1
    player_score=$((player_score - points))
    if [ $player_score -lt 0 ] 
    then
        player_score=0  # Ensure score doesn't go below zero
    fi
    echo "Your score is now: $player_score"
    log_action "Score deducted: -$points, Total score: $player_score"
}

# Save the player's score to a file
function save_score() {
    local score_file="../assets/saves/player_score.txt"

    # Create the saves directory if it doesn't exist
    mkdir -p "$(dirname "$score_file")"

    # Save the player's score to the file
    echo "$player_score" > "$score_file"
    echo "Your score has been saved."
    log_action "Player score saved: $player_score"
}

# Load the player's score from a file
function load_score() {
    local score_file="assets/saves/player_score.txt"

    # Check if the score file exists
    if [ -f $score_file ]
    then
        player_score=$(cat "$score_file")
        echo "Your score is: $player_score"
        log_action "Player score loaded: $player_score"
    else
        initialize_score
    fi
}

# Track the player's stage progress
function save_stage_progress() {
    local progress_file="assets/saves/player_stage_progress.txt"

    # Create the saves directory if it doesn't exist
    mkdir -p "$(dirname "$progress_file")"

    # Save the player's current stage to the file
    echo "$current_stage" > "$progress_file"
    echo "Your stage progress has been saved."
    log_action "Player stage progress saved: Stage $current_stage"
}

# Load the player's stage progress
function load_stage_progress() {
    local progress_file="assets/saves/player_stage_progress.txt"

    # Check if the progress file exists
    if [[ -f "$progress_file" ]]; then
        current_stage=$(cat "$progress_file")
        echo "You are currently on Stage $current_stage."
        log_action "Player stage progress loaded: Stage $current_stage"
    else
        current_stage=1
        echo "Starting at Stage 1."
    fi
}
