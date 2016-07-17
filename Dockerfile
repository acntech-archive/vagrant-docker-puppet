FROM        centos:centos6

MAINTAINER  Ismar Slomic "ismar.slomic@accenture.com"

# Enable Extra Packages for Enterprise Linux (EPEL) for CentOS
RUN         yum install -y epel-release

# Install Node.js and npm
RUN         yum install -y nodejs npm

# Bundle app and Install app dependencies
COPY        /src /src
RUN         cd /src; npm install --production

CMD         ["node", "/src/index.js"]