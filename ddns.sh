# change this

USERNAME='USERNAME'
AUTHKEY='API-KEY'
DOMAIN='bla.example.com'

PROXIE='false'
TTL="120"

GETIPURL="https://api.ipify.org/"
JQ="/usr/local/bin/jq-linux64"

# leave this as is

BASEDOMAIN=$(expr match "$DOMAIN" '.*\.\(.*\..*\)')
ZONEID=$(curl --silent -X GET "https://api.cloudflare.com/client/v4/zones?name=$BASEDOMAIN" -H "X-Auth-Email: $USERNAME" -H "X-Auth-Key: $AUTHKEY" -H "Content-Type: application/json" | $JQ -r '.result[].id')
RECORDID=$(curl --silent -X GET "https://api.cloudflare.com/client/v4/zones/$ZONEID/dns_records?type=A&name=$DOMAIN" -H "X-Auth-Email: $USERNAME" -H "X-Auth-Key: $AUTHKEY" -H "Content-Type: application/json" | $JQ -r '.result[].id')

CURRENTIP=$(curl --silent "$GETIPURL")
CLOUDFLAREIP=$(curl --silent -X GET "https://api.cloudflare.com/client/v4/zones/$ZONEID/dns_records?type=A&name=$DOMAIN" -H "X-Auth-Email: $USERNAME" -H "X-Auth-Key: $AUTHKEY" -H "Content-Type: application/json" | $JQ -r '.result[].content')

if expr "$CURRENTIP" : '[0-9][0-9]*\.[0-9][0-9]*\.[0-9][0-9]*\.[0-9][0-9]*$' >/dev/null; then
  if [ "$CLOUDFLAREIP" != "$CURRENTIP" ]; then
    curl --silent -X PUT "https://api.cloudflare.com/client/v4/zones/$ZONEID/dns_records/$RECORDID" -H "X-Auth-Email: $USERNAME" -H "X-Auth-Key: $AUTHKEY" -H "Content-Type: application/json" --data '{"type":"A","name":"'$DOMAIN'","content":"'$CURRENTIP'","ttl":'$TTL',"proxied":'$PROXIE'}' >/dev/null
  fi
fi
