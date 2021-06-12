# coding: utf-8
# frozen_string_literal: false

require 'ffi'
# require 'tree_sitter_ffi_lang/treesit_boss'
# require 'tree_sitter_ffi_lang/treesit_node'
# require 'tree_sitter_ffi_lang/parser'


### try second level wraps with composition not inheritance


module TreeSitterFFILang
# 	extend FFI::Library
# 	ffi_lib ['libtree-sitter-ffi-lang',
# 		'./build/libtree-sitter-ffi-lang.0.0.dylib']
# # 	ffi_lib ['libtree-sitter-ffi-lang.0.0.dylib',
# # 		'./build/libtree-sitter-ffi-lang.0.0.dylib']

# 	typedef :pointer, :blang
# 	
# 	def self.lang(tag)
# 		mod = case tag
# 		when :json then TreeSitterFFILang::TreeSitterJson.parser
# 		when :json then TreeSitterFFILang::TreeSitterRuby.parser
# 		end
# # 		mod.parser
# 	end
# 	
# 	# the entry-point function for each lang seems to be the same its repo.
# 	# (can't find that doc'd anywhere). Oh, and s/-/_/g.
# 	attach_function :tree_sitter_json, [], :blang
# 	attach_function :tree_sitter_ruby, [], :blang
# # 	attach_function :tree_sitter_c, [], :blang
# # 	attach_function :tree_sitter_rust, [], :blang
	
	module JSON
		extend FFI::Library
# 		ffi_lib 'libtree-sitter-ffi-lang.0.0.dylib'
		ffi_lib 'libtree-sitter-ffi-lang'

# 		typedef :pointer, :blang

		attach_function :tree_sitter_json, [], :pointer #:blang
		def self.parser() self.tree_sitter_json end
	end
	
	module Ruby
		extend FFI::Library
		ffi_lib 'libtree-sitter-ffi-lang'

		attach_function :tree_sitter_ruby, [], :pointer
		def self.parser() self.tree_sitter_ruby end
	end
	
	module Bash
		extend FFI::Library
		ffi_lib 'libtree-sitter-ffi-lang'

		attach_function :tree_sitter_bash, [], :pointer
		def self.parser() self.tree_sitter_bash end
	end
	
	module C
		extend FFI::Library
		ffi_lib 'libtree-sitter-ffi-lang'

		attach_function :tree_sitter_c, [], :pointer
		def self.parser() self.tree_sitter_c end
	end
	
	module EmbeddedTemplate
		extend FFI::Library
		ffi_lib 'libtree-sitter-ffi-lang'

		attach_function :tree_sitter_embedded_template, [], :pointer
		def self.parser() self.tree_sitter_embedded_template end
	end
	
	module HTML
		extend FFI::Library
		ffi_lib 'libtree-sitter-ffi-lang'

		attach_function :tree_sitter_html, [], :pointer
		def self.parser() self.tree_sitter_html end
	end
	
	module Java
		extend FFI::Library
		ffi_lib 'libtree-sitter-ffi-lang'

		attach_function :tree_sitter_java, [], :pointer
		def self.parser() self.tree_sitter_java end
	end
	
	module JavaScript
		extend FFI::Library
		ffi_lib 'libtree-sitter-ffi-lang'

		attach_function :tree_sitter_javascript, [], :pointer
		def self.parser() self.tree_sitter_javascript end
	end
	
	module Make
		extend FFI::Library
		ffi_lib 'libtree-sitter-ffi-lang'

		attach_function :tree_sitter_make, [], :pointer
		def self.parser() self.tree_sitter_make end
	end
	
	module Markdown
		extend FFI::Library
		ffi_lib 'libtree-sitter-ffi-lang'

		attach_function :tree_sitter_markdown, [], :pointer
		def self.parser() self.tree_sitter_markdown end
	end
	
	module Rust
		extend FFI::Library
		ffi_lib 'libtree-sitter-ffi-lang'

		attach_function :tree_sitter_rust, [], :pointer
		def self.parser() self.tree_sitter_rust end
	end
	
	module Python
		extend FFI::Library
		ffi_lib 'libtree-sitter-ffi-lang'

		attach_function :tree_sitter_python, [], :pointer
		def self.parser() self.tree_sitter_python end
	end
	

end