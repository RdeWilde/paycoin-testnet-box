PAYCOIND=paycoind
PAYCOINGUI=paycoin-qt
PAYCOINCLI=paycoin-cli
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
	$(PAYCOINGUI) $(B1) &
	$(PAYCOINGUI) $(B2) &

generate:
	$(PAYCOINCLI) $(B1) generate $(BLOCKS)

getinfo:
	$(PAYCOINCLI) $(B1) getinfo
	$(PAYCOINCLI) $(B2) getinfo

send:
	$(PAYCOINCLI) $(B1) sendtoaddress $(ADDRESS) $(AMOUNT)

address:
	$(PAYCOINCLI) $(B1) getnewaddress $(ACCOUNT)

stop:
	$(PAYCOINCLI) $(B1) stop
	$(PAYCOINCLI) $(B2) stop

clean:
	find 1/regtest/* -not -name 'server.*' -delete
	find 2/regtest/* -not -name 'server.*' -delete
