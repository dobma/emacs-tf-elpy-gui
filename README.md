# This is my dockerfile for

## include tensorflow-only-cpu version and emacs-gui with elpy

## Installtion
```shell
# docker build -f Dockerfile -t emacs-gui .
```
## Some setting

1. after build the image
```shell
# docker run -e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix -v /project/path/on/host:/project --hostname=$HOSTNAME -v $HOME/.Xauthority:/root/.Xauthority -it --rm emacs-gui 
```
2. install pyim, elpy and theme
```lisp
# in emacs
M-x package-install
calmer-forest-theme
M-x package-install
pyim
M-x package-install
elpy
```

## Commit new image
```shell
# docker commit <container id> <image-name:tag>
```

## Run new image
