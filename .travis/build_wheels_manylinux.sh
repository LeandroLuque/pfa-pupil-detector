#!/bin/bash
set -e

python_bin_dir="$(echo /opt/python/cp${PY_MM}*/bin)"
echo Activating Python binaries at $python_bin_dir
export PATH=$python_bin_dir:$PATH

pip install -U pip

pip wheel /io -w /io/raw_wheels --no-deps

for whl in /io/raw_wheels/*.whl; do
    auditwheel repair "$whl" --plat manylinux2014_x86_64 -w /io/dist/
done

for whl in /io/dist/*.whl; do
    pip install "$whl"
done

python -c "from pure_detector import PuReDetector"