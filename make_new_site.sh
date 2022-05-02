#! /bin/bash
git pull
echo "Enter site name:"
read site_name
echo "Enter site ipv4 prefix without cidr:"
read site_v4_prefix
echo "Enter site ipv6 prefix without cidr:"
read site_v6_prefix
echo "Enter site ASN:"
read site_asn
echo Creating directory structure for $site_name
mkdir inventory/$site_name
mkdir group_vars/$site_name
cp templates/example_site-group_vars.yml group_vars/$site_name/$site_name.yml
sed -i "s/lab/$site_name/g" "group_vars/$site_name/$site_name.yml"
sed -i "s/10.192.0.0/$site_v4_prefix/g" "group_vars/$site_name/$site_name.yml"
sed -i "s/2620:115:0::/$site_v6_prefix/g" "group_vars/$site_name/$site_name.yml"
sed -i "s/65524/$site_asn/g" "group_vars/$site_name/$site_name.yml"
cp templates/example_site-inventory.yml inventory/$site_name/$site_name.yml
sed -i "s/lab/$site_name/g" "inventory/$site_name/$site_name.yml"
echo "...Done."
