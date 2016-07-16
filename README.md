# vagrant-docker-puppet
Example of using vagrant docker provider and puppet for simple node app

# Step 1 - Creating Dockerfile
1. Install Docker on your local laptop
1. Create Dockerfile
1. Build Docker image `docker build -t <your username>/<image name> .`
1. Verify that new image has been created `docker images`
1. Run the Docker image (create new Docker container) `docker run -p 49160:8080 -d --name <container name> <your username>/<image name>`. 
_Running your image with `-d` runs the container in detached mode, 
leaving the container running in the background. The `-p` flag 
redirects a public port to a private port in the container. `--name` flag assigns container name for easy access later on_
1. Verify that that container has been created `docker ps`
1. Verify that node app has been started `docker logs <container name>`. 
1. Test your node app with `curl -i localhost:49160` or open `localhost:49160` in your web browser
1. SSH into running Docker container by `docker exec -i -t <container name> /bin/bash` and verify that files are placed in src folder `ls /src`.
Type `exit` to leave bash.
1. Stop the running Docker container by `docker stop <container name>` and start it with `docker start <container name>`

More details at https://docs.docker.com/v1.10/engine/examples/nodejs_web_app/
