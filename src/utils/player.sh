#!/bin/bash
# utils/player.sh

source ../utils/logs.sh
# Initialize player stats
function init_player() {
    player_name=$1
    player_health=100
    player_inventory=()
    player_score=0
    creat_file_for_player $player_name
    echo "Player initialized with health: $player_health."
    log_action "Player $player_name initialized with health: $player_health."
}

# Update player health
function update_health() {
    local amount=$1
    player_health=$((player_health + amount))
    if [ $player_health -le 0 ]
    then
        echo "Your health has dropped to 0. Game over!"
        log_action "Player health dropped to 0. Game over."
        exit 1
    fi
    echo "Your health is now: $player_health."
    #update the status file
    Update_player_status_file
    log_action "Player health updated to: $player_health."
}
# Check if an item exists in the inventory
function check_inventory() {
    local item=$1
    for i in "${player_inventory[@]}"; do
        if [ "$i" == "$item" ] then
            return 0
        fi
    return 1
    done
}
# Add item to inventory
function add_to_inventory() {
    local item=$1
    local item_num=$2
    for i in $(seq 1 $item_num)
    do
        check_inventory "$item"
        if [ $? -eq 0 ]
        then
            echo "You already have $item."
            log_error "Attempted to add $item to inventory, but it already exists."
            return
        fi
        player_inventory+=("$item")
    done
    echo "You acquired: $item."
    Update_player_status_file
    log_action "Item added to inventory: $item."
}


# Remove an item from the inventory
function remove_from_inventory() {
    local item=$1
    for i in "${!player_inventory[@]}"; do
        if [ "${player_inventory[$i]}" = $item ] then
            unset 'player_inventory[$i]'
            echo "$item removed from inventory."
            log_action "Item removed from inventory: $item."
            return 0
        fi
    done
    echo "Item $item not found in inventory."
    log_error "Attempted to remove $item from inventory, but it was not found."
    return 1
}
# Display player stats
function display_player_stats() {
    echo "Health: $player_health"
    echo "Inventory: ${player_inventory[*]}"
    echo "Score: $player_score"
    log_action "Player stats displayed: Health - $player_health, Inventory - ${player_inventory[*]}."
}
function Update_player_status_file() {
   echo -e "Health: $player_health \nInventory: ${player_inventory[*]} \nScore: $player_score" > ../assets/playing_files/status.txt
}


# Update the score based on player actions
function update_score() {
    local points=$1
    player_score=$((player_score + points))
    echo "Your score is now: $player_score"
    Update_player_status_file
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
    Update_player_status_file
    log_action "Score deducted: -$points, Total score: $player_score"
}


# Track the player's stage progress
function save_stage_progress() {
    local current_stage=$1
    local progress_file="../assets/saves/player_stage_progress.txt"
    # Create the saves directory if it doesn't exist
    mkdir -p "$(dirname "$progress_file")"

    # Save the player's current stage to the file
    echo "stage $current_stage" >> "$progress_file"
    echo "your score is $pplayer_score" >> "$progress_file"
    echo "your heath is $player_health" >> "$progress_file"
    echo "your inventory is ${player_inventory[*]}" >> "$progress_file"
    echo "Your stage progress has been saved."
    log_action "Player stage progress saved: Stage $current_stage"
}



# Load the player's stage progress
function load_stage_progress() {
    local progress_file="../assets/saves/player_stage_progress.txt"

    # Check if the progress file exists
    if [ -f "$progress_file" ]
    then
        current_stage=$(grep -i "stage" "$progress_file" | cut -d " " -f 2)
        score=$(grep -i "your score is" "$progress_file" | cut -d " " -f 4)
        health=$(grep -i "your heath is" "$progress_file" | cut -d " " -f 4)
        inventory=$(grep -i "your inventory is" "$progress_file" | cut -d " " -f 4)
        echo "You are currently on Stage $current_stage."
        log_action "Player stage progress loaded: Stage $current_stage"
    else
        current_stage=1
        echo "Starting at Stage 1."
        log_error "No saved progress found. Starting at Stage 1."
        return 0
    fi
}
