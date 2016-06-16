HOME_FOLDER=$(cd; pwd)

SCRIPTS_FOLDER="${HOME_FOLDER}/.zsh_scripts"
JXA_FOLDER="${SCRIPTS_FOLDER}/JXA"
RUBY_FOLDER="${SCRIPTS_FOLDER}/ruby"
PROJECTS_FOLDER="${HOME_FOLDER}/Projects"
CONTRACT_PROJECTS_FOLDER="${PROJECTS_FOLDER}/Contract"
WORK_PROJECTS_FOLDER="${PROJECTS_FOLDER}/Work"


if [[ "$(uname)" == "Darwin" ]]; then
    WORK_PROJECTS_FOLDER="${PROJECTS_FOLDER}/Work"
elif [ "$(expr substr $(uname -s) 1 5)" = "Linux" ]; then
    WORK_PROJECTS_FOLDER="${HOME_FOLDER}/Projects"
fi
