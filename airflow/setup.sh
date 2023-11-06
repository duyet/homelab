set -x

. ../install_deb.sh

apt install python3 python3-pip python3-venv
pip3 install -r requirements.txt

. ./env.sh

echo Initializing the database...
. ./init_db.sh

echo Starting the web server by ./start_webserver.sh
echo Starting the scheduler by ./start_scheduler.sh
