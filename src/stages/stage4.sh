#!/bin/bash
# Stage 4: Artifact Fragment Collection
# Educational Focus: Function Design and Implementation

# Load helper scripts
source utils/helpers.sh
source utils/player.sh
source utils/logs.sh

mistakes=0
survival_attempts=0
Max_mistakes=5

# Function to disable traps
function disable_trap() {
    echo "You enter the chamber, and the floor clicks beneath your feet. Suddenly, darts shoot out from the walls!"
    echo "Task: Write a function to disable the dart trap before it’s too late."
    echo "Hint: Use 'function disable_trap() { ... }' and include 'cut wires' in the function body."
    
    read -p "Enter your function script: " solution

    if [[ "$solution" == *"function disable_trap"* && "$solution" == *"cut wires"* ]]; then
        echo "You successfully cut the wires, and the darts stop firing. The path is clear!"
        log_action "Trap disabled successfully."
    else
        ((mistakes++))
        echo "The darts keep firing! Mistakes: $mistakes/$Max_mistakes"
        if ((mistakes < Max_mistakes)); then
            echo "Hint: Ensure your function includes 'function disable_trap()' and 'cut wires' as part of the solution."
        fi
        check_mistakes
    fi
}

# Function to solve a mini-puzzle
function solve_puzzle() {
    echo "You find a locked chest glowing faintly with ancient energy."
    echo "A riddle appears: 'I speak without a mouth and hear without ears. I have no body, but I come alive with wind. What am I?'"
    echo "Task: Solve the riddle to open the chest."

    read -p "Your answer: " answer

    if [[ $answer == "echo" ]]; then
        echo "The chest clicks open, revealing a shimmering Codex fragment!"
        log_action "Riddle solved successfully."
    else
        ((mistakes++))
        echo "The chest remains locked. Mistakes: $mistakes/$Max_mistakes"
        if ((mistakes < Max_mistakes)); then
            echo "Hint: Think of something that resonates or reflects sound waves."
        fi
        check_mistakes
    fi
}

# Function to open a hidden chamber (Edited)
function open_hidden_chamber() {
    echo "You find a massive stone door with a complex mechanical lock. The lock has three rotating dials, each labeled with numbers from 1 to 9."
    echo "Task: Solve the combination lock using the following clues:"
    echo "1. The sum of the three numbers is 15."
    echo "2. The first number is twice the second number."
    echo "3. The third number is 5 less than the first number."
    echo "Enter the three numbers separated by spaces (e.g., '6 3 4')."

    read -p "Enter your solution: " num1 num2 num3

    if [[ $num1 -eq 6 && $num2 -eq 3 && $num3 -eq 1 ]]; then
        echo "The lock clicks open, and the stone door slides aside to reveal another Codex fragment!"
        log_action "Hidden chamber unlocked successfully."
    else
        ((mistakes++))
        echo "The lock remains jammed. Mistakes: $mistakes/$Max_mistakes"
        if ((mistakes < Max_mistakes)); then
            echo "Hint: Carefully recheck the clues and your calculations."
        fi
        check_mistakes
    fi
}

# Function to stabilize a collapsing ceiling
function stabilize_ceiling() {
    echo "SURVIVAL CHALLENGE: The chamber begins to shake violently, and the ceiling starts collapsing!"
    echo "You must act quickly to build supports from the available resources: wood, rope, and metal rods."
    echo "Task: Combine all three resources to stabilize the ceiling."

    while ((survival_attempts < 2)); do
        read -p "Enter your solution (e.g., 'wood+rope+metal rods'): " solution

        if [[ $solution == "wood+rope+metal rods" ]]; then
            echo "You skillfully construct supports, and the ceiling stabilizes just in time!"
            log_action "Ceiling stabilized successfully."
            return 0
        else
            ((survival_attempts++))
            echo "The ceiling continues to collapse! Attempts remaining: $((2 - survival_attempts))"
            if ((survival_attempts < 2)); then
                echo "Hint: Use all three resources (wood, rope, metal rods) and combine them in the correct format."
            fi
        fi
    done

    echo "You failed to stabilize the ceiling. Game Over!"
    exit 1
}

# Function to check mistakes
function check_mistakes() {
    if ((mistakes >= Max_mistakes)); then
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
    if ((mistakes < Max_mistakes)); then
        echo "Congratulations! You’ve collected all the fragments and escaped the chamber."
        echo "Fragments collected: 4"
        log_action "Stage 4 completed successfully."
        update_score 40
        save_stage_progress "Stage 4"
    fi
}

# Start Stage 4
stage4
