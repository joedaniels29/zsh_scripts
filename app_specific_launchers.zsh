# OASIS Launchers
sOASe(){
 staServerR "${WORK_PROJECTS_FOLDER}/Oasis" 326
}

sOASr(){
 staServerR "${WORK_PROJECTS_FOLDER}/Oasis" 326
}

sOAS(){
 staServer "${WORK_PROJECTS_FOLDER}/Oasis" 326
}

# findings-notification Launchers
sFNe(){
 staServerR "${WORK_PROJECTS_FOLDER}/findings-notification" 327
}

sFNr(){
 staServerR "${WORK_PROJECTS_FOLDER}/findings-notification" 327
}

sFN(){
 staServer "${WORK_PROJECTS_FOLDER}/findings-notification" 327
}

# reach-search Launchers
sRSe(){
 staServerR "${WORK_PROJECTS_FOLDER}/reach-search" 325
}

sRSr(){
 staServerR "${WORK_PROJECTS_FOLDER}/reach-search" 325
}

sRS(){
 staServer "${WORK_PROJECTS_FOLDER}/reach-search" 325
}

sServer(){
 cd $1
 startServers $2
}

sServerE(){
 cd $1
 startServersE $2
}
sServerR(){
 cd $1
 startServersE $2
}
