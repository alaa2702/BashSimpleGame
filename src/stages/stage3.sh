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

# Task 1: Translate Glyphs
function translate_glyphs() {
    echo "You step into the heart of the Mysterious Inscriptions Chamber. The walls are covered with ancient glyphs that seem to shimmer in the dim light."
    echo "In front of you, there is a series of glyphs representing numbers from 1 to 5. Your task is to translate them to their double values."
    echo "The translation can be done using a loop. Example: for i in {1..5}; do echo \$((i * 2)); done"
    
    read -p "Enter your loop script: " solution

    if [[ "$solution" == *"for"* && "$solution" == *"in"* && "$solution" == *"do"* && "$solution" == *"echo"* ]]; then
        echo "You correctly translated the glyphs, revealing hidden numbers etched into the walls!"
    else
        ((mistakes++))
        echo "The glyphs remain unchanged. Mistakes: $mistakes/$max_mistakes"
        if ((mistakes < max_mistakes)); then
            echo "Hint: Remember, you need a loop to double each number. Look for 'for' and 'echo' in your script."
        fi
        check_mistakes
    fi
}

# Task 2: Operate the Machine
function operate_machine() {
    echo "\nA massive mechanism is revealed in the center of the chamber. It hums with energy, but the power level is fluctuating wildly."
    echo "You need to balance the machine’s power level between 5 and 10 using a loop to regulate the energy."
    echo "Example: while [ power -lt 5 ] || [ power -gt 10 ]; do ... done"
    
    read -p "Enter your loop script: " solution

    if [[ "$solution" == *"while"* && "$solution" == *"do"* && "$solution" == *"power="* ]]; then
        echo "The machine whirs to life and stabilizes! The room's lighting intensifies as the energy levels balance."
    else
        ((mistakes++))
        echo "The machine sputters and powers down. Mistakes: $mistakes/$max_mistakes"
        if ((mistakes < max_mistakes)); then
            echo "Hint: Try using a 'while' loop to ensure the power stays within the range of 5 to 10."
        fi
        check_mistakes
    fi
}

# Task 3: Solve the Logic Puzzle
function logic_puzzle() {
    echo "\nBefore you lies an ancient puzzle box with intricate markings. The box requires you to match glyph fragments to their corresponding meanings using a loop."
    echo "Each fragment must be checked in sequence. The box can only be opened if the fragments are correctly aligned."
    echo "Example: for ((i=0; i<5; i++)); do ... done"
    
    read -p "Enter your loop script: " solution

    if [[ "$solution" == *"for"* && "$solution" == *"((i="* && "$solution" == *"do"* ]]; then
        echo "The puzzle box clicks open, revealing a glowing Codex fragment inside!"
    else
        ((mistakes++))
        echo "The box remains locked. Mistakes: $mistakes/$max_mistakes"
        if ((mistakes < max_mistakes)); then
            echo "Hint: Use a 'for' loop with an index to check the fragments in sequence."
        fi
        check_mistakes
    fi
}

# Survival Task: Repair the Pump
function survival_task() {
    echo "\nSuddenly, the floor begins to tremble, and water starts flooding the chamber. You realize that the pump system has failed."
    echo "You have these items: pipe, wrench, and sealant. Use them to repair the pump before the chamber is completely submerged."

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

    # Task 1: Translate Glyphs
    translate_glyphs
    if ((mistakes < max_mistakes)); then
        # Task 2: Operate the Machine
        operate_machine
    fi
    if ((mistakes < max_mistakes)); then
        # Task 3: Solve the Logic Puzzle
        logic_puzzle
    fi

    # Successful Completion
    if ((mistakes < max_mistakes)); then
        echo "Congratulations! You’ve solved all the challenges and discovered a Codex fragment!"
        log_action "Stage 3 completed"
        update_score 30
        save_stage_progress "Stage 3"
    fi
}

# Start Stage 3
stage3
