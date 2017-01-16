mongo_display(){
    local var=$2;
    ssh -T $1 <<EOSSH
        ls;
        pwd;
        mongo sm-epistudy --host localhost --port 28017 --username tester --password tester --authenticationDatabase sm-epistudy  --eval " $var " ;
EOSSH
}


 # zsh_reinit; mongo_display stitch 'use payload_db; db.seizure_data.aggregate([{ $match: { userId: "306" } }, {$group : { _id : "$uuid", count : {$sum : 1}, off:{$first:"offsetToReference"}}},{$sort:{off: -1}}])'
