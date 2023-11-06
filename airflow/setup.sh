set -x

. ../install_deb.sh

apt install python3 python3-pip python3-venv
pip3 install -r requirements.txt

. ./start.sh
