#!/bin/sh -ex

mydir=`dirname $0`

secret=`ceph config-key get mgr/restful/keys/admin`
active=`ceph mgr dump | jq -r .active_name`
echo "active $active  admin secret $secret"

prefix="mgr/restful/$active"
addr=`ceph config-key get $prefix/server_addr`
port=`ceph config-key get $prefix/server_port`
url="https://$addr:$port"
echo "prefix $prefix url $url"
$mydir/test_mgr_rest_api.py $url $secret

echo $0 OK
