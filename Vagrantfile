# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  # config.ssh.private_key_path = "~/.ssh/id_rsa"

  config.vm.provider "virtualbox" do |vb|
    # Display the VirtualBox GUI when booting the machine
    vb.gui = true

    # Customize the amount of memory on the VM:
    vb.memory = "6144"
    vb.cpus = "4"
  end

  config.vm.define "win" do |windows|
    windows.vm.box = "gusztavvargadr/visual-studio"
    # windows.vm.box = "senglin/win-10-enterprise-vs2015community"
    # windows.vm.box_version = "1.0.0"

  end

  config.vm.define "win2" do |windows|
    windows.vm.box = "senglin/win-10-enterprise-vs2015community"
    windows.vm.box_version = "1.0.0"
  end

  config.vm.define "osx" do |macos|
    macos.vm.network "private_network", ip: "192.168.33.10"
    # macos.vm.synced_folder ".", "/Users/vagrant/host", type: "rsync", group:"staff", owner: "root"
    macos.vm.synced_folder ".", "/Users/vagrant/host", type: "nfs"
    macos.vm.box = "yzgyyang/macOS-10.14"

    macos.vm.provision "shell", privileged: false, inline: <<-SHELL
      cp /Users/vagrant/host/build_python.sh .
      chmod u+x build_python.sh
      sudo chown vagrant build_python.sh
      ./build_python.sh
    SHELL
  end

  config.vm.define "ubuntu" do |ubuntu|
    ubuntu.vm.box = "bento/ubuntu-16.04"

    ubuntu.vm.provision "shell", inline: <<-SHELL
      apt-get update
      apt-get install -y ubuntu-desktop
      # apt-get install -y software-properties-common
      # sudo add-apt-repository -y ppa:deadsnakes/ppa
      # sudo apt-get update
      # sudo apt-get install -y python3.7
      # sudo apt-get install -y python3-pip
      # # TODO: Set symlink to python3.7 or alias in ~/.bashrc

      # pip install mu-editor
    SHELL
  end

  config.vm.define "ubuntu18" do |ubuntu|
    ubuntu.vm.box = "bento/ubuntu-18.04"

    ubuntu.vm.provision "shell", inline: <<-SHELL
      apt-get update
      apt-get install -y ubuntu-desktop
      # apt-get install -y software-properties-common
      # sudo add-apt-repository -y ppa:deadsnakes/ppa
      # sudo apt-get update
      # sudo apt-get install -y python3.7
      # sudo apt-get install -y python3-pip
      # # TODO: Set symlink to python3.7 or alias in ~/.bashrc

      # pip install mu-editor
    SHELL
  end
end
