#!/bin/sh

# Download GeoIP DB if license key is in ENV
if [ "$GEOIP2_LICENSE" ]; then
    wget "https://download.maxmind.com/app/geoip_download?edition_id=GeoLite2-City&license_key=${GEOIP2_LICENSE}&suffix=tar.gz" -O /tmp/geoip-city.tgz
    wget "https://download.maxmind.com/app/geoip_download?edition_id=GeoLite2-Country&license_key=${GEOIP2_LICENSE}&suffix=tar.gz" -O /tmp/geoipc-country.tgz

    mkdir -p /usr/share/GeoIP
    cd /tmp
    tar -xzf /tmp/geoip-city.tgz
    tar -xzf /tmp/geoipc-country.tgz
    find /tmp -name '*.mmdb' -exec mv {} /usr/share/GeoIP \;
fi

exec nginx -g 'daemon off;'
