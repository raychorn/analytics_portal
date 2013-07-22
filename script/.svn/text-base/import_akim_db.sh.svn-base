#!/bin/bash

cd db
mv base base_old
mv base_akim base
cd ..
rake --trace db:data:load_dir
cd db
mv base base_akim
mv base_old base
cd ..

