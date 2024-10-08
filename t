#!/usr/bin/env bash
# This script was generated by bashly 1.2.2 (https://bashly.dannyb.co)
# Modifying it manually is not recommended

# :wrapper.bash3_bouncer
if [[ "${BASH_VERSINFO:-0}" -lt 4 ]]; then
  printf "bash version 4 or higher is required\n" >&2
  exit 1
fi

# :command.master_script

# :command.version_command
version_command() {
  echo "$version"
}

# :command.usage
t_usage() {
  printf "t - Dev Tool\n\n"

  printf "%s\n" "$(bold "Usage:")"
  printf "  t COMMAND\n"
  printf "  t [COMMAND] --help | -h\n"
  printf "  t --version | -v\n"
  echo
  # :command.usage_commands
  printf "%s\n" "$(bold "Commands:")"
  printf "  %s   Create a new worktree branch\n" "$(green "worktree")"
  echo

  # :command.long_usage
  if [[ -n "$long_usage" ]]; then
    printf "%s\n" "$(bold "Options:")"

    # :command.usage_fixed_flags
    printf "  %s\n" "$(magenta "--help, -h")"
    printf "    Show this help\n"
    echo
    printf "  %s\n" "$(magenta "--version, -v")"
    printf "    Show version number\n"
    echo

  fi
}

# :command.usage
t_worktree_usage() {
  printf "t worktree - Create a new worktree branch\n\n"
  printf "Alias: wt\n"
  echo

  printf "%s\n" "$(bold "Usage:")"
  printf "  t worktree BRANCH [OPTIONS]\n"
  printf "  t worktree --help | -h\n"
  echo

  # :command.long_usage
  if [[ -n "$long_usage" ]]; then
    printf "%s\n" "$(bold "Options:")"

    # :command.usage_flags
    # :flag.usage
    printf "  %s\n" "$(magenta "--path, -p PATHNAME")"
    printf "    Path for the new worktree\n"
    echo

    # :command.usage_fixed_flags
    printf "  %s\n" "$(magenta "--help, -h")"
    printf "    Show this help\n"
    echo

    # :command.usage_args
    printf "%s\n" "$(bold "Arguments:")"

    # :argument.usage
    printf "  %s\n" "$(blue "BRANCH")"
    printf "    Branch name that new worktree for\n"
    echo

    # :command.usage_examples
    printf "%s\n" "$(bold "Examples:")"
    printf "  t worktree NEW_BRANCH\n"
    echo

  fi
}

