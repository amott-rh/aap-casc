#!/bin/bash
COMMIT_MSG=$(cat "$1")

if echo "$COMMIT_MSG" | grep -qi '\[ai-assisted\]'; then
    echo "AI-assisted commit detected. Running extended checks..."

    # Check for common AI antipatterns in Ansible
    if grep -r "ignore_errors: true" --include="*.yml" .; then
        echo "FAIL: 'ignore_errors: true' found - AI often generates this. Review required."
        exit 1
    fi

    if grep -r "when: true" --include="*.yml" .; then
        echo "WARNING: Redundant 'when: true' found - common AI output."
    fi

    # Require a linked issue/ticket for AI commits
    if ! echo "$COMMIT_MSG" | grep -qE '(Refs|Fixes|Closes)[[:space:]]#[0-9]+'; then
        echo "FAIL: AI-assisted commits must reference a ticket (e.g., Refs #123)"
        exit 1
    fi
fi