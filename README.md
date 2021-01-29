# Simple Ansible LAB
## **Creating a lab with vagrant and ansible, for hosting a simple web service**

---

### **1. Installing Host Softwares:**

In order to create this simple lab, I will list down the softwares that the **host** machine should have:
1. Vagrant 2.2.6;
2. Virtual Box 6.1.14

To install the hypervisor Virtual Box, folllow installation instructions on their [website](https://www.virtualbox.org/wiki/Linux_Downloads).

For Vagrant, you can use any package manager like **apt** to access the repository. However, it is possible that the Vagrant Repository in you distro (mine is Ubuntu) is outdated, so, just follow the steps bellow (I'm using Ubuntu as an example, but this will work with yum or dnf as well):

```shell
[$] sudo apt update
[$] curl -O https://releases.hashicorp.com/vagrant/2.2.6/vagrant_2.2.6_x86_64.deb
[$] sudo apt install ./vagrant_2.2.6_x86_64.deb
```

### **2. Starting the VMs and Running the Playbook:**

The first step is to start the vms with **up** command:

```shell
[$] vagrant up
```

This will read from the Vagrantfile and execute the instructions. It is important to check the file, mainly the provider section for each node. There, we stablish each machine's resources, like RAM and CPU (in our case the default configuration should sufice, since we only have three vms with 1 CPU and 512 mb RAM each, which is more than enough for our lab. That said, you should adjust it to your needs).

SSH to the control vm, **ubuntu-master** with the following vagrant command:

```shell
[$] vagrant ssh ubuntu-master   
```

You can type *sudo --version* to check if sudo version is updated to 1.9.5p2. The provision running *patch_sudo.sh* script, in Vagrantfile, only updates sudo to a newer release, in order to avoid CVE-2021-3156, a Common Vulnerabilities and Exposures heap-based buffer overflow.

Now, we need to run one last script to setup the environment in this control machine, installing **Ansible** in it and creating a key-pair. Finally, ssh-copy-id to all of our vms. With that, Ansible will be able to comunicate with ease.

```shell
[$] /vagrant/scripts/first_steps.sh
```

After running this script, a file **ok.txt** should be created in the root folder (the vms share this repo root folder with their */vagrant/* folder), containing:

```shell
ubuntu-server | SUCCESS | rc=0 >>
10.0.2.15 192.168.55.101 
ubuntu-database | SUCCESS | rc=0 >>
10.0.2.15 192.168.55.102 
ubuntu-master | SUCCESS | rc=0 >>
10.0.2.15 192.168.55.100 
```

This indicates that the **first_steps.sh** script ran without any major problems.

Now, the last step is to run the playbook.yml utilizing our ./lab/hosts inventory, with the following command:

```shell
[$] ansible-playbook -i /vagrant/lab/hosts -K /vagrant/lab/playbook.yml
```

With that, the roles should be attached to each of the vms, and **apache2** should be running in **ubuntu-server**.

To check it, you can access in your host's browser http://192.168.55.101 to check whether the index.html and node js process are up and running!

## *TODO*:
- [ ] Implement loadbalancer machine (new inventory group "proxy");
- [ ] Implement another ubuntu-server (inventory group "webservers");
- [ ] Create a new **nginx** role with "[$] ansible-galaxy init roles/nginx" for the role balancer;







