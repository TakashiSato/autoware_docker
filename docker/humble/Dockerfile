FROM osrf/ros:humble-desktop AS common

# args
ARG ROS_DISTRO
ARG USERNAME
ARG PUID
ARG PGID

# set environment variables
ENV HOME=/home/${USERNAME}
ENV ROS_DISTRO=humble
ENV TERM=screen-256color

# add repository for zenoh-bridge-ros2dds
RUN echo "deb [trusted=yes] https://download.eclipse.org/zenoh/debian-repo/ /" | tee -a /etc/apt/sources.list > /dev/null
RUN echo "deb [trusted=yes] https://s3.amazonaws.com/autonomoustuff-repo/ $(lsb_release -sc) main" > /etc/apt/sources.list.d/autonomoustuff-public.list

# install base packages
RUN apt-get update -q \
    && apt-get upgrade -yqq \
    && apt-get install -yqq --no-install-recommends -y \
    bash-completion \
    vim \
    tmux \
    git \
    git-lfs \
    net-tools \
    iproute2 \
    iputils-ping \
    psmisc \
    cmake \
    curl \
    wget \
    zip \
    unzip \
    locales \
    ccache \
    clang-format \
    libgoogle-glog-dev \
    liburdfdom-tools \
    python3-rosdep \
    python3-rospkg \
    python3-vcstool \
    python3-colcon-common-extensions \
    python3-colcon-clean \
    python3-pip \
    python3-venv \
    python3-pandas \
    python3-rich \
    mold \
    cargo \
    clang \
    git-secrets \
    wmctrl \
    libgl1-mesa-glx \
    libgl1-mesa-dri \
    zenoh-bridge-ros2dds \
    ros-${ROS_DISTRO}-rmw-cyclonedds-cpp \
    ros-${ROS_DISTRO}-rqt-tf-tree \
    ros-${ROS_DISTRO}-rqt-graph \
    ros-${ROS_DISTRO}-rqt-runtime-monitor \
    ros-${ROS_DISTRO}-rqt-robot-monitor \
    ros-${ROS_DISTRO}-rqt-robot-dashboard \
    ros-${ROS_DISTRO}-plotjuggler-ros \
    ros-${ROS_DISTRO}-rosbridge-suite \
    ros-${ROS_DISTRO}-foxglove-bridge \
    # for autoware
    apt-transport-https \
    ros-${ROS_DISTRO}-pacmod3-msgs \
    ros-${ROS_DISTRO}-diagnostic-updater \
    ros-${ROS_DISTRO}-aruco \
    ros-${ROS_DISTRO}-pcl-ros \
    ros-${ROS_DISTRO}-ros-testing \
    ros-${ROS_DISTRO}-sophus \
    ros-${ROS_DISTRO}-grid-map-ros \
    ros-${ROS_DISTRO}-magic-enum \
    ros-${ROS_DISTRO}-can-msgs \
    ros-${ROS_DISTRO}-topic-tools \
    ros-${ROS_DISTRO}-grid-map-core \
    ros-${ROS_DISTRO}-lanelet2-core \
    ros-${ROS_DISTRO}-lanelet2-io \
    ros-${ROS_DISTRO}-radar-msgs \
    ros-${ROS_DISTRO}-cudnn-cmake-module \
    ros-${ROS_DISTRO}-tensorrt-cmake-module \
    librange-v3-dev \
    ros-${ROS_DISTRO}-velodyne-driver \
    ros-${ROS_DISTRO}-velodyne-pointcloud \
    ros-${ROS_DISTRO}-grid-map-costmap-2d \
    ros-${ROS_DISTRO}-grid-map-msgs \
    ros-${ROS_DISTRO}-nav2-costmap-2d \
    ros-${ROS_DISTRO}-geographic-info \
    ros-${ROS_DISTRO}-geographic-msgs \
    libgeographic-dev \
    ros-${ROS_DISTRO}-geodesy \
    ros-${ROS_DISTRO}-osqp-vendor \
    ros-${ROS_DISTRO}-proxsuite \
    ros-${ROS_DISTRO}-ublox-gps \
    ros-${ROS_DISTRO}-usb-cam \
    ros-${ROS_DISTRO}-lanelet2-maps \
    ros-${ROS_DISTRO}-lanelet2-projection \
    ros-${ROS_DISTRO}-lanelet2-routing \
    ros-${ROS_DISTRO}-lanelet2-traffic-rules \
    ros-${ROS_DISTRO}-lanelet2-validation \
    libpugixml-dev \
    ros-${ROS_DISTRO}-velodyne-msgs \
    ros-${ROS_DISTRO}-tf-transformations \
    ros-${ROS_DISTRO}-ament-clang-format \
    nlohmann-json3-dev \
    ros-${ROS_DISTRO}-udp-msgs \
    python3-flask-cors \
    ros-${ROS_DISTRO}-generate-parameter-library \
    ros-${ROS_DISTRO}-lanelet2-python \
    bluez \
    ros-${ROS_DISTRO}-grid-map-pcl \
    ros-${ROS_DISTRO}-nmea-msgs \
    ros-${ROS_DISTRO}-ublox-msgs \
    ros-${ROS_DISTRO}-xacro \
    python3-flask \
    ros-${ROS_DISTRO}-septentrio-gnss-driver \
    ros-${ROS_DISTRO}-rosbag2-storage-mcap \
    libcgal-dev \
    ros-${ROS_DISTRO}-point-cloud-msg-wrapper \
    python3-torch \
    ros-${ROS_DISTRO}-diagnostic-aggregator \
    ros-${ROS_DISTRO}-grid-map-cv \
    ros-${ROS_DISTRO}-behaviortree-cpp-v3 \
    libcrypto++-dev \
    libcpprest-dev \
    chrony \
    sysstat \
    libnl-genl-3-dev \
    libopenblas-dev \
    ros-${ROS_DISTRO}-tvm-vendor


