# copy tree-sitter language parsers and generate a makefile to compile them.

langs = {
	json: "https://github.com/tree-sitter/tree-sitter-json",
	bash: "https://github.com/tree-sitter/tree-sitter-bash",
	c: "https://github.com/tree-sitter/tree-sitter-c",
# 	csharp: "https://github.com/tree-sitter/tree-sitter-c-sharp",
# 	cpp: "https://github.com/tree-sitter/tree-sitter-cpp",
# 	css: "https://github.com/tree-sitter/tree-sitter-css",
# 	elm: "https://github.com/elm-tooling/tree-sitter-elm",
# 	eno: "https://github.com/eno-lang/tree-sitter-eno",
	embedded_template: "https://github.com/tree-sitter/tree-sitter-embedded-template",
# 	fennel: "https://github.com/travonted/tree-sitter-fennel",
# 	go: "https://github.com/tree-sitter/tree-sitter-go",
	html: "https://github.com/tree-sitter/tree-sitter-html",
	java: "https://github.com/tree-sitter/tree-sitter-java",
	javascript: "https://github.com/tree-sitter/tree-sitter-javascript",
# 	lua: "https://github.com/Azganoth/tree-sitter-lua",
	make: "https://github.com/alemuller/tree-sitter-make",
	markdown: "https://github.com/ikatyang/tree-sitter-markdown",
# 	ocaml: "https://github.com/tree-sitter/tree-sitter-ocaml",
# 	php: "https://github.com/tree-sitter/tree-sitter-php",
	python: "https://github.com/tree-sitter/tree-sitter-python",
	ruby: "https://github.com/tree-sitter/tree-sitter-ruby",
	rust: "https://github.com/tree-sitter/tree-sitter-rust",
# 	r: "https://github.com/r-lib/tree-sitter-r",
# 	sexpressions: "https://github.com/AbstractMachinesLab/tree-sitter-sexp",
# 	sparql: "https://github.com/BonaBeavis/tree-sitter-sparql",
# 	systemrdl: "https://github.com/SystemRDL/tree-sitter-systemrdl",
# 	svelte: "https://github.com/Himujjal/tree-sitter-svelte",
# 	toml: "https://github.com/ikatyang/tree-sitter-toml",
# 	turtle: "https://github.com/BonaBeavis/tree-sitter-turtle",
# 	typescript: "https://github.com/tree-sitter/tree-sitter-typescript",
# 	verilog: "https://github.com/tree-sitter/tree-sitter-verilog",
# 	vhdl: "https://github.com/alemuller/tree-sitter-vhdl",
# 	vue: "https://github.com/ikatyang/tree-sitter-vue",
# 	yaml: "https://github.com/ikatyang/tree-sitter-yaml",
# 	wasm: "https://github.com/wasm-lsp/tree-sitter-wasm",
	}

outdir = './lib/pull'
if Dir.exists?(outdir)
	unless Dir.empty?(outdir)
		puts "#{outdir} dir has stuff in it. exitting."
		exit 0
	end
else
	Dir.mkdir(outdir)
end

# Pulled scanner.c for rust and javascript needs to be scanner.cc and have 
# extern "C" around the 6 functions: tree_sitter_rust_external_scanner_create,
# _destroy, _reset, _serialize, _deserialize and _scan.
# 
# Also, all .c files get clang warning:
#  clang: warning: treating 'c' input as 'c++' when in C++ mode, this behavior is deprecated [-Wdeprecated]
# Suppress???

puts "Pulling language parsers..."

# {json: "https://github.com/tree-sitter/tree-sitter-json",
# make: "https://github.com/alemuller/tree-sitter-make"}.each do |k, v|
langs.each do |k, v|
	puts "#{k}: #{v}"
	target = outdir + "/#{k}"
	Dir.mkdir(target)
	`cd #{target}; svn checkout #{v}/trunk/src`
end

puts "Copy each scanner.c to scanner.cc for patching..."

# only do the specific langs we know need it for now
["javascript", "rust"].each do |lang|
	path = Dir.glob(outdir + "/#{lang}/src/scanner.c").first
	raise "#{lang} no scanner.c!!! (#{path})" unless path
	filename = path.split('/').last
	puts "#{lang}..."
	puts "  (#{path})"
	puts "  cp scanner.c to scanner.cc (check for extern \"C\")"
	`cp #{path} "#{path}c"`
end
	
puts "done."
