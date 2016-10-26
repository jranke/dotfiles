.PHONY: install
install:
	./install

vimcom:
	git clone --depth=1 https://github.com/jalvesaq/VimCom
	R CMD INSTALL VimCom