# :command.normalize_input
# :command.normalize_input_function
normalize_input() {
  local arg passthru flags
  passthru=false

  while [[ $# -gt 0 ]]; do
    arg="$1"
    if [[ $passthru == true ]]; then
      input+=("$arg")
    elif [[ $arg =~ ^(--[a-zA-Z0-9_\-]+)=(.+)$ ]]; then
      input+=("${BASH_REMATCH[1]}")
      input+=("${BASH_REMATCH[2]}")
    elif [[ $arg =~ ^(-[a-zA-Z0-9])=(.+)$ ]]; then
      input+=("${BASH_REMATCH[1]}")
      input+=("${BASH_REMATCH[2]}")
    elif [[ $arg =~ ^-([a-zA-Z0-9][a-zA-Z0-9]+)$ ]]; then
      flags="${BASH_REMATCH[1]}"
      for ((i = 0; i < ${#flags}; i++)); do
        input+=("-${flags:i:1}")
      done
    elif [[ "$arg" == "--" ]]; then
      passthru=true
      input+=("$arg")
    else
      input+=("$arg")
    fi

    shift
  done
}

# :command.inspect_args
inspect_args() {
  if ((${#args[@]})); then
    readarray -t sorted_keys < <(printf '%s\n' "${!args[@]}" | sort)
    echo args:
    for k in "${sorted_keys[@]}"; do
      echo "- \${args[$k]} = ${args[$k]}"
    done
  else
    echo args: none
  fi

  if ((${#other_args[@]})); then
    echo
    echo other_args:
    echo "- \${other_args[*]} = ${other_args[*]}"
    for i in "${!other_args[@]}"; do
      echo "- \${other_args[$i]} = ${other_args[$i]}"
    done
  fi

  if ((${#deps[@]})); then
    readarray -t sorted_keys < <(printf '%s\n' "${!deps[@]}" | sort)
    echo
    echo deps:
    for k in "${sorted_keys[@]}"; do
      echo "- \${deps[$k]} = ${deps[$k]}"
    done
  fi

  if ((${#env_var_names[@]})); then
    readarray -t sorted_names < <(printf '%s\n' "${env_var_names[@]}" | sort)
    echo
    echo "environment variables:"
    for k in "${sorted_names[@]}"; do
      echo "- \$$k = ${!k:-}"
    done
  fi
}

# :command.user_lib
# src/lib/colors.sh
print_in_color() {
  local color="$1"
  shift
  if [[ -z ${NO_COLOR+x} ]]; then
    printf "$color%b\e[0m\n" "$*"
  else
    printf "%b\n" "$*"
  fi
}

red() { print_in_color "\e[31m" "$*"; }
green() { print_in_color "\e[32m" "$*"; }
yellow() { print_in_color "\e[33m" "$*"; }
blue() { print_in_color "\e[34m" "$*"; }
magenta() { print_in_color "\e[35m" "$*"; }
cyan() { print_in_color "\e[36m" "$*"; }
bold() { print_in_color "\e[1m" "$*"; }
underlined() { print_in_color "\e[4m" "$*"; }
red_bold() { print_in_color "\e[1;31m" "$*"; }
green_bold() { print_in_color "\e[1;32m" "$*"; }
yellow_bold() { print_in_color "\e[1;33m" "$*"; }
blue_bold() { print_in_color "\e[1;34m" "$*"; }
magenta_bold() { print_in_color "\e[1;35m" "$*"; }
cyan_bold() { print_in_color "\e[1;36m" "$*"; }
red_underlined() { print_in_color "\e[4;31m" "$*"; }
green_underlined() { print_in_color "\e[4;32m" "$*"; }
yellow_underlined() { print_in_color "\e[4;33m" "$*"; }
blue_underlined() { print_in_color "\e[4;34m" "$*"; }
magenta_underlined() { print_in_color "\e[4;35m" "$*"; }
cyan_underlined() { print_in_color "\e[4;36m" "$*"; }

# src/lib/validations/validate_dir_exists.sh
validate_dir_exists() {
  [[ -d "$1" ]] || echo "must be an existing directory"
}

# src/lib/validations/validate_file_exists.sh
validate_file_exists() {
  [[ -f "$1" ]] || echo "must be an existing file"
}

# src/lib/validations/validate_integer.sh
validate_integer() {
  [[ "$1" =~ ^[0-9]+$ ]] || echo "must be an integer"
}

# src/lib/validations/validate_not_empty.sh
validate_not_empty() {
  [[ -z "$1" ]] && echo "must not be empty"
}

# :command.command_functions
# :command.function
t_worktree_command() {
  # src/worktree_command.sh
  branch=${args[branch]}
  worktreePath=${args[--path]}
  folderName=${PWD##*/}
  worktreeDest=~/Worktrees/$branch/$folderName

  baseBranch=$(git branch -l main master --format '%(refname:short)')

  # check remote branch exist
  if git rev-parse --verify --quiet origin/"$branch" >/dev/null 2>&1; then
    baseBranch=$branch
  fi

  echo "Create new worktree for $(green "$branch")"

  if [[ $worktreePath ]]; then
    worktreeDest=$worktreePath/$branch/$folderName
  fi

  # fetch all branches
  git fetch --all

  # create worktree
  git worktree add -b "$branch" "$worktreeDest" origin/"$baseBranch"

  # make and switch to the destination
  mkdir -p "$worktreeDest" && cd "$_" || exit

  # set upstream
  git push --set-upstream origin "$branch"

}

# :command.parse_requirements
parse_requirements() {
  # :command.fixed_flags_filter
  while [[ $# -gt 0 ]]; do
    case "${1:-}" in
      --version | -v)
        version_command
        exit
        ;;

      --help | -h)
        long_usage=yes
        t_usage
        exit
        ;;

      *)
        break
        ;;

    esac
  done

  # :command.command_filter
  action=${1:-}

  case $action in
    -*) ;;

    worktree | wt)
      action="worktree"
      shift
      t_worktree_parse_requirements "$@"
      shift $#
      ;;

    # :command.command_fallback
    "")
      t_usage >&2
      exit 1
      ;;

    *)
      printf "invalid command: %s\n" "$action" >&2
      exit 1
      ;;

  esac

  # :command.parse_requirements_while
  while [[ $# -gt 0 ]]; do
    key="$1"
    case "$key" in

      -?*)
        printf "invalid option: %s\n" "$key" >&2
        exit 1
        ;;

      *)
        # :command.parse_requirements_case
        # :command.parse_requirements_case_simple
        printf "invalid argument: %s\n" "$key" >&2
        exit 1

        ;;

    esac
  done

}

# :command.parse_requirements
t_worktree_parse_requirements() {
  # :command.fixed_flags_filter
  while [[ $# -gt 0 ]]; do
    case "${1:-}" in
      --help | -h)
        long_usage=yes
        t_worktree_usage
        exit
        ;;

      *)
        break
        ;;

    esac
  done

  # :command.dependencies_filter
  if command -v git >/dev/null 2>&1; then
    deps['git']="$(command -v git | head -n1)"
  else
    printf "missing dependency: git\n" >&2
    exit 1
  fi

  # :command.command_filter
  action="worktree"

  # :command.parse_requirements_while
  while [[ $# -gt 0 ]]; do
    key="$1"
    case "$key" in
      # :flag.case
      --path | -p)

        # :flag.case_arg
        if [[ -n ${2+x} ]]; then
          args['--path']="$2"
          shift
          shift
        else
          printf "%s\n" "--path requires an argument: --path, -p PATHNAME" >&2
          exit 1
        fi
        ;;

      -?*)
        printf "invalid option: %s\n" "$key" >&2
        exit 1
        ;;

      *)
        # :command.parse_requirements_case
        # :command.parse_requirements_case_simple
        # :argument.case
        if [[ -z ${args['branch']+x} ]]; then
          args['branch']=$1
          shift
        else
          printf "invalid argument: %s\n" "$key" >&2
          exit 1
        fi

        ;;

    esac
  done

  # :command.required_args_filter
  if [[ -z ${args['branch']+x} ]]; then
    printf "missing required argument: BRANCH\nusage: t worktree BRANCH [OPTIONS]\n" >&2

    exit 1
  fi

  # :command.validations
  # :flag.validations
  if [[ -v args['--path'] && -n $(validate_dir_exists "${args['--path']:-}") ]]; then
    printf "validation error in %s:\n%s\n" "--path, -p PATHNAME" "$(validate_dir_exists "${args['--path']:-}")" >&2
    exit 1
  fi

}

# :command.initialize
initialize() {
  version="0.1.0"
  long_usage=''
  set -e

}

# :command.run
run() {
  declare -A args=()
  declare -A deps=()
  declare -a other_args=()
  declare -a env_var_names=()
  declare -a input=()
  normalize_input "$@"
  parse_requirements "${input[@]}"

  case "$action" in
    "worktree") t_worktree_command ;;
  esac
}

initialize
run "$@"