# apply colorized patch to colcon
# ref.: https://github.com/colcon/colcon-core/pull/487/files#diff-043de46368c04caef5538ebc321cfdc1e69c3626b4d00ccd4e3dbf346a846a46R46
ARG COLCON_PATH_DIR="/usr/lib/python3/dist-packages/colcon_core/event_handler"
COPY ./common/colcon_colorized_patch.diff ${COLCON_PATH_DIR}/patch.diff
RUN cd ${COLCON_PATH_DIR} \
    && patch console_start_end.py < patch.diff

# clean apt cache
RUN apt-get autoremove -yqq \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# remove apt.conf.d/docker-clean to enable auto-completion of apt command
RUN rm /etc/apt/apt.conf.d/docker-clean

# set locale
RUN locale-gen en_US.UTF-8
ENV LANG=en_US.UTF-8 LANGUAGE=en_US:en LC_ALL=en_US.UTF-8

# create user
RUN groupadd --gid ${PGID} ${USERNAME} && \
    useradd --uid ${PUID} --gid ${PGID} --create-home --home-dir ${HOME} --shell /bin/bash --groups adm,sudo ${USERNAME} && \
    echo "${USERNAME}:${USERNAME}" | chpasswd && \
    echo "${USERNAME} ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# create ccache and vscode_server directory for persitent
RUN CACHE_DIR="${HOME}/.cache" \
    && CCACHE_DIR="${CACHE_DIR}/ccache" \
    && mkdir -p ${CCACHE_DIR} \
    && chown -R ${USERNAME}:${USERNAME} ${CACHE_DIR} \
    && VSCODE_SERVER_DIR="${HOME}/.vscode-server" \
    && mkdir -p ${VSCODE_SERVER_DIR} \
    && chown -R ${USERNAME}:${USERNAME} ${VSCODE_SERVER_DIR}

