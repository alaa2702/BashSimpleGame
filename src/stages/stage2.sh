#!/bin/bash
# Stage 2: Deadly Traps Maze
# Educational Focus: Conditional Statements and Logic

# Load helper scripts
source  utils/helpers.sh
source  utils/player.sh
source  utils/logs.sh

mistakes=0
survival_attempts=0
max_mistakes=5

# Task 1: Maze Scan & Dynamic Obstacles
function maze_scan() {
    echo "Scanning the maze..."
    traps=("Dart trap" "Pressure plate trap" "Fire jets")
    
    for trap in "${traps[@]}"; do
        echo "Detected: $trap"
        case $trap in
            "Dart trap")
                disable_dart_trap
                ;;
            "Pressure plate trap")
                solve_pressure_plate
                ;;
            "Fire jets")
                navigate_fire_jets
                ;;
        esac
    done
}

# Task 2: Disarm Dart Trap
function disable_dart_trap() {
    echo "You encounter a dart trap with a control panel."
    echo "Write an if-else script to test wires and disable the trap."
    echo "Example:
    if [[ condition ]]; then
        action
    else
        action
    fi"
    read -p "Enter your script: " solution

    if [[ "$solution" == *"if"* && "$solution" == *"test_voltage"* && "$solution" == *"cut_wire"* ]]; then
        echo "Trap disarmed successfully!"
    else
        ((mistakes++))
        echo "Incorrect script! Mistakes: $mistakes/$max_mistakes"
        check_mistakes
    fi
}

# Task 3: Solve Pressure Plate Puzzle
function solve_pressure_plate() {
    echo "You find a pressure plate requiring a sequence of steps to deactivate."
    echo "Task: Write a loop to press the plates in the correct order (1, 3, 5)."

    read -p "Enter your loop script: " solution

    if [[ "$solution" == *"for"* && "$solution" == *"in"* && "$solution" == *"do"* ]]; then
        echo "Pressure plate puzzle solved!"
    else
        ((mistakes++))
        echo "Failed to solve the puzzle! Mistakes: $mistakes/$max_mistakes"
        check_mistakes
    fi
}

# Task 4: Navigate Fire Jets
function navigate_fire_jets() {
    echo "You see fire jets blocking the path."
    echo "Task: Write a case statement to decide the safest timing to cross."

    read -p "Enter your case statement: " solution

    if [[ "$solution" == *"case"* && "$solution" == *"in"* && "$solution" == *"esac"* ]]; then
        echo "You successfully navigate the fire jets!"
    else
        ((mistakes++))
        echo "Failed to navigate fire jets! Mistakes: $mistakes/$max_mistakes"
        check_mistakes
    fi
}

# Task 5: Decode Cryptic Map
function decode_cryptic_map() {
    echo "You find a binary pattern: 1101"
    echo "Task: Write an if statement to decode this binary string."
    read -p "Enter your decoding script: " solution

    if [[ "$solution" == *"if"* && "$solution" == *"1101"* ]]; then
        echo "Binary decoded successfully!"
    else
        ((mistakes++))
        echo "Failed to decode the binary! Mistakes: $mistakes/$max_mistakes"
        check_mistakes
    fi
}

# Survival Task: Escape the Pit
function survival_task() {
    echo "SURVIVAL TASK: You fell into a pit!"
    echo "You have these items: rope, wooden planks, metal hooks."

    while ((survival_attempts < 2)); do
        read -p "Combine items to escape: " solution

        if [[ "$solution" == "rope+wooden planks+metal hooks" ]]; then
            echo "You successfully construct a ladder and escape!"
            log_action "Survival task completed"
            return
        else
            ((survival_attempts++))
            echo "Failed attempt! Attempts remaining: $((2 - survival_attempts))"
        fi
    done

    echo "You failed the survival task. Game Over!"
    exit 1
}

# Check Mistakes
function check_mistakes() {
    if ((mistakes >= max_mistakes)); then
        echo "Too many mistakes! Trapdoor activated."
        survival_task
    fi
}

# Stage Entry Point
function stage2() {
    display_stage_banner "Deadly Traps Maze"

    echo "Welcome to the Deadly Traps Maze!"
    maze_scan

    if ((mistakes < max_mistakes)); then
        echo "You successfully navigate the maze and recover a fragment of the Codex of Computis."
        log_action "Stage 2 completed"
        update_score 20
        save_stage_progress "Stage 2"
    fi
}

stage2
