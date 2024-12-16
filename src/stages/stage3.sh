#!/bin/bash
# Stage 3: Mysterious Inscriptions Chamber
# Educational Focus: Loop Structures

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
        "translate_glyphs")
            case "$mistake_count" in
                1) echo "Hint: Use a loop to multiply each glyph number by 2. Example: for i in {1..5}; do echo \$((i * 2)); done" ;;
                2) echo "Hint: Ensure your loop structure includes 'for', 'in', and 'do' keywords." ;;
                *) echo "Critical Hint: Use 'for i in {1..5}; do echo \$((i * 2)); done' to solve this." ;;
            esac
            ;;
        "operate_machine")
            case "$mistake_count" in
                1) echo "Hint: Use a 'while' loop to check and adjust the power level." ;;
                2) echo "Hint: Your loop condition should ensure the power level stays between 5 and 10." ;;
                *) echo "Critical Hint: Use 'while [ power -lt 5 ] || [ power -gt 10 ]; do ... done' to solve this." ;;
            esac
            ;;
        "logic_puzzle")
            case "$mistake_count" in
                1) echo "Hint: Use a 'for' loop with an index variable, e.g., for ((i=0; i<5; i++)); do ... done." ;;
                2) echo "Hint: Ensure your loop iterates through all fragments to match them correctly." ;;
                *) echo "Critical Hint: Write 'for ((i=0; i<5; i++)); do ... done' for the puzzle solution." ;;
            esac
            ;;
    esac
}

# Task 1: Translate Glyphs
function translate_glyphs() {
    echo "You step into the heart of the Mysterious Inscriptions Chamber. The walls are covered with ancient glyphs that seem to shimmer in the dim light."
    echo "Translate the glyphs into their double values using a loop."
    
    while true; do
        read -p "Enter your loop script: " solution
        if [[ "$solution" == *"for"* && "$solution" == *"in"* && "$solution" == *"do"* && "$solution" == *"echo"* ]]; then
            echo "You correctly translated the glyphs, revealing hidden numbers etched into the walls!"
            break
        else
            ((mistakes++))
            echo "The glyphs remain unchanged. Mistakes: $mistakes/$max_mistakes"
            provide_hint "translate_glyphs" "$mistakes"
            check_mistakes
        fi
    done
}

# Task 2: Operate the Machine
function operate_machine() {
    echo "A massive mechanism hums with energy, but the power level is fluctuating wildly."
    echo "You need to balance the machine's power level between 5 and 10 using a loop."
    
    while true; do
        read -p "Enter your loop script: " solution
        if [[ "$solution" == *"while"* && "$solution" == *"do"* && "$solution" == *"power="* ]]; then
            echo "The machine whirs to life and stabilizes! The room's lighting intensifies as the energy levels balance."
            break
        else
            ((mistakes++))
            echo "The machine sputters and powers down. Mistakes: $mistakes/$max_mistakes"
            provide_hint "operate_machine" "$mistakes"
            check_mistakes
        fi
    done
}

# Task 3: Solve the Logic Puzzle
function logic_puzzle() {
    echo "An ancient puzzle box requires you to match glyph fragments using a loop."
    echo "the fragments are scattered around the box, and you need to arrange them in the correct order."
    echo "available commands: Move_Fragment fragment_number"
    while true; do
        read -p "Enter your loop script: " solution
        if [[ "$solution" == *"for"* && "$solution" == *"((i="* && "$solution" == *"do"* ]]; then
            echo "The puzzle box clicks open, revealing a glowing Codex fragment inside!"
            add_to_inventory "Fragment3"
            break
        else
            ((mistakes++))
            echo "The box remains locked. Mistakes: $mistakes/$max_mistakes"
            provide_hint "logic_puzzle" "$mistakes"
            check_mistakes
        fi
    done
}

# Survival Task: Repair the Pump
function survival_task() {
    echo "Water floods the chamber as the pump system fails."
    echo "Use the items (pipe, wrench, sealant) to repair the pump."
    
    while ((survival_attempts < 2)); do
        read -p "Combine items to repair the pump: " solution
        if [[ "$solution" == "pipe+wrench+sealant" ]]; then
            echo "You skillfully repair the pump, stopping the flood just in time. The water level begins to recede."
            log_action "Survival task completed"
            return
        else
            ((survival_attempts++))
            echo "The pump is still broken. Attempts remaining: $((2 - survival_attempts))"
        fi
    done

    echo "You failed the survival task. The chamber is flooded. Game Over!"
    exit 1
}

# Check Mistakes
function check_mistakes() {
    if ((mistakes >= max_mistakes)); then
        echo "Too many mistakes! You triggered the survival task."
        survival_task
    fi
}

# Stage Entry Point
function stage3() {
    display_stage_banner "Mysterious Inscriptions Chamber"

    echo "Welcome to the Mysterious Inscriptions Chamber. Solve the puzzles and survive the challenges to collect a Codex fragment and escape."

    translate_glyphs
    if ((mistakes < max_mistakes)); then
        operate_machine
    fi
    if ((mistakes < max_mistakes)); then
        logic_puzzle
    fi

    if ((mistakes < max_mistakes)); then
        echo "Congratulations! You’ve solved all the challenges and discovered a Codex fragment!"
        log_action "Stage 3 completed"
        update_score 30
        save_stage_progress "Stage 3"
    fi
}

# Start Stage 3
stage3