# enable bash history in container
RUN SNIPPET="export PROMPT_COMMAND='history -a' && export HISTFILE=/commandhistory/.bash_history && export HISTCONTROL=ignoredups:erasedups" \
    && mkdir /commandhistory \
    && touch /commandhistory/.bash_history \
    && chown -R ${USERNAME}:${USERNAME} /commandhistory \
    && echo ${SNIPPET} >> "${HOME}/.bashrc"

# change to user
USER ${USERNAME}

# ros settings
RUN rosdep update
RUN echo "source ~/.rosrc" >> ${HOME}/.bashrc

# install autoware from source
ARG AUTOWARE_WS=${HOME}/autoware
RUN git clone --depth 1 -b 2024.11 https://github.com/autowarefoundation/autoware.git ${AUTOWARE_WS} \
    && cd ${AUTOWARE_WS} \
    && mkdir src \
    && vcs import src < autoware.repos
COPY --chown=${USERNAME}:${USERNAME} ./common/settings.json ${AUTOWARE_WS}/.vscode/settings.json

# build autoware from source
RUN cd ${AUTOWARE_WS} \
    && /bin/bash -c "source /opt/ros/${ROS_DISTRO}/setup.bash \
    && rosdep install -r --from-paths . --ignore-src --rosdistro ${ROS_DISTRO} -y \
    && colcon build --event-handlers desktop_notification- status- --parallel-workers '$(($(nproc)-2))' --cmake-args -DCMAKE_BUILD_TYPE=Release -DCMAKE_EXPORT_COMPILE_COMMANDS=ON -DBUILD_TESTING=OFF -DCMAKE_EXE_LINKER_FLAGS=-fuse-ld=mold -DCMAKE_MODULE_LINKER_FLAGS=-fuse-ld=mold -DCMAKE_SHARED_LINKER_FLAGS=-fuse-ld=mold"

# avoid warning
RUN mkdir /tmp/runtime-${USERNAME} && chmod 0700 /tmp/runtime-${USERNAME}

# fzf settings
RUN git clone https://github.com/junegunn/fzf.git ~/.fzf \
    && ~/.fzf/install --all --key-bindings --completion --update-rc --no-zsh --no-fish \
    && echo "export FZF_DEFAULT_COMMAND='rg --files --hidden --glob \"!.git\"'" >> "${HOME}/.fzf.bash" \
    && echo "export FZF_DEFAULT_OPTS='--height 40% --reverse --border'" >> "${HOME}/.fzf.bash"

# common settings
COPY --chown=${USERNAME}:${USERNAME} ./common/.commonrc ${HOME}/.commonrc
RUN echo "source ~/.commonrc" >> ${HOME}/.bashrc
# enable tab-completion with all alias
# Note: bash_completion must be sourced after all alias defined
# ref. https://superuser.com/questions/436314/how-can-i-get-bash-to-perform-tab-completion-for-my-aliases/437508#437508
COPY --chown=${USERNAME}:${USERNAME} ./common/.bash_alias_completion ${HOME}/.bash_alias_completion
RUN echo "source ~/.bash_alias_completion" >> ${HOME}/.bashrc

# persistence .config and .ros/log in container
RUN mkdir -p ${HOME}/.config
RUN mkdir -p ${HOME}/.ros/log

# create colcon_ws directories for volume mount
RUN mkdir -p ${HOME}/colcon_ws/build \
    && mkdir -p ${HOME}/colcon_ws/install \
    && mkdir -p ${HOME}/colcon_ws/log \
    && mkdir -p ${HOME}/colcon_ws/.cache \
    && chown -R ${USERNAME}:${USERNAME} ${HOME}/colcon_ws/build \
    && chown -R ${USERNAME}:${USERNAME} ${HOME}/colcon_ws/install \
    && chown -R ${USERNAME}:${USERNAME} ${HOME}/colcon_ws/log \
    && chown -R ${USERNAME}:${USERNAME} ${HOME}/colcon_ws/.cache

WORKDIR ${HOME}
