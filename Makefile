CPANEL_DIR=/usr/local/cpanel
UI_DIR=$(CPANEL_DIR)/base/frontend/paper_lantern/migrate_email
SRC_DIR=$(shell pwd)
DOCROOT=/usr/local/cpanel/base/frontend/paper_lantern/migrate_email
DOCROOT_EXISTS=$(shell [ -d $(DOCROOT) ] && echo 1 || echo 0 )

install: directories update
	/scripts/install_plugin $(SRC_DIR)/plugin

directories:
	@mkdir -p $(UI_DIR)

update:
	\cp -f $(SRC_DIR)/plugin/index.html.tt $(UI_DIR)
	\cp -f $(SRC_DIR)/plugin/retrieve-success.html.tt $(UI_DIR)
	\cp -f $(SRC_DIR)/src/MigrateMail.pm /usr/local/cpanel/Cpanel/API
	\cp -f $(SRC_DIR)/plugin/*.tt $(UI_DIR)

create-zip:
	tar czvf plugin.tar.gz plugin
