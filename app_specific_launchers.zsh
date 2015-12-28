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
 sServerE "${WORK_PROJECTS_FOLDER}/reach-search" 325
}

sRSr(){
 sServerR "${WORK_PROJECTS_FOLDER}/reach-search" 325
}

sRS(){
 sServer "${WORK_PROJECTS_FOLDER}/reach-search" 325
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
