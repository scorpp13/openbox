# Disable fish greeting
set -U fish_greeting

# Interactive session
if status is-interactive
    # Commands to run in interactive sessions can go here
end

# Aliases
if [ -f ~/.alias ]
    source ~/.alias
end
