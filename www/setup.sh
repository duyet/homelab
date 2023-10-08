set -x

echo Installing lighttpd ...
pkg install lighttpd

echo Start static hosting ...
killall lighttpd || echo
lighttpd -f lighttpd.conf
curl http://localhost:8080
