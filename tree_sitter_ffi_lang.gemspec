# coding: utf-8
# frozen_string_literal: true

require File.expand_path('lib/tree_sitter_ffi_lang/version', __dir__)

Gem::Specification.new do |s|
  s.name = 'tree_sitter_ffi_lang'
  s.version = TreeSitterFFILang::VERSION
  s.date = '2021-05-31'
  s.summary = 'Ruby ffi bindings to a bunch of tree-sitter language parsers'
  s.authors = ['Calicoday']
  s.email = 'calicoday@gmail.com'
  s.licenses = ['MIT']
  s.homepage = 'https://www.github.com/calicoday/ruby-tree-sitter-ffi-lang'

#   s.extensions = ['ext/simple_clipboard/extconf.rb']
  s.files = [
    'lib/tree_sitter_ffi_lang.rb',
    'lib/tree_sitter_ffi_lang/tree_sitter_ffi_lang.rb',
    'lib/tree_sitter_ffi_lang/version.rb'
  ]
  s.require_paths = ['lib']

  s.add_runtime_dependency "ffi", "~> 1.9"

#   s.add_development_dependency "rake", '~> 12.3'
#   s.add_development_dependency "rake-compiler", '~> 1.0'
#   s.add_development_dependency "rspec", '~> 3.8'
end
