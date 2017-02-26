#!/usr/bin/env zsh


# turns out to be really useful...
coffee_and_remove(){
 coffee -c $*;
 rm -rf $*;
}
