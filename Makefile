
SRC_DIR=$(shell pwd)

install: update create-zip
	/scripts/install_plugin $(SRC_DIR)/plugin.tar.gz

update:
	\cp -f $(SRC_DIR)/src/MigrateMail.pm /usr/local/cpanel/Cpanel/API

create-zip:
	tar czvf plugin.tar.gz plugin
