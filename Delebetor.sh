#!/usr/bin/env bash
#
#    Delebetor - helper script that installs/configures pentest tools
#    Copyright (C) 2022  ByCh4n
#
#    This program is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with this program.  If not, see <https://www.gnu.org/licenses/>.
#
# Contributors:
#   - ByCh4n
#   - lazypwny751

set -uo pipefail

# ----------------------------------------------------------------------
# Variables
# ----------------------------------------------------------------------
readonly VERSION="2.0.0"
readonly OPT_DIR="/opt"

if [ -t 1 ]; then
    readonly reset="\033[0m" red="\033[0;31m" green="\033[0;32m"
    readonly Bwhite="\033[1;37m" Bcyan="\033[1;36m"
else
    readonly reset="" red="" green="" Bwhite="" Bcyan=""
fi

# Tools installed via apt (the package name must match this exactly on the distro)
readonly APT_TOOLS=(
    metasploit-framework enum4linux python3 python3-pip arp-scan hydra
    naabu nuclei crackmapexec httprobe dnsrecon theharvester sublist3r
    ftp ssh telnet hashcat subfinder golang-go bloodhound neo4j
    smbmap smbclient
)

# Tools cloned under /opt via git: "name|repo|build_command"
# If build_command is empty the tool is only cloned.
readonly GIT_TOOLS=(
    "impacket|https://github.com/fortra/impacket|python3 -m pip install ."
    "kerbrute|https://github.com/ropnop/kerbrute|"
    "windapsearch|https://github.com/ropnop/windapsearch|python3 -m pip install -r requirements.txt"
    "BloodHound.py|https://github.com/dirkjanm/BloodHound.py|python3 -m pip install ."
)

# ----------------------------------------------------------------------
# Helpers
# ----------------------------------------------------------------------
log()  { echo -e "[${green}+${reset}] $1"; }
warn() { echo -e "[${red}!${reset}] $1"; }

need_root() {
    if [ "$(id -u)" -ne 0 ]; then
        warn "This action requires root: 'sudo delebetor'"
        return 1
    fi
    return 0
}

delebetor:banner() {
    echo -e "${green}
     ______mXXXXXXm______
    *m==================m*
     D  _=  _=  _=  _=  T
     T  E   T   T   T   T
     L  T   T   T   T   T
     E  T   O   R   T   T
     T  B   T   T   T   T
     E  T   T   T   T   T
     T  T   T   T   T   T
     T  ~=  ~=  ~=  ~=  T
     ~==================~${reset}
"
}

delebetor:web() {
    echo -e "${green}   (
    \\
     )
##-------->        ByCh4n
     )
    /
   (${reset}
"
}

# Install a single apt package and report the result.
apt_install_one() {
    local pkg="$1"
    if apt-get install -y "$pkg" >/dev/null 2>&1; then
        log "${pkg} ${green}installed${reset}"
        return 0
    fi
    warn "${pkg} ${red}failed${reset} (package may not exist on this distro)"
    return 1
}

# Install a git tool under /opt (update if it exists), then run the optional build command.
git_install_one() {
    local name="$1" repo="$2" build="$3"
    local dest="${OPT_DIR}/${name}"

    if [ -d "$dest/.git" ]; then
        log "${name} already present, updating..."
        git -C "$dest" pull --quiet || { warn "${name} could not be updated"; return 1; }
    else
        if ! git clone --quiet "$repo" "$dest"; then
            warn "${name} ${red}clone failed${reset} (${repo})"
            return 1
        fi
    fi

    if [ -n "$build" ]; then
        if ( cd "$dest" && eval "$build" >/dev/null 2>&1 ); then
            log "${name} ${green}installed${reset} -> ${dest}"
        else
            warn "${name} cloned but the build step failed (${dest})"
            return 1
        fi
    else
        log "${name} ${green}cloned${reset} -> ${dest}"
    fi
    return 0
}

