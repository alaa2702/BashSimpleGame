#!/bin/bash
# Stage 2: Deadly Traps Maze
# Educational Focus: Conditional Statements and Logic

# Load helper scripts
source utils/helpers.sh
source utils/player.sh
source utils/logs.sh

mistakes=0
survival_attempts=0
max_mistakes=5

# Function to provide dynamic hints based on the number of mistakes
function provide_hint() {
    local task_name=$1
    local mistake_count=$2

    case "$task_name" in
        "disable_dart_trap")
            case "$mistake_count" in
                1) echo "Hint: Check for conditions like voltage levels before cutting wires." ;;
                2) echo "Hint: Use nested 'if-else' statements to validate voltage and wire color." ;;
                3) echo "Hint: Use 'test_voltage' and 'cut_wire' in your script." ;;
                *) echo "Critical Hint: Ensure your logic checks voltage before any action!" ;;
            esac
            ;;
        "solve_pressure_plate")
            case "$mistake_count" in
                1) echo "Hint: Use a 'for' loop to iterate through the sequence of steps." ;;
                2) echo "Hint: Remember the syntax for a 'for' loop: for i in sequence; do." ;;
                3) echo "The i represents the plate number in the sequence." ;;
                *) echo "Critical Hint: Press plates in the order 1, 3, 5 using a loop!" ;;
            esac
            ;;
        "navigate_fire_jets")
            case "$mistake_count" in
                1) echo "Hint: Use a 'case' statement to decide the safest timing." ;;
                2) echo "Hint: Include the 'in' keyword and 'esac' to structure the case statement." ;;
                3) echo "Hint: Consider safe timings like 'low heat' or 'pause period'." ;;
                *) echo "Critical Hint: Ensure the 'case' statement evaluates timings correctly!" ;;
            esac
            ;;

    esac
}

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
    echo "The panel displays voltage levels and wire colors 'blue', 'red', 'green'."
    echo "pick the correct wire to cut and disable the trap with higher voltage."
    echo -e "avaible commands:\n test_voltage wire_color: to check the voltage of the wire\n cut_wire wire_color: to cut the wire"
        while true; do
        echo "Write an if-else script to test wires and disable the trap."
        read -p "Enter your script: " solution
        check_command "$solution" "disable_dart_trap"
        regex="^if[[:space:]]+.*>[[:space:]]+.*;[[:space:]]+then[[:space:]]+if[[:space:]]+.*>[[:space:]]+.*;[[:space:]]+then[[:space:]]+.*;[[:space:]]+else[[:space:]]+.*;[[:space:]]+fi[[:space:]]+else[[:space:]]+if[[:space:]]+.*>[[:space:]]+.*;[[:space:]]+then[[:space:]]+.*;[[:space:]]+else[[:space:]]+.*;[[:space:]]+fi[[:space:]]+fi$"
        if [[ "$solution" =~ $regex  ]]; then
          echo "Trap disarmed successfully!"
            break
        else
            ((mistakes++))
            echo "Incorrect script! Mistakes: $mistakes/$max_mistakes"
            provide_hint "disable_dart_trap" "$mistakes"
            check_mistakes
        fi
    done
}

# Task 3: Solve Pressure Plate Puzzle
function solve_pressure_plate() {
    echo "You find a pressure plate requiring a sequence of steps to deactivate."
    while true; do
        echo "Task: Write a loop to press the plates in the correct order (1, 3, 5)."
        echo "available commands: press_plate plate_number"
        read -p "Enter your loop script: " solution
        check_command "$solution" "stage2"
        if [[ "$solution" == *"for"* && "$solution" == *"in"*&& "$solution" == *"(1, 3, 5)"* && "$solution" == *"do"* && "$solution" == *"done"* ]]; then
            echo "Pressure plate puzzle solved!"
            break
        else
            ((mistakes++))
            echo "Failed to solve the puzzle! Mistakes: $mistakes/$max_mistakes"
            provide_hint "solve_pressure_plate" "$mistakes"
            check_mistakes
        fi
    done
}

# Task 4: Navigate Fire Jets
function navigate_fire_jets() {
    echo "You see fire jets blocking the path."
    while true; do
        echo "Task: Write a case statement to decide the safest timing to cross."
        echo "available commands: check_timing (low heat, high heat, pause period), motion (forward, stop ,backward)" 
        read -p "Enter your case statement: " solution
        check_command "$solution" "stage2"
        if [[ "$solution" == *"case"* && "$solution" == *"in"* && "$solution" == *"esac"*&& "$solution" == *"low heat"* && "$solution" == *"high heat"* && "$solution" == *"pause period"* && "$solution" == *"forward"* && "$solution" == *"stop"* && "$solution" == *"backward"* ]]; then
           echo "You successfully navigate the fire jets!"
            break
        else
            ((mistakes++))
            echo "Failed to navigate fire jets! Mistakes: $mistakes/$max_mistakes"
            provide_hint "navigate_fire_jets" "$mistakes"
            check_mistakes
        fi
    done
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
            echo "do a string concatenation of the items to escape"
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
        add_to_inventory "Fragment2"
        log_action "Stage 2 completed"
        update_score 20
        save_stage_progress "Stage 2"
    fi
}

stage2
