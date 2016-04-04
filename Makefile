OPENRESTY_PREFIX=/usr/local/openresty

PREFIX ?=          /usr/local
LUA_INCLUDE_DIR ?= $(PREFIX)/include
LUA_LIB_DIR ?=     $(PREFIX)/lib/lua/$(LUA_VERSION)
INSTALL ?= install
TEST_FILE ?= t

DIRS = fastpbkdf2
BUILDDIRS = $(DIRS:%=build-%)
INSTALLDIRS = $(DIRS:%=install-%)
CLEANDIRS = $(DIRS:%=clean-%)

all: $(BUILDDIRS)
$(DIRS): $(BUILDDIRS)
$(BUILDDIRS):
	$(MAKE) -C $(@:build-%=%)

install: $(INSTALLDIRS) resty-install all
$(INSTALLDIRS):
	$(MAKE) -C $(@:install-%=%) install


clean: $(CLEANDIRS)
$(CLEANDIRS): 
	$(MAKE) -C $(@:clean-%=%) clean


resty-install:
		$(INSTALL) -d $(DESTDIR)/$(LUA_LIB_DIR)/resty
		$(INSTALL) lib/resty/*.lua $(DESTDIR)/$(LUA_LIB_DIR)/resty/
		
.PHONY: subdirs $(DIRS)
.PHONY: subdirs $(BUILDDIRS)
.PHONY: subdirs $(INSTALLDIRS)
.PHONY: subdirs $(CLEANDIRS)
.PHONY: all install clean resty-install
