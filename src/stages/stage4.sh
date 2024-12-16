#!/bin/bash
# Stage 4: Artifact Fragment Collection
# Educational Focus: Function Design and Implementation

# Load helper scripts
source utils/helpers.sh
source utils/player.sh
source utils/logs.sh

mistakes=0
survival_attempts=0
max_mistakes=5

# Dynamic hints for each task
function provide_hint() {
    local task_name=$1
    local mistake_count=$2

    case "$task_name" in
        "disable_trap")
            case "$mistake_count" in
                1) echo "Hint: Create a function named 'disable_trap' and include the action 'cut wires' inside it." ;;
                2) echo "Hint: Ensure your function syntax is correct, e.g., 'function disable_trap { cut wires; }'." ;;
                *) echo "Critical Hint: Use 'function disable_trap { echo \"cut wires\"; }' to solve the trap." ;;
            esac
            ;;
        "solve_puzzle")
            case "$mistake_count" in
                1) echo "Hint: Create a function named 'solve_riddle' and ensure it returns 'echo'." ;;
                2) echo "Hint: Use 'return echo' inside the function to provide the correct answer." ;;
                *) echo "Critical Hint: Write 'function solve_riddle { return echo; }' to solve the puzzle." ;;
            esac
            ;;
        "open_hidden_chamber")
            case "$mistake_count" in
                1) echo "Hint: Use conditions (e.g., if/else) to ensure the numbers meet the requirements." ;;
                2) echo "Hint: Ensure your function iterates over possible values for the combination." ;;
                *) echo "Critical Hint: Use 'if [ ... ] && [ ... ]; then ... fi' to solve the lock." ;;
            esac
            ;;
    esac
}

# Task 1: Disable a trap
function disable_trap() {
    echo "You enter the chamber, and the floor clicks beneath your feet. Suddenly, darts shoot out from the walls!"
    echo "Task: Write a function to disable the dart trap before it’s too late."

    while true; do
        read -p "Enter your function script: " solution

        if [[ "$solution" == *"function disable_trap"* && "$solution" == *"cut wires"* ]]; then
            echo "You successfully cut the wires, and the darts stop firing. The path is clear!"
            log_action "Trap disabled successfully."
            break
        else
            ((mistakes++))
            echo "The darts keep firing! Mistakes: $mistakes/$max_mistakes"
            provide_hint "disable_trap" "$mistakes"
            check_mistakes
        fi
    done
}

# Task 2: Solve a mini-puzzle
function solve_puzzle() {
    echo "You find a locked chest glowing faintly with ancient energy."
    echo "A riddle appears: 'I speak without a mouth and hear without ears. I have no body, but I come alive with wind. What am I?'"

    while true; do
        read -p "Create a function named 'solve_riddle' to return the answer: " solution

        if [[ "$solution" == *"function solve_riddle"* && "$solution" == *"return echo"* ]]; then
            echo "The chest clicks open, revealing 3 shimmering Codex fragments!"
            add_to_inventory "Fragment4"
            add_to_inventory "Fragment5"
            add_to_inventory "Fragment6"
            log_action "Riddle solved successfully with a custom function."
            break
        else
            ((mistakes++))
            echo "The chest remains locked. Mistakes: $mistakes/$max_mistakes"
            provide_hint "solve_puzzle" "$mistakes"
            check_mistakes
        fi
    done
}

# Task 3: Open a hidden chamber
function open_hidden_chamber() {
    echo "You find a massive stone door with a complex mechanical lock. The lock has three rotating dials, each labeled with numbers from 1 to 9."
    echo "Task: Write a function to solve the combination lock using these clues:"
    echo "1. The sum of the three numbers is 15."
    echo "2. The first number is twice the second number."
    echo "3. The third number is 5 less than the first number."

    while true; do
        read -p "Create a function named 'solve_lock' that implements the conditions: " solution

        if [[ "$solution" == *"function solve_lock()"* && "$solution" == *"if"* && "$solution" == *"fi"* ]]; then
            echo "The lock clicks open, and the stone door slides aside to reveal another Codex fragment!"
            add_to_inventory "Fragment7"
            log_action "Hidden chamber unlocked successfully with a custom function."
            break
        else
            ((mistakes++))
            echo "The lock remains jammed. Mistakes: $mistakes/$max_mistakes"
            provide_hint "open_hidden_chamber" "$mistakes"
            check_mistakes
        fi
    done
}

# Function to stabilize a collapsing ceiling
function stabilize_ceiling() {
    echo "SURVIVAL CHALLENGE: The chamber begins to shake violently, and the ceiling starts collapsing!"
    echo "You must act quickly to build supports from the available resources: wood, rope, and metal rods."
    
    while ((survival_attempts < 2)); do
        read -p "Enter your solution (e.g., 'wood+rope+metal rods'): " solution

        if [[ $solution == "wood+rope+metal rods" ]]; then
            echo "You skillfully construct supports, and the ceiling stabilizes just in time!"
            log_action "Ceiling stabilized successfully."
            return 0
        else
            ((survival_attempts++))
            echo "The ceiling continues to collapse! Attempts remaining: $((2 - survival_attempts))"
            echo "Hint: Use all three resources (wood, rope, metal rods) and combine them in the correct format."
        fi
    done

    echo "You failed to stabilize the ceiling. Game Over!"
    exit 1
}

# Function to check mistakes
function check_mistakes() {
    if ((mistakes >= max_mistakes)); then
        echo "You’ve made too many mistakes! The chamber begins to collapse around you."
        stabilize_ceiling
    fi
}

# Stage Entry Point
function stage4() {
    display_stage_banner "Artifact Fragment Collection"

    echo "Welcome to Stage 4! Navigate the challenges to collect Codex fragments and escape the ancient chamber."

    # Task 1: Disable a trap
    disable_trap

    # Task 2: Solve a mini-puzzle
    solve_puzzle

    # Task 3: Open a hidden chamber
    open_hidden_chamber

    # Successful Completion
    if ((mistakes < max_mistakes)); then
        echo "Congratulations! You’ve collected all the fragments and escaped the chamber."
        echo "Fragments collected: 4"
        log_action "Stage 4 completed successfully."
        update_score 40
        save_stage_progress "Stage 4"
    fi
}

# Start Stage 4
stage4
