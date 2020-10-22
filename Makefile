VERSION=0.7

PKG = frost-grub-branding
PREFIX ?= /usr/local
FMODE = -m0644
DMODE = -dm0755

CFG = $(wildcard cfg/*.cfg)

TZ = $(wildcard tz/*)

LOCALES = $(wildcard locales/*)

THEME = \
	$(wildcard artix/*.png) \
	frost/theme.txt \
	frost/u_vga16_16.pf2

ICONS= $(wildcard frost/icons/*.png)


install_live_cfg:
	install $(DMODE) $(DESTDIR)$(PREFIX)/share/grub/cfg
	install $(FMODE) $(CFG) $(DESTDIR)$(PREFIX)/share/grub/cfg

	install $(DMODE) $(DESTDIR)$(PREFIX)/share/grub/tz
	install $(FMODE) $(TZ) $(DESTDIR)$(PREFIX)/share/grub/tz

	install $(DMODE) $(DESTDIR)$(PREFIX)/share/grub/locales
	install $(FMODE) $(LOCALES) $(DESTDIR)$(PREFIX)/share/grub/locales

install_theme:
	install $(DMODE) $(DESTDIR)$(PREFIX)/share/grub/themes/frost
	install $(FMODE) $(THEME) $(DESTDIR)$(PREFIX)/share/grub/themes/frost

	install $(DMODE) $(DESTDIR)$(PREFIX)/share/grub/themes/frost/icons
	install $(FMODE) $(ICONS) $(DESTDIR)$(PREFIX)/share/grub/themes/frost/icons

install: install_live_cfg install_theme

dist:
	git archive --format=tar --prefix=$(PKG)-$(VERSION)/ $(VERSION) | gzip -9 > $(PKG)-$(VERSION).tar.gz
	gpg --detach-sign --use-agent $(PKG)-$(VERSION).tar.gz

.PHONY: install dist
