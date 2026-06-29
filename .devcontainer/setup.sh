#!/usr/bin/env bash
set -e

echo "==> Updating apt and installing Verilator + Yosys (prebuilt packages)"
sudo apt-get update
sudo apt-get install -y \
    verilator \
    yosys \
    build-essential \
    cmake \
    git \
    libgoogle-perftools-dev \
    libboost-all-dev \
    libgmp-dev \
    libmpfr-dev \
    libflint-dev \
    libisl-dev \
    zlib1g-dev \
    tcl-dev

echo "==> Verilator version:"
verilator --version

echo "==> Yosys version:"
yosys -version

echo "==> Cloning and building OpenTimer (this is the slow step, ~5-10 min)"
if [ ! -d "$HOME/OpenTimer" ]; then
    git clone https://github.com/OpenTimer/OpenTimer.git "$HOME/OpenTimer"
fi
cd "$HOME/OpenTimer"
mkdir -p build && cd build
cmake ..
make -j"$(nproc)"
sudo make install

echo "==> Setup complete. Verilator, Yosys, and OpenTimer are ready."
