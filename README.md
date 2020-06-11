# Cycling Data
Consume Cycling data from rides then parse said data into CSV file for use with other programs.

Cycles -> Records Ride Data (time, distance, etc) -> 

This was created as a tool to solve my simple problem of entering cycling and training data offline and quickly without fuss on any device that can run a terminal emulator.

## Installation
To install the program run use the crystal compiler to handle it.
``` sh
$ crystal build src/cycling.cr --release
```

You can optionally use Cake in the directory to compile. Cake is a version of a Makefile specifically for Crystal projects.
``` sh
$ cake
```

If you're not familiar with building programs in Crystal or want to know more refer to the [using the compiler section of the crystal docs](https://crystal-lang.org/reference/using_the_compiler/#crystal-build).

## Usage

``` sh
$ cycling
```

## Getting Help
The program accepts flags, use `-h` to read about them.
``` sh
$ cycling -h
```
## Development
No shard dependencies used, but make sure your version of crystal is up to date.
All development happens in the `src/` directory.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contributors

- [Konstantine](https://materialfuture.net) - creator and maintainer
