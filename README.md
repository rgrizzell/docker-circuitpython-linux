# CircuitPython Container

This is a container image for the Unix/Linux port of CircuitPython. It can be useful for running unit tests or trying out CircuitPython when you don't have access to a board.

## Getting Started
### REPL
To enter the REPL, simply run the container.
```text
$ docker run -it ghcr.io/rgrizzell/circuitpython
CircuitPython 9.0.5 on 2024-05-22; linux [GCC 12.2.0] version
Use Ctrl-D to exit, Ctrl-E for paste mode
>>> 
```

### Inline
Inline scripts can be passed using the `-c` flag.
```text
$ docker run -it ghcr.io/rgrizzell/circuitpython -c 'import sys; print(sys.version)'
3.4.0; CircuitPython 9.0.5 on 2024-05-22
```

### Files
Files can be run by mounting the directory into `/app` and passing the file name to the container.
```text
$ cat version.py
import sys
print(sys.version)

$ docker run -v $PWD:/circuitpy -it ghcr.io/rgrizzell/circuitpython version.py
3.4.0; CircuitPython 9.0.5 on 2024-05-22
```

## Advanced Usage
### mpy-cross
The `mpy-cross` utility is available as well. To access it, include the `--entrypoint=mpy-cross` option when starting the container.

To compile a file to bytecode format for a target architecture, mount the code directory with `-v $PWD:/circuitpy` and then pass the compilation options at the end: `-march=xtensa version.py`

```text
$ docker run -v $PWD:/circuitpy --entrypoint=mpy-cross -it ghcr.io/rgrizzell/circuitpython -march=xtensa version.py
$ ls version.*
-rw-r--r--. 1 rgrizzell rgrizzell 58 May 22 13:38 version.mpy
-rw-r--r--. 1 rgrizzell rgrizzell 30 May 22 12:55 version.py
```

### Filesystem
The runtime container is based on Debian Slim, and the underlying filesystem can be access by adding `--entrypoint=/bin/bash` when starting the container.
```text
$ docker run --entrypoint=/bin/bash -it ghcr.io/rgrizzell/circuitpython
circuitpy@1d66ff3d565b:~#
circuitpy@1d66ff3d565b:~# ls /
bin  boot  circuitpy  dev  etc  home  lib  lib64  media  mnt  opt  proc  root  run  sbin  srv  sys  tmp  usr  var
```

## Building
Building the image is straight-forward.
```text
docker build -t circuitpython .
```

Specific CircuitPython versions can also be built by passing a build argument.
```text
docker build -t circuitpython:9.0.4 --build-arg="VERSION=9.0.4" .
```