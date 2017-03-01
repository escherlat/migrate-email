
SRC_DIR=$(shell pwd)
DOCROOT=/usr/local/cpanel/base/frontend/paper_lantern/migrate_email

install: update create-zip
	/scripts/install_plugin $(SRC_DIR)/plugin.tar.gz

update:
	mkdir $(DOCROOT)
	\cp -f $(SRC_DIR)/plugin/index.html.tt $(DOCROOT)
	\cp -f $(SRC_DIR)/plugin/retrieve-success.html.tt $(DOCROOT)
	\cp -f $(SRC_DIR)/src/MigrateMail.pm /usr/local/cpanel/Cpanel/API

create-zip:
	tar czvf plugin.tar.gz plugin
