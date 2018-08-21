## About FloPoCo

FloPoCo is a generator of arithmetic cores targeting (mostly) FPGAs. It is
maintained by Florent de Dinechin.

## About this Repository

The goal of this repository is to make it easy to install and use FloPoCo. It features:

- A Nix expression for FloPoCo (and some of its dependencies).
- A Docker image derived from that Nix expression.

## Ok, that's boring. How do I use it ?

Read on ! You can either use Nix or Docker. Instructions follow.

## Nix Instructions

Nix a purely functional package manager which makes it very easy to specify and
build reproducible environments. It can be installed on MacOS and any Linux
distribution. It installs everything in `/nix/store` (at least by default), and
won't thus pollute your filesystem.

If you don't have Nix yet, you can get it with:

```
$ curl https://nixos.org/nix/install | sh
```

Once that's done, you can either use a temporary `nix-shell`, or permanently
install FloPoCo in your user profile.

### Use a `nix-shell`

Clone this repository, `cd` into it and just type:

```
$ nix-shell
```

This will drop you in a shell with the `flopoco` command available.

### Add it to your user profile

Clone this repository, `cd` into it and just type:

```
$ nix-env -f . -iA flopoco
```

The `flopoco` command will be added to your user profile, and thus always
available after you log in.

## Docker Instructions

If you prefer, you can also use Docker. You can either build the image yourself,
or pull it directly from Docker Hub.

### Build the image yourself

Just type `make` in the cloned repository. This will create (and automatically
load) the Docker image. The last line should read something like this:

```
Loaded image: flopoco:4.1.2
```

### Pull it from DockerHub

Just use:

```
$ docker pull gdeest/flopoco:4.1.2
```

(Or just `gdeest/flopoco` if you want the `latest` version).

### Run it !

You can now run `flopoco` with the following command.

```
$ docker run -v $(pwd):/data flopoco <flopoco arguments>
```

The `-v $(pwd):/data` part instructs Docker to mount current directory at
`/data` in the guest filesystem, which is the working directory of the entry
point command. This will allow FloPoCo to write generated files. For example:

```
$ docker run -v $(pwd):/data flopoco FPDiv wE=8 wF=23
```

will generate a `flopoco.vhdl` file in the directory where it is run.

## TODOs

- Support older FloPoCo versions
- Submit Nix package upstream
