#!/usr/bin/env zsh
# OASIS Launchers
sOASe(){
 sServerE "${WORK_PROJECTS_FOLDER}/Oasis" 326
}

sOASr(){
 sServerR "${WORK_PROJECTS_FOLDER}/Oasis" 326
}

sOAS(){
 sServer "${WORK_PROJECTS_FOLDER}/Oasis" 326
}

# findings-notification Launchers
sFNe(){
 sServerE "${WORK_PROJECTS_FOLDER}/findings-notification" 327
}

sFNr(){
 sServerR "${WORK_PROJECTS_FOLDER}/findings-notification" 327
}

sFN(){
 sServer "${WORK_PROJECTS_FOLDER}/findings-notification" 327
}

# reach-search Launchers
sRSe(){
 sServerE "${WORK_PROJECTS_FOLDER}/ReachSearch" 325
}

sRSr(){
 sServerR "${WORK_PROJECTS_FOLDER}/ReachSearch" 325
}

sRS(){
 sServer "${WORK_PROJECTS_FOLDER}/ReachSearch" 325
}
# resident-worklist Launchers
sRWe(){
 sServerE "${WORK_PROJECTS_FOLDER}/resident-worklist" 321
}

sRWr(){
 sServerR "${WORK_PROJECTS_FOLDER}/resident-worklist" 321
}

sRW(){
 sServer "${WORK_PROJECTS_FOLDER}/resident-worklist" 321
}

sServer(){
 cd $1
 startServers $2
 safe_open_idea .
}

sServerE(){
 cd $1
 startServersE $2
}
sServerR(){
 cd $1
 startServersR $2
}
