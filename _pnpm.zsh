#compdef pnpm

_pnpm() {
  local -a opts
  opts=()

  if [[ $words[2] == "-F" ]]; then
    _pnpm_packages
  else
    opts+=("-F[Filter packages]:package:_pnpm_packages")
    _describe -t commands "pnpm commands" opts
  fi
}

_pnpm_packages() {
  local -a packages
  packages=($(pnpm recursive list --json 2>/dev/null | jq -r '.[].name' 2>/dev/null))
  [[ ${#packages[@]} -eq 0 ]] && packages=($(ls -d packages/*/ 2>/dev/null | xargs -n 1 basename))
  _describe 'package' packages
}

_pnpm "$@"
