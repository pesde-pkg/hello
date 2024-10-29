# Introduction

The `pesde/hello` package is intended to be used in examples.

It exports a library and a binary, both of which prints a simple greeting.

## Installation

The package can be installed with the following command:

```sh
pesde add pesde/hello
```

## Library

The library is a single function that prints hello.

```luau
local hello = require("./luau_packages/hello")

hello()
```

## Binary

The binary prints hello. You can either run it using `hello` after installing
the package in a pesde project like this:

```sh
hello
```

Or you can run it anywhere using `pesde x` like this:

```sh
pesde x pesde/hello
```
