---
layout: post
date: 2015-05-21 23:00
title: Rust in a glance
keywords: Rust, cargo, crates
description: Start to learn Rust programming language
comments: true
category: Rust
---

Since Rust 1.0 has been occupying my Weibo’s timeline, I think it’s time to have a try on this programming language.

## Install Rust on OS X

There exists `pkg` file for installing Rust on Mac, however, I’d prefer using commands:

```
curl -sf -L https://static.rust-lang.org/rustup.sh | sh
```

It’s simple and efficient.

After this, we are already on the way using Rust.

```
rustc --version
```

## Hello, Rust!

Now we could create a Rust file to start the way of discovery Rust, create a file named “hellorust.rs”:

```
fn main () {
    println!("Hello Rust!");
}
```

It’s easy to compile the first Rust file like “gcc” or other command line compilers:

```
$ rustc hellorust.rs
```

This would create a executable file, run it to see our first program’s result:

```
$ ./hellorust
```

## Use Cargo

[Cargo](https://github.com/rust-lang/cargo) is the official Package Manager for Rust.

Create a new package with command line:

```
cargo new package_name
```

And the command above would create a “Hello World” program with for you.

Build with Cargo:

```
cargo build
```

And run with Cargo:

```
cargo run
```

> To be continued...
