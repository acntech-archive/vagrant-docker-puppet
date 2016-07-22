# Use node as base Docker image
FROM        node

# Set maintainer of this Docker container
MAINTAINER  Ismar Slomic "ismar.slomic@accenture.com"

# Create new env variable HOME to point to the destination folder in container
ENV         HOME=/srv/www

# Copy package.json file to container and run npm install to install the dependencies
COPY        /src/package.json $HOME/
# Set working directory to HOME for following commands
WORKDIR     $HOME
# Install all dependencies
RUN         npm install

# Copy src files (index.js)
COPY        /src $HOME

# Run the application
CMD         ["node_modules/nodemon/bin/nodemon.js", "index.js"]