#! /bin/bash
echo "Enter site name:"
read site_name
ansible-playbook -i inventory/$site_name make_hostvars.pb.yml