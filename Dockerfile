# paycoin-testnet-box docker image

# Ubuntu 14.04 LTS (Trusty Tahr)
FROM ubuntu:15.04
MAINTAINER Robert de Wilde <rdewildenl@gmail.com>

# add paycoin
RUN apt-get update
RUN apt-get install software-properties-common python-software-properties unzip ufw curl wget sed grep cron -y

# create a non-root user
RUN adduser --disabled-login --gecos "" tester

# run following commands from user's home directory
WORKDIR /home/tester

RUN cd /home/tester
RUN echo "### Downloading Paycoin Core $(curl -s https://api.github.com/repos/PaycoinFoundation/Paycoin/releases/latest | grep 'tag_' | cut -d\" -f4)"
RUN curl -# -C - -L -k -o linux64.zip "$(curl -s https://api.github.com/repos/PaycoinFoundation/Paycoin/releases/latest | grep 'browser_' | cut -d\" -f4 | grep 'linux64.zip')"
RUN unzip linux64.zip
RUN rm -f -r linux64.zip

ENV PATH /home/tester:$PATH

# copy the testnet-box files into the image
ADD . /home/tester/paycoin-testnet-box

# make tester user own the paycoin-testnet-box
RUN chown -R tester:tester /home/tester/*

# use the tester user when running the image
USER tester

# run commands from inside the testnet-box directory
WORKDIR /home/tester/paycoin-testnet-box


# expose two rpc ports for the nodes to allow outside container access
EXPOSE 19001 19011
CMD ["/bin/bash"]
