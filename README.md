# FastaTools

This is a simple command line utility to deal with FASTA formatted biological sequence collections, inspired by [goalign]() and built in with [bashly]().

The idea is to have very simple operations _(mainly using `awk`)_ so they can be executed on a per sequence basis, eliminating the need to load the whole file in memory. This allows the user to operate on very large FASTA files.

# Installation

This tool is distributed as a shell script. So if you download the `fastatools` script it should work seamlessly on `UNIX` or `MACOS` machines.

# Documentation

For now you can refer to the generated help message by using `fastatools help` or `fastatools \[command\] help` or the [definition file](./src/bashly.yml).
