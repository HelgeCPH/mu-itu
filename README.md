# MU-ITU


## What is this?

This is an experimental setup to build a standalone application, which encapsulates a complete Python build together with a build of the [mu-editor](http://codewith.mu). Additionally, it includes a shell script wrapping the `python`, `pip`, and `mu-editor` so that a completely encapsulated setup of the tools required for our teaching becomes feasible.

The goal is, to create a one-click installation of the mu-editor and a Python distribution so that students can install a Python setup and corresponding editor with minimal effort and to provide a completely encapsulated Python setup into which students can install new dependencies and which in the worst case can just be destroyed.

The target group of such a setup are students who:

  * own their own computer,
  * are responsible for installing new software onto it,
  * do not have serious system administration skills,
  * have to learn Python programming as well as usage of Bash/Command Prompt during a course
  * have to install new packages at later stages


## How to use it?

Currently, the given sources allow to only build a MacOS version of the editor described above.

To do so, you have to have [vagrant](https://www.vagrantup.com) and [VirtualBox](https://www.virtualbox.org/) installed on your system. Since a MacOS guest system you have to have the corresponding [Extension Pack](https://www.virtualbox.org/wiki/Downloads) installed as well.

```bash
$ vagrant up osx
```

This runs [`build_python.sh`](./build_python.sh) during provisioning.

After it is done, a zipped application archive is accessible at `/Users/vagrant/mu-editor.tar.bz2`

### After

The build editor has to be copied to the `/Applications` folder.

One could ass

## Windows? Linux?

Builds for Windows and Linux are work in progress.