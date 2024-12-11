#!/bin/bash
# Stage 4: Artifact Fragment Collection
# Educational Focus: Function Design and Implementation
# Scenario:
# The chamber leads to a labyrinth of interconnected rooms. Scattered across these rooms are fragments of the Codex of Computis, each protected by unique challenges. Collecting all fragments will fully restore the artifact, but the temple’s dangers make gathering optional pieces risky.

# Goal:
# Design and implement functions to tackle specific challenges and collect artifact fragments.

# Challenges:

# Write reusable functions for tasks like disabling traps or solving mini puzzles.
# Use arguments and return values to make functions efficient.
# Balance the risk of exploring optional rooms against potential rewards.
# Write a function to disable traps while searching rooms.
# Use arguments and return values to solve a mini-puzzle.
# Define modular functions to open hidden chambers.
# Create a reusable function for solving symbol-matching puzzles.
# Survival Task: Trigger a collapsing ceiling while retrieving a fragment. Write and execute a function to stabilize the structure using collected resources.
# Outcomes:

# Retrieve 2-3 Codex fragments.
# Save or lose optional tools depending on puzzle efficiency.
# Fail Survival Task: Crushed by the collapsing ceiling.
# # Load helper scripts
source ../utils/helpers.sh
source ../utils/player.sh
source ../utils/logs.sh


