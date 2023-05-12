.PHONY: install
install:
	./install

colorout:
	if [ ! -e colorout ]; then git clone --depth 1 https://github.com/jalvesaq/colorout; fi
	R CMD INSTALL colorout
