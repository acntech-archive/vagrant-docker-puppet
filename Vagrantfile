# -*- mode: ruby -*-
# vi: set ft=ruby :

# This Vagrantfile is used for configuring the Docker Containers with Vagrant and must be seen in relation to the
# /host/Vagrantfile configuring the Docker Host
# Maintainer: Ismar Slomic "ismar.slomic@accenture.com"

# Specify Vagrant version and Vagrant API version
Vagrant.require_version ">= 1.6.0"
VAGRANTFILE_API_VERSION = "2"
ENV['VAGRANT_DEFAULT_PROVIDER'] = 'docker'

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  # Disable automatic box update checking. If you disable this, then
  # boxes will only be checked for updates when the user runs
  # `vagrant box outdated`. This is not recommended.
  config.vm.box_check_update = true

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  config.vm.network "forwarded_port", guest: 8080, host: 49160

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.

  # Disable synced folders for the Docker container
  # (prevents an NFS error on "vagrant up")
  config.vm.synced_folder ".", "/vagrant", disabled: true

  config.vm.hostname = "docker-container"

    config.vm.provider "docker" do |docker|
        # Define the location of the Vagrantfile for the host VM
        # Comment out this line to use default host VM that is
        # based on boot2docker
        docker.vagrant_vagrantfile = "host/Vagrantfile"

        # Specify the directory of Dockerfile
        docker.build_dir = "."

        # Specify port mappings, if omitted, no ports are mapped!
        docker.ports = ["8080:49160"]

        # Specify a friendly name for the Docker container
        docker.name = "nodeapp-container"

        # Mount volumes that are available from Docker host (see host/Vagrantfile)
        docker.volumes = ["/ismar-src:/ismar-src"]
    end # config.vm.provider

end # Vagrant.configure
