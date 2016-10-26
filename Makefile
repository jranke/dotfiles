.PHONY: install
install:
	./install

vimcom:
	if [ ! -e VimCom ]; then git clone https://github.com/jalvesaq/VimCom; fi
	cd VimCom;\
		git checkout v1.2-8;\
		cd ..
	R CMD INSTALL VimCom
