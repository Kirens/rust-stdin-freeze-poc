# Cargo build script regression
It seems build scripts are executed differently in cargo 1.62.1 and 1.63.0 that I couldn't find an explanation for it in the [changelog](https://github.com/rust-lang/cargo/blob/master/CHANGELOG.md) or [rust changelog](https://github.com/rust-lang/rust/blob/master/RELEASES.md#version-1630-2022-08-11).

## Demo
For convenience, there's a trivial `docker-compose.yaml` to compare the different versions. Simply run:
```sh
docker-compose up
```

We're expecting 1.62 to compile and shut down properly, while 1.63 freezes. Outputting something like:
```
[+] Running 2/2
Attaching to 1.62, 1.63
1.62  | Working with cargo 1.62.1 (a748cf5a3 2022-06-08)
1.62  | > Explicitly set `stdin` to `Stdio:null`
1.63  | Working with cargo 1.63.0 (fd9c4297c 2022-07-01)
...
1.63  | > Don't specify `stdin`
1.63  | > On 1.63 we expect this to freeze
...
1.62  |      Running `target/debug/stdin-freeze-poc`
1.62  | Hello, World!
1.62 exited with code 0
^CGracefully stopping... (press Ctrl+C again to force)
[+] Running 1/2
 ⠏ Container 1.63  Stopping
```

## Background
In the older versions the build script seems to be run with a terminated _stdin_, while not in the newer versions.

A package I'm using tries to determine if an executable is available by running it in the build script.
(This might be badly designed, but that's beside the point)
With a terminated _stdin_, the executable simply exits.
But in the newer versions it waits for input, preventing the build script and hence the compilation from ever terminating.
