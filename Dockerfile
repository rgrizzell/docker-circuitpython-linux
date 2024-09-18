FROM debian:12-slim as build
ARG VERSION=9.1.3
ARG VARIANT=container
ARG MICROPYPATH=/ciruitpy/lib

# Install system requirements
RUN apt update \
 && apt install -y build-essential cmake git git-lfs gettext libffi-dev pkg-config python3 python3-pip python3-venv uncrustify
# Clone the CircuitPython project
RUN git clone -b $VERSION https://github.com/adafruit/circuitpython.git
# Setup build dependencies
WORKDIR /circuitpython
RUN python3 -m venv .venv
ENV PATH="/circuitpython/.venv/bin:$PATH"
RUN python3 -m pip install --upgrade -r requirements-dev.txt \
 && python tools/ci_fetch_deps.py tests
# Add the custom Unix port variants
COPY variants/ /circuitpython/ports/unix/variants/
# Build the binaires
RUN make -C mpy-cross \
 && VARIANT=$VARIANT BUILD=build make -C ports/unix

# Create final runtime container
FROM debian:12-slim
COPY --from=build /circuitpython/mpy-cross/build/mpy-cross /usr/local/bin/mpy-cross
COPY --from=build /circuitpython/ports/unix/build/micropython /usr/local/bin/micropython
# Setup non-root runtime user
RUN useradd -Md /circuitpy circuitpy \
 && mkdir /circuitpy \
 && chown circuitpy:circuitpy /circuitpy
USER circuitpy
WORKDIR /circuitpy
# Load libraries from the working directory
ENV MICROPYPATH=$MICROPYPATH
ENTRYPOINT ["/usr/local/bin/micropython"]
