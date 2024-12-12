#!/bin/bash
# Stage 4: Artifact Fragment Collection
# Educational Focus: Function Design and Implementation

# Load helper scripts
source ../utils/helpers.sh
source ../utils/player.sh
source ../utils/logs.sh

mistakes=0
survival_attempts=0
Max_mistakes=5

# Function to disable traps
function disable_trap() {
    local trap_type=$1
    echo "Attempting to disable trap: $trap_type"

    case $trap_type in
        "dart")
            echo "Using logic to cut wires..."
            # Logic to disable dart traps
            echo "Trap disabled!"
            return 0
            ;;
        "pressure")
            echo "Carefully removing weights from pressure plates..."
            # Logic to disable pressure traps
            echo "Trap disabled!"
            return 0
            ;;
        *)
            echo "Unknown trap type! Failed to disable."
            return 1
            ;;
    esac
}

# Function to solve a mini-puzzle
function solve_puzzle() {
    echo "You encounter a locked chest with a riddle:"
    echo "I speak without a mouth and hear without ears. I have no body, but I come alive with wind. What am I?"
    read -p "Your answer: " answer

    if [[ $answer == "echo" ]]; then
        echo "Correct! The chest opens, revealing a Codex fragment."
        return 0
    else
        echo "Incorrect answer!"
        ((mistakes++))
        check_mistakes
        return 1
    fi
}

# Function to open a hidden chamber
function open_hidden_chamber() {
    echo "You find a hidden door with a series of symbols."
    echo "Task: Match the symbols in the correct order."
    echo "Sequence: ⚡, ✨, 🔒"
    read -p "Enter the sequence (comma-separated): " sequence

    if [[ $sequence == "⚡,✨,🔒" ]]; then
        echo "The hidden chamber opens, revealing another Codex fragment."
        return 0
    else
        echo "Incorrect sequence!"
        ((mistakes++))
        check_mistakes
        return 1
    fi
}

# Function to stabilize a collapsing ceiling
function stabilize_ceiling() {
    echo "SURVIVAL CHALLENGE: The ceiling is collapsing!"
    echo "You must use your resources wisely to construct supports."
    echo "Available resources: wood, rope, metal rods."

    read -p "Enter your solution (e.g., 'wood+rope+metal rods'): " solution

    if [[ $solution == "wood+rope+metal rods" ]]; then
        echo "You successfully stabilize the ceiling and escape!"
        return 0
    else
        ((survival_attempts++))
        if ((survival_attempts >= 2)); then
            echo "You failed to stabilize the ceiling. Game Over!"
            exit 1
        else
            echo "That solution didn't work! Attempts remaining: $((2 - survival_attempts))"
            stabilize_ceiling
        fi
    fi
}

# Function to check mistakes
function check_mistakes() {
    if ((mistakes >= Max_mistakes)); then
        echo "Too many mistakes! The room begins to collapse."
        stabilize_ceiling
    fi
}

# Stage Entry Point
function stage4() {
    display_stage_banner "Artifact Fragment Collection"

    echo "Welcome to Stage 4! Use your skills to collect Codex fragments."

    # Task 1: Disable a trap
    disable_trap "dart"

    # Task 2: Solve a mini-puzzle
    solve_puzzle

    # Task 3: Open a hidden chamber
    open_hidden_chamber

    # Successful Completion
    if ((mistakes < Max_mistakes)); then
        echo "You have completed Stage 4!"
        echo "Fragments collected: 4"
        log_action "Stage 4 completed."
        update_score 40
        save_stage_progress "Stage 4"
    fi
}

# Start Stage 4
stage4
