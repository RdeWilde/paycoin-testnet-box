PAYCOIND=paycoind
PAYCOINGUI=paycoin-qt
B1_FLAGS=
B2_FLAGS=
B1=-datadir=1 $(B1_FLAGS)
B2=-datadir=2 $(B2_FLAGS)
BLOCKS=1
ADDRESS=
AMOUNT=
ACCOUNT=

start:
	$(PAYCOIND) $(B1) -daemon
	$(PAYCOIND) $(B2) -daemon

start-gui:
	$(PAYCOIND) $(B1) &
	$(PAYCOIND) $(B2) &

generate:
	$(PAYCOIND) $(B1) generate $(BLOCKS)

getinfo:
	$(PAYCOIND) $(B1) getinfo
	$(PAYCOIND) $(B2) getinfo

send:
	$(PAYCOIND) $(B1) sendtoaddress $(ADDRESS) $(AMOUNT)

address:
	$(PAYCOIND) $(B1) getnewaddress $(ACCOUNT)

stop:
	$(PAYCOIND) $(B1) stop
	$(PAYCOIND) $(B2) stop

clean:
	find 1/* -not -name 'server.*' -not -name 'paycoin.conf' -delete
	find 2/* -not -name 'server.*' -not -name 'paycoin.conf' -delete
