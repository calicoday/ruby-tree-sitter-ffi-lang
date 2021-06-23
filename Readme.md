# ruby-tree-sitter-ffi-lang

`tree_sitter_ffi_lang` is a helper gem to provide language parsers for 
`ruby_tree_sitter_ffi` gem, which provides Ruby bindings to the tree-sitter 
runtime library.

The project has two parts: a dynamic library, `libtree-sitter-ffi-lang`,
of a bunch of language parsers and a gem, `tree_sitter_ffi_lang`, that makes the 
parsers available in Ruby.

If you have installed:

- `ffi` gem
- [tree-sitter](https://github.com/tree-sitter/tree-sitter) runtime library 
- this `libtree-sitter-ffi-lang` library
- this `tree_sitter_ffi_lang` gem 
- [ruby-tree-sitter-ffi](https://github.com/calicoday/ruby-tree-sitter-ffi) gem 

then you should be able to run the demos and specs in the [ruby-tree-sitter-ffi](https://github.com/calicoday/ruby-tree-sitter-ffi)
repo. The `libtree-sitter` and `libtree-sitter-ffi-lang` libraries must be compiled on your system. 


## Make the libtree-sitter-ffi-lang dynamic library

The Makefile logic is cribbed from tree-sitter's own Makefile but changed to use clang++, to accommodate languages that have an external scanner, often in C++. It compiles the
parser (and scanner, if any) in each of the language subdirectories of `./lib`, makes a shared library and installs it where tree-sitter puts `libtree-sitter`. From the project directory:
```
$ make
$ make install
```

## Make the tree-sitter-ffi-lang gem

```
$ rake build
```
builds and installs the ruby-tree-sitter-ffi gem.

## To Do

- more subtle build scheme
- add easy way to wrap new/individual parsers
- use bundler, rubocop
- document this proj as a simple case study of dylib + binding code + ffi gem


## Misc project notes

The language parser code is copied from the appropriate github repo by the script, `./src/pull_parsers.rb`. The script downloads the `./src` directory of the repo for each of the listed languages into `./lib/pull`. 

The build plan for the dynamic library is currently very blunt. In the current tree-sitter language repos I've looked at, most external scanners are C++, so I'm using C++ for all. That means trouble for the javascript and rust scanners, which don't have the functions the parser.c needs access to wrapped with extern "C" (they're already C!). For now, I  have the `./src/pull_parsers.rb` copy scanner.c to scanner.cc, then patch scanner.cc to add extern "C" by hand from the reference version in `./lib/patch/`.

