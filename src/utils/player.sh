#!/bin/bash
# utils/player.sh

# Initialize player stats
function init_player() {
    player_health=100
    player_inventory=()
    echo "Player initialized with health: $player_health."
    log_action "Player initialized with health: $player_health."
}

# Update player health
function update_health() {
    local amount=$1
    player_health=$((player_health + amount))
    if [[ $player_health -le 0 ]]; then
        echo "Your health has dropped to 0. Game over!"
        log_action "Player health dropped to 0. Game over."
        exit 1
    fi
    echo "Your health is now: $player_health."
    log_action "Player health updated to: $player_health."
}

# Add item to inventory
function add_to_inventory() {
    local item=$1
    player_inventory+=("$item")
    echo "You acquired: $item."
    log_action "Item added to inventory: $item."
}

# Display player stats
function display_player_stats() {
    echo "Health: $player_health"
    echo "Inventory: ${player_inventory[*]}"
    log_action "Player stats displayed: Health - $player_health, Inventory - ${player_inventory[*]}."
}
