#!/bin/bash
# Stage 1: Temple Entrance - Puzzle Locks
# Educational Focus: Variable Declaration and Manipulation

# Scenario:
# the player stand before an enormous stone door covered in intricate geometric patterns. The door won’t budge unless he solve its puzzle by manipulating variables and performing symbolic calculations.
# The glyphs on the door indicate that you must calculate the area of the sides of a hexagon to unlock it.he can use cat glpyhs.txt to see the glyphs.


# Load helper scripts
source   utils/helpers.sh
source   utils/player.sh
source   utils/logs.sh

mistakes=0
survival_attempts=0
Max_mistakes=5
# Define the hexagon area calculation function

function read_glyphs(){
    mistake=0
    echo "task 1: read the glyphs"
    echo "you stand infront an enormous stone door covered in intricate geometric patterns. "
    echo "The door won’t budge"
    echo "you need to read the glyphs.txt to solve the puzzle"
    
    while true; do
    read -p ">" input
    case $input in
      "cat glyphs.txt")
        cat    assets/playing_file/glyphs.txt
        log_action "Player read the glyphs"
        break
        ;;
        *)
        check_command "$input" "stage1"
        if [ $? -eq 0 ]; then
            ((mistakes++))
            if [[ $mistakes -eq 2 ]]; then
                echo "Hint: Use 'cat filename' to view the contents of a file."
            fi        fi
        ;;
    esac
    done
    echo "As you stand before the puzzle, you feel the weight of the challenge. A faint humming sound emanates from the door, urging you to begin."
   
}

# Task: Solve the Puzzle
function solve_puzzle() {
    echo "Task 2: Solve the Puzzle"
    echo "You must calculate the area of the hexagon to unlock the door."
    echo "Define the side length of the hexagon as a variable (e.g., 'a=3')."

    mistakes=0
    max_attempts=5

    while [[ $mistakes -lt $max_attempts ]]; do
        echo "Enter your calculation (use bc for arithmetic):"
        # explain the pipe and bc -l
        echo " bc -l is a command that allows you to perform arithmetic calculations in the terminal. The -l flag loads the math library, enabling advanced functions like square roots."
        echo " you can write the formula of the area of a hexagon followed by | bc -l to calculate the area"
        read -p "> " player_input
        if [ check_command "$player_input" "stage1" ]; then
            continue
        elif [ "$player_input" == "echo \"(3 * sqrt(3) / 2) * ($a * $a)\" | bc -l" ]; then
            echo "The door rumbles and slowly opens. You have solved the puzzle!"
            log_action "Player solved the puzzle."
            update_score 10
            return 0
        else
            ((mistakes++))
            echo "Incorrect solution. You have $((max_attempts - mistakes)) attempts left."
            log_action "Player made a mistake. Total mistakes: $mistakes."

            if [[ $mistakes -eq 2 ]]; then
                echo "Hint: you can calculate the area of a hexagon by dividing it into six equilateral triangles."
            elif [[ $mistakes -eq 4 ]]; then
                echo "Hint: Use 'sqrt()' to calculate square root in 'bc'."
            fi
        fi
    done

    echo "The door mechanism malfunctions, triggering a falling stones trap!"
    survival_task
}

# Task: Survival Task
function survival_task() {
    echo "Task 3: Survival Task"
    echo "You must quickly calculate the escape timing to survive."
    echo "Stone speed: 20 meters/second. Distance to safety: 50 meters."

    echo "Write a script to calculate escape timing in seconds."
    read -p "> " player_input

    if [[ "$player_input" == "echo \"scale=2; 50 / 20\" | bc" ]]; then
        echo "You successfully escaped the falling stones!"
        log_action "Player survived the trap."
    else
        echo "You failed to escape the falling stones. Game Over."
        log_action "Player failed the survival task."
        exit 1
    fi
}

# Stage Entry Point
function stage1() {
    display_stage_banner "Temple Entrance - Puzzle Locks"
    
    echo "You stand before the Temple Entrance, an imposing door with glowing glyphs."

    # Task 1: Examine Glyphs
    read_glyphs

    # Task 2: Solve the Puzzle
    solve_puzzle

    # Successful Completion
    echo "The door opens, revealing a fragment of the Codex and an ancient map."
    add_to_inventory "Fragment1"
    add_to_inventory "ancient map"
    echo "You have completed Stage 1!"
    log_action "Stage 1 completed."
    update_score 20
    save_stage_progress "Stage 1"
}

# Start Stage 1
stage1
