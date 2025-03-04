#!/bin/bash

fetch_repos() {
  curl -s "https://api.github.com/search/repositories?q=stars:>1000&sort=stars&order=desc&per_page=100&page=0" | jq -r '.items[] | "\(.full_name)\n\(.description)\n⭐ \(.stargazers_count)\n\(.html_url)\n---"' > /tmp/git-scroll.txt
  current_index=$((RANDOM % 100 + 1))
}

display_repo() {
  clear
  awk -v RS="---" -v idx="$current_index" 'NR==idx {print}' /tmp/git-scroll.txt
  echo -e "\n---\n[↑] Previous  [↓] Next  [o] Open in Browser  [q] Quit"
}

handle_input() {
  while true; do
    read -rsn1 key
    case "$key" in
    $'\x1B') # Escape sequence (arrow keys)
      read -rsn2 key
      if [[ "$key" == "[A" ]]; then # Up arrow
        ((current_index--))
      elif [[ "$key" == "[B" ]]; then # Down arrow
        ((current_index++))
      fi
      display_repo
      ;;
    q)
      exit 0
      ;;
    o)
      awk -v RS="---" -v idx="$current_index" 'NR==idx {print $4}' /tmp/git-scroll.txt | xargs open
      ;;
    esac
  done
}

fetch_repos
display_repo
handle_input
