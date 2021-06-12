# coding: utf-8
# frozen_string_literal: false

def stamp() puts "+=+=+ " + `date` end
task :stamp do
	stamp
end

desc "=> build_and_install"
task :build => :build_and_install
desc "=> build_and_install"
task :install => :build_and_install

desc "build and install tree_sitter_ffi_lang gem."
task :build_and_install do
	stamp
	puts "build tree_sitter_ffi_lang gem."
	`gem build tree_sitter_ffi_lang.gemspec`
	puts "install tree_sitter_ffi_lang gem."
	`gem install --no-document tree_sitter_ffi_lang-0.0.3.gem` ### gem num!!!
	puts "done."
end
