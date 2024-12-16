#!/bin/bash
# Stage 5: The Hidden Chamber
# Educational Focus: Array Manipulation

# Load helper scripts
source utils/helpers.sh
source utils/player.sh
source utils/logs.sh

mistakes=0
survival_attempts=0
max_mistakes=5

# Function to provide dynamic hints
generate_hint() {
    local task="$1"
    case "$task" in
        "create_and_populate_arrays")
            echo "Hint: Use the format 'arr=(1 2 3 ... 10)' to create an array. Ensure you include all numbers from 1 to 10 without missing any."
            ;;
        "iterate_through_arrays")
            echo "Hint: Use 'for item in' to iterate through the array. Print each element using 'echo \$item'. Check your loop syntax carefully."
            ;;
        "advanced_array_manipulations")
            echo "Hint: Use 'if (( item % 2 == 0 ))' to identify even numbers. Append them to a new array using 'even_arr+=(\$item)'."
            ;;
        "unlock_hidden_room")
            echo "Hint: Use 'if [[ \$item -eq 7 ]]' to match the number 7 in the array. Ensure the condition is inside a loop."
            ;;
        "survival_task")
            echo "Hint: Use a 'while read' loop to read each line of 'gaps.txt'. Bridge each gap with 'echo \"Bridging \$gap\"'."
            ;;
        *)
            echo "Hint: Review your syntax and ensure the logic aligns with the task requirements."
            ;;
    esac
}

# Task: Create and Populate Arrays
function create_and_populate_arrays() {
    echo "The ancient hall echoes as tiles begin to shift. You must align the sequence to stabilize the room."
    echo "Task: Create and populate an array with the numbers 1-10 to align the shifting tiles."
    echo "Example: arr=(number1 number2 ... number10)"
    read -p "Enter your solution: " solution

    if [[ "$solution" == *"arr=(1 2 3 4 5 6 7 8 9 10)"* ]]; then
        echo "The tiles align, and the chamber stabilizes!"
        log_action "Array created and populated successfully."
    else
        ((mistakes++))
        echo "The tiles tremble! Mistakes: $mistakes/$max_mistakes"
        generate_hint "create_and_populate_arrays"
        check_mistakes
    fi
}

# Task: Iterate Through Arrays
function iterate_through_arrays() {
    echo "The next puzzle activates: glowing symbols appear on each tile. Iterate through the array to reveal their meaning."
    echo "Task: Write a script to iterate through the array and print each element."
    read -p "Enter your solution: " solution

    if [[ "$solution" == *"for item in"* && "$solution" == *"echo \$item"* ]]; then
        echo "The symbols reveal their secrets as you iterate through the array!"
        log_action "Array iteration successful."
    else
        ((mistakes++))
        echo "The symbols dim. Mistakes: $mistakes/$max_mistakes"
        generate_hint "iterate_through_arrays"
        check_mistakes
    fi
}

# Task: Advanced Array Manipulations
function advanced_array_manipulations() {
    echo "A challenge appears on the walls: only the even numbers hold the key to unlocking the next door."
    echo "Task: Filter the array to include only even numbers."
    echo "Example: if (( item % 2 == 0 )); then even_arr+=(\$item); fi"
    read -p "Enter your solution: " solution

    if [[ "$solution" == *"if (( item % 2 == 0 ))"* && "$solution" == *"even_arr+=("* ]]; then
        echo "You extract the key numbers, and the door creaks open!"
        log_action "Array filtered for even numbers successfully."
    else
        ((mistakes++))
        echo "The door remains sealed. Mistakes: $mistakes/$max_mistakes"
        generate_hint "advanced_array_manipulations"
        check_mistakes
    fi
}

# Task: Unlock Hidden Room
function unlock_hidden_room() {
    echo "The final puzzle appears: a glowing tile hints at the number 7."
    echo "Task: Match the number 7 in the array to unlock the hidden room."
    echo "Example: if [[ \$item -eq 7 ]]; then echo 'Found 7'; fi"
    read -p "Enter your solution: " solution

    if [[ "$solution" == *"if [[ \$item -eq 7 ]]"* ]]; then
        echo "The room unlocks, revealing ancient treasures and Codex fragment!"
        add_to_inventory "Fragment8"
        log_action "Hidden room unlocked successfully."
    else
        ((mistakes++))
        echo "The tile remains dormant. Mistakes: $mistakes/$max_mistakes"
        generate_hint "unlock_hidden_room"
        check_mistakes
    fi
}

# Task: Survival Task
function survival_task() {
    echo "SURVIVAL CHALLENGE: The chamber's floor begins to collapse! Debris falls, creating a deadly chasm."
    echo "You have a file 'gaps.txt' with the following gaps:"
    echo -e "gap1\ngap2\ngap3"
    echo "Task: Write a script to iterate through 'gaps.txt' and bridge the gaps."
    echo "Example: while read gap; do echo \"Bridging \$gap\"; done < gaps.txt"
    read -p "Enter your solution: " solution

    if [[ "$solution" == *"while read gap"* && "$solution" == *"echo \"Bridging \$gap\""* ]]; then
        echo "You bridge the gaps and survive the collapse!"
        log_action "Survival task completed successfully."
    else
        ((survival_attempts++))
        if ((survival_attempts >= 2)); then
            echo "The chasm consumes you. Game Over!"
            exit 1
        else
            echo "The gap widens! Attempts remaining: $((2 - survival_attempts))"
            generate_hint "survival_task"
            survival_task
        fi
    fi
}

# Check for Mistakes
function check_mistakes() {
    if ((mistakes >= max_mistakes)); then
        echo "Too many mistakes! The room collapses violently. Initiating survival task."
        survival_task
    fi
}

# Stage Entry Point
function stage5() {
    display_stage_banner "The Hidden Chamber"

    echo "Welcome to Stage 5: The Hidden Chamber. The room tests your knowledge of arrays with ancient puzzles."

    create_and_populate_arrays
    iterate_through_arrays
    advanced_array_manipulations
    unlock_hidden_room

    # Successful Completion
    if ((mistakes < max_mistakes)); then
        echo "You align the hall, uncover the Codex fragments, and unlock a shortcut for Stage 6!"
        log_action "Stage 5 completed"
        update_score 50
        save_stage_progress "Stage 5"
    fi
}

# Start Stage 5
stage5
