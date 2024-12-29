function cb() {
  common_args=(
    --symlink-install
    --parallel-workers "$(($(nproc)))"
    --cmake-args
    "-DCMAKE_BUILD_TYPE=Release"
    "-DCMAKE_EXPORT_COMPILE_COMMANDS=ON"
    "-DCMAKE_CXX_FLAGS=-Wall -Wextra -Wno-unused-parameter -Wno-sign-compare -Werror=return-type -Werror=switch"
    "-DCMAKE_EXE_LINKER_FLAGS=-fuse-ld=mold"
    "-DCMAKE_MODULE_LINKER_FLAGS=-fuse-ld=mold"
    "-DCMAKE_SHARED_LINKER_FLAGS=-fuse-ld=mold"
     --no-warn-unused-cli # suppress CMake warning of "Manually-specified variables were not used by the project:"
  )

  if [ $# -gt 0 ]; then
    colcon build --packages-up-to "$1" "${common_args[@]}"
  else
    colcon build "${common_args[@]}"
  fi
}

cb $@
