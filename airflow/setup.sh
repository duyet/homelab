set -x

echo NOTE: Installing Python ...
echo NOTE: Rust is needed for some deps building ... 
pkg install python python-static rust rustc-dev

export CARGO_BUILD_JOBS=1
pip3 install -r requirements.txt
