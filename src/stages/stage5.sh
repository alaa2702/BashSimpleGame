#!/bin/bash
# Stage 5: The Hidden Chamber
# Players begin exploring the temple and using the commands they've learned.
# Educational Focus: Array Manipulation

# Load helper scripts
source  utils/helpers.sh
source  utils/player.sh
source  utils/logs.sh

mistakes=0
survival_attempts=0
Max_mistakes=5

# Task: Create and Populate Arrays
function create_and_populate_arrays() {
    echo "Task: Create and populate an array with the sequence 1-10."
    read -p "Enter your script: " solution

    if [[ "$solution" == *"arr=(1 2 3 4 5 6 7 8 9 10)"* ]]; then
        echo "Correct! You created and populated the array."
    else
        ((mistakes++))
        echo "Incorrect. Mistakes: $mistakes/$Max_mistakes"
        check_mistakes
    fi
}

# Task: Iterate Through Arrays
function iterate_through_arrays() {
    echo "Task: Write a script to iterate through the array and print each element."
    read -p "Enter your script: " solution

    if [[ "$solution" == *"for item in"* && "$solution" == *"echo $item"* ]]; then
        echo "Correct! You successfully iterated through the array."
    else
        ((mistakes++))
        echo "Incorrect. Mistakes: $mistakes/$Max_mistakes"
        check_mistakes
    fi
}

# Task: Advanced Array Manipulations
function advanced_array_manipulations() {
    echo "Task: Filter the array to include only even numbers."
    read -p "Enter your script: " solution

    if [[ "$solution" == *"if (( item % 2 == 0 ))"* && "$solution" == *"even_arr+=("* ]]; then
        echo "Correct! You successfully filtered the array."
    else
        ((mistakes++))
        echo "Incorrect. Mistakes: $mistakes/$Max_mistakes"
        check_mistakes
    fi
}

# Task: Unlock Hidden Room
function unlock_hidden_room() {
    echo "Task: Match a pattern in the array to unlock the hidden room."
    echo "Pattern: Find the number 7."
    read -p "Enter your script: " solution

    if [[ "$solution" == *"if [[ $item -eq 7 ]]"* ]]; then
        echo "Correct! You unlocked the hidden room."
    else
        ((mistakes++))
        echo "Incorrect. Mistakes: $mistakes/$Max_mistakes"
        check_mistakes
    fi
}

# Task: Survival Task
function survival_task() {
    echo "SURVIVAL CHALLENGE: The floor collapses!"
    echo "You have a file 'gaps.txt' with the following contents:"
    echo "gap1\ngap2\ngap3"

    echo "Task: Write a script to iterate through 'gaps.txt' and bridge the gaps."
    read -p "Enter your script: " solution

    if [[ "$solution" == *"while read gap"* && "$solution" == *"echo \"Bridging $gap\""* ]]; then
        echo "You successfully bridged the gaps and survived!"
        log_action "Survival task completed successfully"
        return 0
    else
        ((survival_attempts++))
        if ((survival_attempts >= 2)); then
            echo "You failed to survive. Game Over!"
            exit 1
        else
            echo "Incorrect. Attempts remaining: $((2 - survival_attempts))"
            survival_task
        fi
    fi
}

# Check for Mistakes
function check_mistakes() {
    if ((mistakes >= Max_mistakes)); then
        echo "Too many mistakes! Survival task initiated."
        survival_task
    fi
}

# Stage Entry Point
function stage5() {
    display_stage_banner "The Hidden Chamber"

    echo "Welcome to Stage 5: The Hidden Chamber."

    create_and_populate_arrays
    iterate_through_arrays
    advanced_array_manipulations
    unlock_hidden_room

    # Successful Completion
    if ((mistakes < Max_mistakes)); then
        echo "You aligned the hall, found Codex fragments, and unlocked a shortcut for Stage 6!"
        log_action "Stage 5 completed"
        update_score 50
        save_stage_progress "Stage 5"
    fi
}

stage5
