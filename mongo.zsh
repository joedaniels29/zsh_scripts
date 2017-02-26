#!/usr/bin/env zsh

mongo_display(){
    local var=$*;
    ssh -T stitch <<EOSSH
        ls;
        pwd;
        mongoexport --port 28017 --username tester  --host localhost  --password tester  --db payload_db --collection seizure_data  --query $var --authenticationDatabase sm-epistudy
EOSSH
}
foo(){

}
# mongo sm-epistudy --host localhost --port 28017 --username tester --password tester --authenticationDatabase sm-epistudy  --eval " $var " ;


 # zsh_reinit; mongo_display stitch 'use payload_db; db.seizure_data.aggregate([{ $match: { userId: "306" } }, {$group : { _id : "$uuid", count : {$sum : 1}, off:{$first:"offsetToReference"}}},{$sort:{off: -1}}])'
