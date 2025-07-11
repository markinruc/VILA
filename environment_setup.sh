#!/usr/bin/env bash
set -e

# This is required to enable PEP 660 support
pip install --upgrade pip setuptools

# Install FlashAttention2
pip install https://github.com/Dao-AILab/flash-attention/releases/download/v2.5.8/flash_attn-2.5.8+cu122torch2.3cxx11abiFALSE-cp310-cp310-linux_x86_64.whl

# Install VILA
pip install -e ".[train,eval]"

# Quantization requires the newest triton version, and introduce dependency issue
pip install triton==3.1.0

# numpy introduce a lot dependencies issues, separate from pyproject.yaml
# pip install numpy==1.26.4

# Replace transformers and deepspeed files
site_pkg_path=$(python -c 'import site; print(site.getsitepackages()[0])')
cp -rv ./llava/train/deepspeed_replace/* $site_pkg_path/deepspeed/

# Downgrade protobuf to 3.20 for backward compatibility
pip install protobuf==3.20.*
