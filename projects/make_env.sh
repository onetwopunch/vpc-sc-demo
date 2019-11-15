#!/bin/bash
echo "#!/usr/bin/env bash" > ../env.sh

project1_id=$(terraform output project1_id)
echo "export TF_VAR_project1_id='$project1_id'" > ../env.sh

project2_id=$(terraform output project2_id)
echo "export TF_VAR_project2_id='$project2_id'" >> ../env.sh
