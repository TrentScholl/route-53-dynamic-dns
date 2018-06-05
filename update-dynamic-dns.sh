#!/bin/sh

while :
do
  [ -z "$PUBLIC_IP" ] && PUBLIC_IP=`dig +short myip.opendns.com @resolver1.opendns.com`
  record=$ROUTE53_DOMAIN_A_RECORD
  zone=$ROUTE53_ZONE
  cmd="cli53 rrcreate $zone $record A $PUBLIC_IP --ttl 300 --replace"
  [ -z "$DRY_ROUTE53" ] && $cmd || echo "DRYRUN: $cmd"
  echo "Sleeping for $ROUTE53_UPDATE_FREQUENCY seconds..."
  sleep $ROUTE53_UPDATE_FREQUENCY
done