# ----------------------------------------------------------------------
# Main actions
# ----------------------------------------------------------------------
do_install() {
    need_root || return 1
    clear
    delebetor:banner
    echo -e "[${green}+${reset}] Download and installation starting.\n"

    log "Updating apt repositories..."
    apt-get update -y >/dev/null 2>&1 || warn "apt-get update failed, continuing anyway."

    local ok=0 fail=0 tool
    echo -e "\n${Bwhite}== apt tools ==${reset}"
    for tool in "${APT_TOOLS[@]}"; do
        if apt_install_one "$tool"; then ok=$((ok + 1)); else fail=$((fail + 1)); fi
    done

    echo -e "\n${Bwhite}== git tools (/opt) ==${reset}"
    if command -v git >/dev/null 2>&1; then
        local entry name repo build
        for entry in "${GIT_TOOLS[@]}"; do
            IFS='|' read -r name repo build <<< "$entry"
            if git_install_one "$name" "$repo" "$build"; then ok=$((ok + 1)); else fail=$((fail + 1)); fi
        done
    else
        warn "git is not installed, git-based tools skipped."
        fail=$((fail + ${#GIT_TOOLS[@]}))
    fi

    echo ""
    echo -e "[${green}+${reset}] Done. Succeeded: ${green}${ok}${reset}, failed: ${red}${fail}${reset}."
    [ "$fail" -gt 0 ] && echo -e "    You may need to install the failed ones manually for your distro."
}

do_web() {
    need_root || return 1
    clear
    delebetor:web
    echo -e "[${green}+${reset}] Installing the web pentest tool set.\n"
    apt-get update -y >/dev/null 2>&1 || warn "apt-get update failed."

    local tool
    for tool in nuclei subfinder httprobe dnsrecon; do
        apt_install_one "$tool"
    done
    echo ""
    warn "Automatic Nessus download removed (Tenable links are version/session dependent)."
    echo -e "    For Nessus: download from ${Bcyan}https://www.tenable.com/downloads/nessus${reset} and install with 'dpkg -i'."
}

do_delete() {
    need_root || return 1
    clear
    delebetor:banner
    warn "This will DELETE the tools under ${red}/opt${reset} and your shell history."
    local cont
    read -r -p "Do you really want to delete? [y/N] " cont
    case "$cont" in
        [yY]|[yY][eE][sS])
            echo -e "[${green}+${reset}] Delete started."
            echo "--------------------------------"
            local target name
            for target in "${GIT_TOOLS[@]}"; do
                name="${target%%|*}"
                rm -rf "${OPT_DIR:?}/${name}" && echo -e "  ${OPT_DIR}/${name} -> ${green}OK${reset}"
            done
            rm -f "${HOME}/.bash_history" "${HOME}/.zsh_history" 2>/dev/null && \
                echo -e "  shell history -> ${green}OK${reset}"
            history -c 2>/dev/null || true
            echo "--------------------------------"
            echo -e "[${green}+${reset}] Delete complete."
            ;;
        *)
            echo "Cancelled."
            ;;
    esac
}

show_help() {
    echo -e "${Bwhite}banner${reset}  ${green}=>${reset} show the ASCII banner"
    echo -e "${Bwhite}install${reset} ${green}=>${reset} install apt + git based pentest tools (root)"
    echo -e "${Bwhite}web${reset}     ${green}=>${reset} install the web pentest tool set (root)"
    echo -e "${Bwhite}delete${reset}  ${green}=>${reset} delete /opt tools and history (root, asks to confirm)"
    echo -e "${Bwhite}version${reset} ${green}=>${reset} show the version"
    echo -e "${Bwhite}clear${reset}   ${green}=>${reset} clear the screen"
    echo -e "${Bwhite}help${reset}    ${green}=>${reset} show this help"
    echo -e "${Bwhite}exit${reset}    ${green}=>${reset} quit (exit, e, x, q)"
}

show_version() {
    echo -e "Developed by ${green}ByCh4n${reset} ${Bwhite}${0##*/}${reset}, version ${Bcyan}${VERSION}${reset}."
}

# ----------------------------------------------------------------------
# Interactive shell
# ----------------------------------------------------------------------
interactive_shell() {
    clear
    delebetor:banner
    echo -e "Learn the commands with ${green}help${reset}."
    echo -e "Welcome ${green}${USER}@Delebetor${reset} ${green}[$PWD]${reset}"

    local input
    while true; do
        echo -ne "${green}»»» ${reset}"
        read -r input || break
        case "$input" in
            banner)        clear; delebetor:banner ;;
            install)       do_install ;;
            web)           do_web ;;
            delete)        do_delete ;;
            version)       show_version ;;
            help)          show_help ;;
            clear)         clear ;;
            exit|e|x|q)    exit 0 ;;
            "")            ;;
            *)             echo -e "${Bwhite}${0##*/}${reset}: command '${Bcyan}${input}${reset}' not found. Type '${green}help${reset}'." ;;
        esac
    done
}

# ----------------------------------------------------------------------
# Entry point — a command can also be passed directly as an argument
# ----------------------------------------------------------------------
main() {
    case "${1:-}" in
        install)          do_install ;;
        web)              do_web ;;
        delete)           do_delete ;;
        -v|--version)     show_version ;;
        -h|--help)        show_help ;;
        "")               interactive_shell ;;
        *)                echo -e "${Bwhite}${0##*/}${reset}: unknown argument '${1}'. Use '-h' for help."; exit 1 ;;
    esac
}

main "$@"
