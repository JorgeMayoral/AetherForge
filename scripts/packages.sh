#!/usr/bin/env bash

packages=(
  yazi
  eza
  bat
)

for package in ${packages[@]}; do
  sudo zypper in ${package} --no-confirm
done
