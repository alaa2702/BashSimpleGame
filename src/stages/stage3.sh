#!/bin/bash
# Stage 3: Mysterious Inscriptions Chamber
# Educational Focus: Loop Structures

# Load helper scripts
source  utils/helpers.sh
source  utils/player.sh
source  utils/logs.sh

mistakes=0
survival_attempts=0
Max_mistakes=5
Max_survival_attempts=2

function translate_glyphs() {
    echo "Task 1: Translate Glyphs"
    echo "The glyphs represent numbers and their double values. Translate them to unlock a clue."
    echo "Hint: Use a for loop to calculate the double values of glyph numbers (1 to 5)."

    local solution=(2 4 6 8 10)
    local user_solution=()

    echo "Use a loop to translate the glyphs. Enter the doubled values for numbers 1 to 5:"

    for i in {1..5}; do
        read -p "Glyph $i: " value
        user_solution+=("$value")
    done

    if [ "${solution[*]}" == "${user_solution[*]}" ]; then
        echo "Correct! The glyphs are translated."
        log_action "Player translated glyphs successfully."
    else
        echo "Incorrect translation. Try again."
        mistakes=$((mistakes + 1))
        log_action "Player made a mistake in glyph translation."
        if [ $mistakes -ge $Max_mistakes ]; then
            echo "You triggered the survival task!"
            survival_task
            return
        fi
        translate_glyphs
    fi
}

function operate_machine() {
    echo "\nTask 2: Operate the Mechanism"
    echo "You must balance the machine by keeping its power level between 5 and 10."

    local power=0

    echo "Use 'add' or 'subtract' commands followed by a number to adjust the power level."
    while [ $power -lt 5 ] || [ $power -gt 10 ]; do
        if [ $power -lt 5 ]; then
            echo "Current power: $power. Too low. Increase the power."
        elif [ $power -gt 10 ]; then
            echo "Current power: $power. Too high. Decrease the power."
        fi

        read -p "> " command value
        case "$command" in
        add)
            power=$((power + value))
            ;;
        subtract)
            power=$((power - value))
            ;;
        *)
            echo "Invalid command. Use 'add' or 'subtract'."
            ;;
        esac
    done

    echo "Machine balanced at power level $power. Mechanism activated!"
    log_action "Player successfully operated the machine."
}

function logic_puzzle() {
    echo "\nTask 3: Solve the Logic Puzzle"
    echo "You must match glyph fragments to their meanings. Use 'break' to stop incorrect attempts."

    local fragments=("Sun" "Moon" "Star" "Sky" "Earth")
    local meanings=("Day" "Night" "Light" "Air" "Ground")

    echo "Match the following glyph fragments to their meanings:"

    for ((i = 0; i < ${#fragments[@]}; i++)); do
        read -p "Fragment: ${fragments[i]} Meaning: " user_input

        if [ "$user_input" != "${meanings[i]}" ]; then
            echo "Incorrect match. Breaking loop."
            mistakes=$((mistakes + 1))
            log_action "Player made a mistake in logic puzzle."
            if [ $mistakes -ge $Max_mistakes ]; then
                echo "You triggered the survival task!"
                survival_task
                return
            fi
            break
        fi
    done

    echo "All glyph fragments matched successfully."
    log_action "Player solved the logic puzzle."
}

function survival_task() {
    echo "\nSurvival Task: Repair the Pump"
    echo "The chamber is flooding! Repair the pump to escape."

    local files=("pipe1.txt" "pipe2.txt" "pipe3.txt")
    for file in "${files[@]}"; do
        echo "Processing $file..."
        sleep 1
        echo "$file repaired."
    done

    survival_attempts=$((survival_attempts + 1))
    if [ $survival_attempts -le $Max_survival_attempts ]; then
        echo "Pump repaired. You survived!"
        log_action "Player successfully completed survival task."
    else
        echo "You failed to repair the pump. Drowned. Game Over."
        log_action "Player failed survival task and drowned."
        exit 1
    fi
}

function stage3() {
    display_stage_banner "Mysterious Inscriptions Chamber"

    translate_glyphs
    operate_machine
    logic_puzzle

    if [ $mistakes -lt $Max_mistakes ]; then
        echo "You successfully completed Stage 3 and discovered a Codex fragment!"
        update_score 30
        save_stage_progress "Stage 3"
    fi
}

stage3
