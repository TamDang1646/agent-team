#!/bin/bash
# Agent Team System - Routing Classifier
# Classifies tasks into Level 0-3 orchestration levels

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")"/.. && pwd)"
CONFIG_FILE="$SCRIPT_DIR/project/config.json"

# Default routing based on task characteristics
classify_task() {
    local task_description="$1"
    local task_lower=$(echo "$task_description" | tr '[:upper:]' '[:lower:]')

    # Level 3: Complex multi-layer projects (check FIRST - highest priority)
    if echo "$task_lower" | grep -qE "(migrate|refactor|architect|infrastructure|multi.*service|full.*stack|database.*schema|ci/cd|deployment|containerize|docker|kubernetes)"; then
        echo "level_3"
        return
    fi

    # Level 0: Simple, single-file, no dependencies
    # Typo/content fixes
    if echo "$task_lower" | grep -qE "(typo|fix.*spelling|change.*word)"; then
        echo "level_0"
        return
    fi

    # Simple console.log/add import/remove export
    if echo "$task_lower" | grep -qE "(add.*console\.log|add.*import|remove.*import|add.*export|remove.*export)"; then
        echo "level_0"
        return
    fi

    # README/doc updates only
    if echo "$task_lower" | grep -qE "^(update|fix|change) (readme|doc|documentation)"; then
        echo "level_0"
        return
    fi

    # Level 1: Feature with subagent support needed
    if echo "$task_lower" | grep -qE "^(explore|search|find|analyze|debug|test|review|benchmark|investigate|profile)"; then
        echo "level_1"
        return
    fi

    # Level 1: Debug/analyze tasks
    if echo "$task_lower" | grep -qE "(debug.*error|analyze.*log|review.*code|profile.*performance)"; then
        echo "level_1"
        return
    fi

    # Level 2: Multi-role feature development
    if echo "$task_lower" | grep -qE "(build|implement|create|design|add.*endpoint|create.*api|feature)"; then
        echo "level_2"
        return
    fi

    # Level 2: Default for feature work
    if echo "$task_lower" | grep -qE "^(build|implement|create)"; then
        echo "level_2"
        return
    fi

    # Default to level_2 for software development
    echo "level_2"
}

# List enabled agents/subagents
list_agents() {
    cat "$CONFIG_FILE" | jq -r '.enabled_agents[]' 2>/dev/null || echo "No config found"
}

list_subagents() {
    cat "$CONFIG_FILE" | jq -r '.enabled_subagents[]' 2>/dev/null || echo "No config found"
}

# Show usage
usage() {
    echo "Usage: $0 <command> [args]"
    echo ""
    echo "Commands:"
    echo "  classify <task>  - Classify task into routing level"
    echo "  agents           - List enabled agents"
    echo "  subagents        - List enabled subagents"
    echo "  config           - Show current config"
    echo "  help             - Show this help"
}

case "${1:-help}" in
    classify)
        classify_task "$2"
        ;;
    agents)
        list_agents
        ;;
    subagents)
        list_subagents
        ;;
    config)
        cat "$CONFIG_FILE"
        ;;
    help|--help|-h)
        usage
        ;;
    *)
        echo "Unknown command: $1"
        usage
        exit 1
        ;;
esac