# Use node as base Docker image
FROM        node

# Set maintainer of this Docker container
MAINTAINER  Ismar Slomic "ismar.slomic@accenture.com"

# Add new user 'nodeapp' for installing dependecies and running node app
RUN useradd --user-group --create-home --shell /bin/false nodeapp

# Create new env variable HOME to point to the destination folder in container
ENV         HOME=/srv
ENV         WWW=$HOME/www

# Copy package.json file to container and run npm install to install the dependencies
COPY        /src/package.json $WWW/
# Make sure nodeapp user has access to the copied files
RUN         chown -R nodeapp:nodeapp $HOME

# Change user to nodeapp, before installing dependencies
USER        nodeapp
# Set working directory to HOME for following commands
WORKDIR     $WWW
# Install all dependencies
RUN         npm install

# Change user to root before copying rest of src files
USER        root
# Copy src files (index.js)
COPY        /src $WWW
# Make sure nodeapp user has access to the copied files
RUN         chown -R nodeapp:nodeapp $HOME
# Change user to nodeapp, before running the node app
USER        nodeapp

# Run the application
CMD         ["node_modules/nodemon/bin/nodemon.js", "index.js"]