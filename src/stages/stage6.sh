#!/bin/bash

# Stage 6: Temple Collapse Escape
# Educational Focus: File Operations and System Interactions

# Load helper scripts
source utils/helpers.sh
source utils/player.sh
source utils/logs.sh

mistakes=0
survival_attempts=0
Max_mistakes=5

# Task: Read Configuration Files
function define_escape_route() {
    echo "The walls tremble, and the escape terminal flashes with encrypted escape route instructions."
    echo "Task: Decode the safe escape route from 'ancient_map.txt'."
    echo "Hint: Use commands like 'grep' and 'head'."
    read -p "Enter your solution: " solution

    if [[ "$solution" == *"grep -i \"safe\" assets/playing_files/ancient_map.txt"* && "$solution" == *"head -n 1"* ]]; then
        echo "You successfully decode the safe escape route!"
        log_action "Safe escape route identified."
    else
        ((mistakes++))
        echo "The terminal beeps in error. Mistakes: $mistakes/$Max_mistakes"
        if [[ "$mistakes" -lt "$Max_mistakes" ]]; then
            echo "Hint: Use 'grep' to search for 'safe' and 'head -n 1' to extract the first matching line."
        fi
        check_mistakes
    fi
}


# Task: Combine Codex Fragments
function combine_codex_fragments() {
    echo "Before the final door, the fragments of the Codex await restoration."
    echo "Task: Write a Bash script to combine the fragments into a file named 'Codex_of_Computis.txt'."
    echo "Create a file 'combine_fragments.sh' and write your solution there."
    echo "Hint: write '#!/bin/bash' at the beginning of your script."
    while true; do
    read -p "Press Enter to continue..." solution
    if [[ "$solution" == "cat > combine_fragments.sh" ]]; then
        cat > combine_fragments.sh
        echo "Script created successfully!"
        break    
    fi
    
    done
    read -p "Have you created the script? (yes/no): " created_script
    if [[ "$created_script" != "yes" || ! -f "combine_fragments.sh" ]]; then
        echo "The restoration ritual cannot proceed without the script!"
        ((mistakes++))
        echo "Mistakes: $mistakes/$Max_mistakes"
        if [[ "$mistakes" -lt "$Max_mistakes" ]]; then
            echo "Hint: Your script should include: echo "Fragmentnumber" > Codex_of_Computis.txt'"
        fi
        check_mistakes
        return
    fi

    echo "Executing your script..."
    chmod +x combine_fragments.sh
    ./combine_fragments.sh

    if [[ $? -ne 0 || ! -f "Codex_of_Computis.txt" ]]; then
        echo "The Codex remains incomplete. Correct your script!"
        ((mistakes++))
        echo "Mistakes: $mistakes/$Max_mistakes"
        if [[ "$mistakes" -lt "$Max_mistakes" ]]; then
            echo "Hint: Ensure the output file is named 'Codex_of_Computis.txt'."
        fi
        check_mistakes
    else
        echo "The Codex hums with power as it restores to its full form!"
        log_action "Codex fully restored"
    fi
}

# Survival Task: Escape the Collapse
function survival_task() {
    echo "SURVIVAL TASK: The ground splits, debris falls, and a chasm blocks your escape!"
    echo "You must bridge the gap using structural configurations found in 'bridge_config.txt'."
    read -p "Enter the command to process 'bridge_config.txt': " solution

    if [[ "$solution" == *"while read"* && "$solution" == *"bridge_config.txt"* ]]; then
        echo "You successfully construct a stable bridge and escape the collapsing temple!"
        log_action "Survival task completed."
    else
        ((survival_attempts++))
        if ((survival_attempts < 2)); then
            echo "The bridge collapses! Attempts remaining: $((2 - survival_attempts))"
            echo "Hint: Use a 'while read' loop to process each line in the configuration file."
            survival_task
        else
            echo "You fail to escape. Trapped in the temple forever!"
            exit 1
        fi
    fi
}

# Check for Mistakes
function check_mistakes() {
    if ((mistakes >= Max_mistakes)); then
        echo "Too many mistakes! The temple begins to crumble violently. Initiating survival task."
        survival_task
    fi
}

# Stage Entry Point
function stage6() {
    display_stage_banner "Temple Collapse Escape"

    echo "Analyzing escape options..."
    define_escape_route

    echo "Validating paths..."
    validate_path "./exit"

    echo "Restoring the Codex..."
    combine_codex_fragments

    # Successful Completion
    if ((mistakes < Max_mistakes)); then
        echo "You sprint through the collapsing temple and emerge into the sunlight, victorious!"
        log_action "Stage 6 completed"
        update_score 50
        save_stage_progress "Stage 6"
    fi
}

# Create ancient_map.txt for gameplay
echo -e "safe passage route\ntricky path\ndangerous zone\nmysterious labyrinth" > assets/playing_files/ancient_map.txt

# Start Stage 6
stage6
