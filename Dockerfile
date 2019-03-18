FROM ubuntu:18.04
LABEL maintainer="Dob Ma <dobmalinux@gmail.com>"
# A container for gui-emacs elpy environment and tensorflow

ENV DEBIAN_FRONTEND noninteractive
# install apt-util
RUN apt-get update && apt-get install -y --no-install-recommends \
        apt-utils
# install emacs-gnu
RUN apt-get install -y --no-install-recommends \
        emacs25
# Pick up some TF dependencies
RUN apt-get install -y --no-install-recommends \
        build-essential \
        curl \
        libfreetype6-dev \
        libhdf5-serial-dev \
        libpng-dev \
        libzmq3-dev \
        pkg-config \
        python3 \
        python3-dev \
        rsync \
        software-properties-common \
        unzip \
        && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# create python bin file
RUN ln -s -f /usr/bin/python3 /usr/bin/python

# install pip
RUN curl -O https://bootstrap.pypa.io/get-pip.py && \
    python get-pip.py && \
    rm get-pip.py

# install other dependencies
RUN pip --no-cache-dir install -i https://pypi.tuna.tsinghua.edu.cn/simple \
        Pillow \
        h5py \
        keras_applications \
        keras_preprocessing \
        matplotlib \
        numpy \
        pandas \
        scipy \
        sklearn

# for elpy environment
RUN pip --no-cache-dir install -i https://pypi.tuna.tsinghua.edu.cn/simple \
        rope \
        jedi \
        flake8 \
        importmagic \
        autopep8 \
        yapf

#add emacs init file
ADD emacs-init /root/.emacs

# Install TensorFlow CPU version from central repo
RUN pip --no-cache-dir install \
   https://storage.googleapis.com/tensorflow/linux/cpu/tensorflow-1.12.0-cp36-cp36m-linux_x86_64.whl 

# mount point
WORKDIR "/project"

# run emacs
CMD /usr/bin/env XLIB_SKIP_ARGB_VISUALS=1 /usr/bin/emacs
