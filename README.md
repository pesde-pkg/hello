# pesde/hello

A pesde package that prints hello. This package is intended to be used in
examples.

## Library

The library contains a single function that prints hello.

```luau
local hello = require("./packages/hello")

hello()
```

## Binary

The binary prints hello.

```sh
pesde x pesde/hello
```

## Building

The packages for different targets are generated with a script.

```sh
pesde run build
```

The generated packages will appear in the `build` directory.
