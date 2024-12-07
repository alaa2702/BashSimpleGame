#!/bin/bash
# stages/stage1.sh
source ../utils/logging.sh
# Function to display a stage banner
function display_stage_banner() {
    local stage_name=$1

    # Decorative banner
    echo "========================================"
    echo "          $stage_name"
    echo "========================================"
    echo
    echo "Prepare yourself for the challenges ahead!"
    echo
}

# Function to take the player user name
function puzzle_declare_variable() {
    local temp_file=$1
    echo "Task 1: Declare a variable to store your explorer name."
    echo "Command Hint: Use 'explorer_name=\"your_name\"'"

    while true; do
        read -p "> " player_input

        # Evaluate player input
        if echo "$player_input" | grep -qE '^explorer_name="[^"]+"$'; then
            eval "$player_input"
            echo "Great! You declared the variable: explorer_name=$explorer_name"
            echo "explorer_name=\"$explorer_name\"" >> "$temp_file"
            log_action "Player declared explorer_name=$explorer_name"
            break
        else
            echo "Incorrect. Remember, declare a variable like: explorer_name=\"your_name\""
        fi
    done
}

function puzzle_arithmetic() {
    local temp_file=$1
    echo
    echo "Task 2: Perform arithmetic using variables."
    echo "The ancient glyphs show three numbers: 42, 58, and 73."
    echo "Calculate their sum and store it in a variable called 'total'."
    echo "Command Hint: Use 'total=$((number1 + number2 + number3))'"

    while true; do
        read -p "> " player_input

        # Check if the command correctly calculates the sum
        if echo "$player_input" | grep -qE '^total=\$\(\(([0-9]+ \+ )*[0-9]+\)\)$'; then
            eval "$player_input"
            if [[ "$total" -eq 173 ]]; then
                echo "Correct! The total is $total."
                echo "total=$total" >> "$temp_file"
                #log_action "Player calculated total=$total"
                break
            else
                echo "Incorrect result. Check your numbers and try again."
            fi
        else
            echo "Syntax error. Use the format: total=\$((number1 + number2 + number3))"
        fi
    done
}
function puzzle_combine() {
    local temp_file=$1
    echo
    echo "Task 3: Combine your explorer name and a unique ID."
    echo "Use the command: 'id=\"$explorer_name$(date +%s)\"'"
    echo "This will generate a unique explorer ID."

    while true; do
        read -p "> " player_input

        # Validate the command
        if echo "$player_input" | grep -qE '^id="\$\(.*\)"$'; then
            eval "$player_input"
            if [[ -n "$id" ]]; then
                echo "Excellent! Your unique ID is: $id"
                echo "id=\"$id\"" >> "$temp_file"
                #log_action "Player generated id=$id"
                break
            else
                echo "Something went wrong. Try again."
            fi
        else
            echo "Invalid syntax. Use: id=\"\$explorer_name\$(date +%s)\""
        fi
    done
}


function stage_1() {

   display_stage_banner "Stage 1: Variables Chamber"

    echo "You step into the Variables Chamber, where ancient scripts glow faintly on the walls."
    echo "The inscriptions whisper knowledge about variables in Bash. Solve the puzzles to proceed."
    echo
     # Create a temporary file for environment setup
    temp_file=$(mktemp)
    echo "# Temporary Variables Chamber environment" > "$temp_file"
    echo

    # Puzzle 1: Declare a Variable
    puzzle_declare_variable "$temp_file"

    # Puzzle 2: Arithmetic with Variables
    puzzle_arithmetic "$temp_file"

    # Puzzle 3: Combine Variables
    puzzle_combine "$temp_file"

    echo "Congratulations! You have completed the Variables Chamber."
    cat "$temp_file"
    rm "$temp_file"
    return 0
}
stage_1
