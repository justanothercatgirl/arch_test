
INSTALL_DIR = ${HOME}/.local/bin

install: download.sh
	mkdir -p "$(INSTALL_DIR)"
	cp $< $(INSTALL_DIR)/download
	chmod a+x $(INSTALL_DIR)/download
