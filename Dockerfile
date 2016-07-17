# Specify the base image
FROM        centos:centos6

# Set maintainer of this Docker container
MAINTAINER  Ismar Slomic "ismar.slomic@accenture.com"

# Enable Extra Packages for Enterprise Linux (EPEL) for CentOS
RUN         yum install -y epel-release

# Install Node.js and npm
RUN         yum install -y nodejs npm

# Bundle app and Install app dependencies
COPY        /src /src
RUN         cd /src; npm install --production

# Start node js process and index.js
CMD         ["node", "/src/index.js"]