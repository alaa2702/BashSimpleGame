#!/bin/bash
#this stage to help the player prepare for the expedition to the temple, and get familiar with the game mechanics.

# Load helper scripts
source utils/helpers.sh
source utils/player.sh
source utils/logs.sh


function task1_Navigation() {
    echo "Task 1: Navigate through the jungle."
    echo "You are surrounded by dense vegetation. You need to find your way out."
    echo "Which direction would you like to go?"
    echo "a) North"
    echo "b) West"
    echo "c) East"
    echo "Use 'cat map.txt' to display the contents of the map."
    echo "remember that you can always use 'cat' to see the content of a file."

    while true; do
        read -p "> " player_input
        case "$player_input" in
        a) echo "You chose to go North."
            log_action "Player chose to go North."
            break
            ;;
        b) echo "You chose to go West."
           echo "You are surrounded by dense vegetation. You need to find your way out."
           echo "you get back to the starting point."
            log_action "Player chose to go South."
           
            ;;
        c) echo "You chose to go East."
           echo "the path is blocked by a huge rock."
           echo "you need to find another way and go back."
            log_action "Player chose to go East."
            ;;
      
        "cat map.txt") echo "Checking available files:"
            cat  assets/player_files/map.txt
            ;;
        *) echo "Invalid choice."
            ;;
        esac
    done
}

function collect_supplies() {
    echo "Task 2: Gather supplies for the expedition."
    echo "You arrive at an abandoned campsite, and find a barrel."
    echo "You can use 'grep supply barrel.txt' to search for supplies."
    echo "You can use 'grep' to search for specific items in the list."

    while true; do
        read -p "> " player_input
        if [ "$player_input" == "grep" ] then
            echo "Searching for supplies in supplies.txt..."
            grep -i "supply" assets/playing_files/barrel.txt
            log_action "Player searched for supplies."
            echo "You found supplies in the barrel."
            echo "add them to your inventory."
            echo "You can create a file to store your inventory using 'touch inventory.txt'"
            while true; do
                read -p "> " player_input
                if [[ "$player_input" == "touch inventory.txt" ]]; then
                    touch assets/playing_files/inventory.txt
                    log_action "Player created an inventory file."
                    for i in $(grep -i "supply" assets/playing_files/barrel.txt | cut -d ":" -f 2)
                    do
                        add_to_inventory "$i" 1
                        echo "$i" >> assets/playing_files/inventory.txt
                    done
                    break
                else
                    echo "Invalid choice. Use 'touch inventory.txt' to create an inventory file."
                fi
            done
            
            break
        else
            echo "Invalid choice. Use 'grep' to search."
        fi
    done

    echo "Now, you can view your inventory using 'cat inventory.txt'."

    while true; do
        read -p "> " player_input
        if [[ "$player_input" == "cat inventory.txt" ]]; then
            echo "Displaying inventory contents:"
            cat  assets/playing_files/inventory.txt
            log_action "Player viewed inventory."
            break
        else
            echo "Invalid choice. Use 'cat inventory.txt' to view inventory."
        fi
    done
}

function next_path() {
    echo "Task 3: Choose the next path."
    echo "You reach a fork in the road. Which path would you like to take?"
    echo "a) East"
    echo "b) North"
    echo "Use 'cat hints.txt' to check for hints."
    while true; do
        read -p "> " player_input
        case "$player_input" in
        a) echo "You chose to go East. Moving..."
            log_action "Player chose to go East."
            Enter_the_Temple
            break
            ;;
        b) echo "You chose to go North. Heading towards the river..."
            log_action "Player chose to go North."
            river_crossing
            break
            ;;
        "cat hints.txt") echo "Checking available files:"
            cat assets/hints/hint/pre_stage_hints.txt
            ;;
        "cat map.txt")
            echo "Checking available files:"
            cat assets/playing_files/map.txt
            ;;
        ;;  
        *) echo "Invalid choice. Use 'a' or 'b'."
            ;;
        esac
    done
}

function river_crossing() {
    echo "Task 4: Cross the river."
    echo "You reach a river. There is a bridge to the North."
    echo "Would you like to cross the bridge to the other side?"
    echo "a) Yes"
    echo "b) No"
    while true; do
    read -p "> " player_input
    case "$player_input" in
    a) echo "You chose to cross the bridge. It collapses!"
        echo "You lose 20 health points."
        log_action "Player chose to cross the bridge and lost health."
        break
        ;;
    b) echo "You chose not to cross the bridge. Staying safe."
    log_action "Player chose not to cross the bridge."
    break
        ;;
    *) echo "Invalid choice. Use 'a' or 'b'."
       ;;
    esac
    done
    echo "You can use 'cat status.txt' to check your health status."
    while true; do
        read -p "> " player_input
        if [[ "$player_input" == "cat status.txt" ]]; then
            echo "Checking health status..."
            cat  assets/playing_files/status.txt
            log_action "Player checked health status."
            break
        else
            echo "Invalid choice. Use 'cat status.txt'."
        fi
    done    
    echo "Do you want to go back to the fork in the road?"
    echo "a) Yes"
    echo "b) No"
    while true; do
    read -p "> " player_input
    case "$player_input" in
    a) echo "You chose to go back to the fork in the road."
        log_action "Player chose to go back to the fork in the road."
        next_path
        break
        ;;
    b) echo "You chose not to go back to the fork in the road."
    log_action "Player chose not to go back to the fork in the road."
    ;;
    *) echo "Invalid choice. Use 'a' or 'b'."
       ;;
    esac
    done
    
}

function Enter_the_Temple() {
    echo "Task 4: Enter the temple."
    echo "You find a stone pillar with glowing ancient carvings."
    echo "Use 'cat carvings.txt' to examine the carvings."

    while true; do
        read -p "> " player_input
        if [[ "$player_input" == "cat carvings.txt" ]]; then
            echo "Examining carvings..."
            cat assets/playing_files/carvings.txt
            log_action "Player examined carvings."
            break
        else
            echo "Invalid choice. Use 'cat carvings.txt'."
        fi
    done

    echo "The ground rumbles as a hidden chamber is revealed."
    echo "You find a strange stone with a button. Pressing it opens a secret passage."
    echo "Welcome, Explorer. The journey continues..."
    log_action "Player pressed the button and opened the secret passage."
}

function pre_stage() {
    # Display stage banner
    echo "=============================="
    echo " Pre-Stage: Jungle Trek"
    echo "=============================="

    echo "You are deep in the jungle. Your goal is to prepare for the expedition to the temple."
    
    # Task 1: Navigation
    task1_Navigation

    # Task 2: Collect supplies
    collect_supplies

    # Task 3: Choose the next path
    next_path
    #list what he learned in this stage about bash commands
    echo "You learned about basic bash commands such as 'cat', 'grep', and 'touch'."
    echo "''cat' is used to display the contents of a file."
    echo "''grep' is used to search for specific text in a file."
    echo "''touch' is used to create a new file."
    update_score 20 # Update player score
    save_stage_progress "Pre-Stage" "score " # Save stage progress

    # Pre-stage Completion
    echo "You are ready to continue your journey into the temple."
    log_action "Pre-stage completed."
}

