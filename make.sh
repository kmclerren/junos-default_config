#! /bin/bash
git pull ; cd inventory ; git pull ; cd ..
echo "Enter site name:"
read site_name
ansible-playbook --version
ansible-playbook -i inventory/$site_name make.pb.yml --ask-vault-pass
git add --all ; git commit -m "make.sh $site_name" ; git push origin master
cd inventory ; git add --all ; git commit -m "make.sh $site_name inventory" ; git push origin master ; cd ..