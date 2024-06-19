# Variants
Unix ports of CircuitPython (and MicroPython) use variants instead of board definitions. These variants are used to build versions of CircuitPython intended mostly for testing purposes.

The `coverage` variant is compiled with most libraries, but also contains debug and profiling extras that may not be desired. The `standard`, `minimal`, and `nanbox` variants exist, do not contain any of the built-in CircuitPython libraries. The `minimal` and `nanbox` variants have even less features enabled.

In order to build a version of CircuitPython with the libraries and without the debug hooks, a new variant must be defined. This is the `container` variant.

For more details on the types of available variant definitions, see the CircuitPython repository: https://github.com/adafruit/circuitpython/tree/main/ports/unix/variants

## Building

Contents of this directory is copied to `/circuitpython/ports/unix/variants/` before being compiled.

By default, the `container` variant is used, however custom variants can be built by setting the `VARIANT` build arg to the name of the custom variant's directory. For example a variant titled `mycustomvariant` would be built with the following command.

```text
docker build -t circuitpython --build-arg="VARIANT=mycustomvariant" .
```
