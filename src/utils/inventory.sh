#!/bin/bash
# utils/inventory.sh

# Check if an item exists in the inventory
function check_inventory() {
    local item=$1
    for i in "${player_inventory[@]}"; do
        if [[ "$i" == "$item" ]]; then
            echo "Yes, you have $item."
            return 0
        fi
    done
    echo "No, you don't have $item."
    return 1
}

# Remove an item from the inventory
function remove_from_inventory() {
    local item=$1
    for i in "${!player_inventory[@]}"; do
        if [ "${player_inventory[$i]}" = $item ]]; then
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
