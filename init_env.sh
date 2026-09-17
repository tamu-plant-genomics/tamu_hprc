#!/usr/bin/env bash
# script       : init_env.sh
# description  : This script is used to initialize the user environment for the Tamu HPRC cluster.
# Usage        : bash init_env.sh -n lastname -m email_id
# version      : 0.1.0
# date         : 16-09-2026
# contact      : c.s.sivasubramani[at]gmail.com

usage() {
    echo "Usage: bash init_env.sh -n lastname -m email_id"
    echo "Options:"
    echo "  -n, --name      Last name of the user (e.g. jayakodi)"
    echo "  -m, --email     Email ID of the user (e.g. muru.jayakodi@agnet.tamu.edu)"
    echo "  -h, --help      Display this help message"
    echo ""
    echo "contact: c.s.sivasubramani[at]gmail.com for any issues"
}

find_dir() {
    local counter=0
    local dirname="${pg_root}/PG1/${lastname}"

    while [[ -d "$dirname" ]]; do
        echo "Directory $dirname already exists. Trying a new name..." >&2
        counter=$((counter + 1))
        dirname="${pg_root}/PG1/${lastname}${counter}"
    done

    echo "$dirname"
}

while [[ "$#" -gt 0 ]]; do
    case $1 in
        -n|--name)
            [[ -n "$2" && "$2" != -* ]] || { echo "Error: Argument required for $1"; exit 1; }
            lastname="$2"; shift 2 ;;
        -m|--email)
            [[ -n "$2" && "$2" != -* ]] || { echo "Error: Argument required for $1"; exit 1; }
            email="$2"; shift 2 ;;
        -h|--help)
            usage; exit 0 ;;
        *)
            echo "Unknown parameter passed: $1"; usage; exit 1 ;;
    esac
done

if [[ -z "$lastname" || -z "$email" ]]; then
    echo "Error: Both lastname and email are required."
    usage
    exit 1
fi

lastname=$(echo "$lastname" | tr '[:upper:]' '[:lower:]')
email=$(echo "$email" | tr '[:upper:]' '[:lower:]')
pg_root="/scratch/group/pgenomics"

scratch_dir=$(find_dir)

echo "Creating directory: $scratch_dir if it does not exist..."
mkdir -p "$scratch_dir"

backup="$HOME/.bashrc.bak.$(date +%Y%m%d%H%M%S)"
echo "Making backup copy of the ~/.bashrc file to $backup"
cp ~/.bashrc "$backup"

echo "Appending environment configuration to ~/.bashrc..."
{
    echo ""
    echo "# --- Tamu HPRC pgenomics Environment Setup ---"
    echo "if [ -f /etc/bashrc ]; then"
    echo "    . /etc/bashrc"
    echo "fi"
    echo "export SCRATCH_DIR=\"$scratch_dir\""
    echo "export MYEMAIL=\"$email\""
    echo "if [ -f /scratch/group/pgenomics/envs/pgenv/bashrc ]; then"
    echo "    . /scratch/group/pgenomics/envs/pgenv/bashrc"
    echo "else"
    echo "    echo \"Warning: /scratch/group/pgenomics/envs/pgenv/bashrc not found. Please check the path. Bash retains default env\""
    echo "fi"
    echo "# --- End of Tamu HPRC pgenomics Environment Setup ---"
} > ~/.bashrc

echo "Environment configuration appended to ~/.bashrc. You may add any additional customizations below the Tamu HPRC section."

echo "Setup complete! Please run 'source ~/.bashrc' or re-login."
