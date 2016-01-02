# paycoin-testnet-box docker image

# Ubuntu 14.04 LTS (Trusty Tahr)
FROM ubuntu:14.04
MAINTAINER Sean Lavine <lavis88@gmail.com>

# add paycoind from the official PPA
RUN apt-get update
RUN apt-get install --yes software-properties-common
RUN add-apt-repository --yes ppa:paycoin/paycoin
RUN apt-get update

# install paycoind (from PPA) and make
RUN apt-get install --yes paycoind make

# create a non-root user
RUN adduser --disabled-login --gecos "" tester

# run following commands from user's home directory
WORKDIR /home/tester

# copy the testnet-box files into the image
ADD . /home/tester/paycoin-testnet-box

# make tester user own the paycoin-testnet-box
RUN chown -R tester:tester /home/tester/paycoin-testnet-box

# use the tester user when running the image
USER tester

# run commands from inside the testnet-box directory
WORKDIR /home/tester/paycoin-testnet-box

# expose two rpc ports for the nodes to allow outside container access
EXPOSE 19001 19011
CMD ["/bin/bash"]
