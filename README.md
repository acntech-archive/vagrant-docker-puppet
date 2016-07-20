# vagrant-docker-puppet
Example of using [Vagrant](https://www.vagrantup.com/), [Docker](https://www.docker.com/) and [Puppet](https://puppet.com/) for establishing development environment for simple Node app.

Steps below shows how to iterative establish the configurations and existing configuration is updated for each step. 
Link to file revisions are included below (TODO) while step descriptions are more documentation of how to reproduce the process in other examples and scenarios.

Following version has been used in this project:
- Vagrant v1.8.4
- VirtualBox v5.0.24
- Docker v1.12.0-rc4 (on local laptop) and v1.11.2 with Vagrant
- Puppet (TODO)

Im using OSX as host.

This project has been inspired by Activelamp Blog posts:
- [Hasing out docker workflow - Part 1](http://activelamp.com/blog/devops/hashing-out-docker-workflow/)
- [Using Vagrant with a Docker Workflow - Part 2](http://activelamp.com/blog/devops/docker-with-vagrant/)
- [Setting up a Docker development environment with Vagrant - Part 3](http://activelamp.com/blog/devops/local-docker-development-with-vagrant/)
- [Using Jenkins to bake images in a Docker Workflow - Part 4](http://activelamp.com/blog/devops/jenkins-build-docker-images/)

# Step 1 - Creating Dockerfile
1. [Install](https://docs.docker.com/engine/installation/) Docker on your local laptop
1. Create Dockerfile. _See https://docs.docker.com/engine/reference/builder/#dockerfile-reference for more information_
1. Build Docker image `docker build -t <your username>/<image name> .`
1. Verify that new image has been created `docker images`
1. Run the Docker image (create new Docker container) `docker run -p 49160:8080 -d --name <container name> <your username>/<image name>`. 
_Running your image with `-d` runs the container in detached mode, 
leaving the container running in the background. The `-p` flag 
redirects a public port to a private port in the container. `--name` flag assigns container name for easy access later on_
1. Verify that that container has been created `docker ps`
1. Verify that node app has been started `docker logs <container name>`. 
1. Test your node app with `curl -i localhost:49160` or open `localhost:49160` in your web browser. You should see something like:

    ```
    HTTP/1.1 200 OK
    X-Powered-By: Express
    Content-Type: text/html; charset=utf-8
    Content-Length: 12
    Date: Sat, 16 Jul 2016 15:46:54 GMT
    Connection: keep-alive
    
    Hello world
    ```

1. SSH into running Docker container by `docker exec -i -t <container name> /bin/bash` and verify that files are placed in src folder `ls /src`.
Type `exit` to leave bash.
1. Stop the running Docker container by `docker stop <container name>` and start it with `docker start <container name>`

### References
- https://docs.docker.com/engine/understanding-docker/
- https://docs.docker.com/v1.10/engine/examples/nodejs_web_app/ 

# Step 2 - Creating Vagrantfile
1. [Install](https://www.vagrantup.com/downloads.html) Vagrant on your local laptop
1. [Install](https://www.virtualbox.org/wiki/Downloads) VirtualBox on your local laptop
1. Make sure to install Vagrant plugin `vagrant-vbguest` to keep VirtualBox and VirtualBox Guest Additions in sync `vagrant plugin install vagrant-vbguest`
1. Create 2 `Vagrantfiles` (template can be created by `vagrant init`). One vm for [Docker Host](https://www.vagrantup.com/docs/docker/basics.html) (placed in /host folder) and second container for Docker Container (placed in the root folder). 
_Note that Vagrantfile is using Ruby syntax. See https://www.vagrantup.com/docs/vagrantfile/ for more information_
1. Create and configure guest machines according to Vagrantfiles by `vagrant up`. _See https://www.vagrantup.com/docs/cli/ for other Vagrant CLI commands_
1. Verify that Vagrant environments are running correctly by `vagrant global-status --prune`. You should see output like this:
    ```
    id       name    provider   state   directory
    cb02b94  default virtualbox running /Users/ismarslomic/src/vagrant-docker-puppet/host
    8290b77  default docker     running /Users/ismarslomic/src/vagrant-docker-puppet
    ```
    As you can see, we have two environments: first is the Docker Host running inside VirtualBox while second is the Docker Container. Both has `running` state.
1. Test your node app with `curl -i localhost:49161` or open `localhost:49161` in your web browser. You should still see something like:
   
    ```
    HTTP/1.1 200 OK
    X-Powered-By: Express
    Content-Type: text/html; charset=utf-8
    Content-Length: 12
    Date: Sat, 16 Jul 2016 15:46:54 GMT
    Connection: keep-alive
    
    Hello world
    ``` 
1. If you do any changes to `Vagrantfiles` or `Dockerfile` after environment are running (`vagrant up`) you should use `vagrant reload --provision`. The flag `--provision` will make sure to re-run the Docker provision
1. You can shut down running Vagrant machines by using `vagrant halt <machine id>` (machine id can be found by `vagrant global-status`)
1. You can remove running Vagrant machines by using v`agrant destroy -f <machine id>`. _Note that this command will destroy all resources created during creation process, including data inside vm/container_
1. Login into guest machine `docker-host` (by using VirtualBox GUI). Use `vagrant` as username and password. You can also SSH into the machine by running `vagrant ssh <virtualbox machine id>`. 
After you have SSH into Docker Host you can SSH into running Docker Container by `docker exec -i -t <container name> /bin/bash`. Type `exit` to leave bash. 

### References
- https://www.vagrantup.com/docs/getting-started/