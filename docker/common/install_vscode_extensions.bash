#!/bin/bash

extensions=(
  "cheshirekow.cmake-format"
  "cpmcgrath.codealignment-vscode"
  "dotjoshjohnson.xml"
  "esbenp.prettier-vscode"
  "foxundermoon.shell-format"
  "github.copilot"
  "github.copilot-chat"
  "github.vscode-pull-request-github"
  "josetr.cmake-language-support-vscode"
  "llvm-vs-code-extensions.vscode-clangd"
  "ms-dotnettools.vscode-dotnet-runtime"
  "ms-iot.vscode-ros"
  "ms-python.black-formatter"
  "ms-python.debugpy"
  "ms-python.python"
  "ms-python.vscode-pylance"
  "ms-vscode.cmake-tools"
  "ms-vscode.cpptools"
  "ms-vscode.cpptools-extension-pack"
  "twxs.cmake"
  "xaver.clang-format"
)

for extension in "${extensions[@]}"; do
  code --install-extension $extension
done
