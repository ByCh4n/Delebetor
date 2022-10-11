ROOT	= ""
PREFIX	= $(ROOT)/usr
BINDIR	= $(PREFIX)/bin

install:
	install -m 755 ./Delebetor.sh $(BINDIR)/delebetor

uninstall:
	rm -f $(BINDIR)/delebetor

reinstall:
	rm -f $(BINDIR)/delebetor
	install -m 755 ./delebetor.sh $(BINDIR)/delebetor