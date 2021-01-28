Vagrant.configure("2") do |config|
  servers=[
    {
      :hostname => "ubuntu-server",
      :box => "bento/ubuntu-18.04",
      :ip => "192.168.55.101",
      :ssh_port => '2221'
    },
    {
      :hostname => "ubuntu-database",
      :box => "bento/ubuntu-18.04",
      :ip => "192.168.55.102",
      :ssh_port => '2222'
    },
    {
      :hostname => "ubuntu-master",
      :box => "bento/ubuntu-18.04",
      :ip => "192.168.55.100",
      :ssh_port => '2220'
    }
  ]

  servers.each do |machine|

    config.vm.define machine[:hostname] do |node|
      node.vm.box = machine[:box]
      node.vm.hostname = machine[:hostname]
    
      node.vm.network :private_network, ip: machine[:ip]
      node.vm.network "forwarded_port", guest: 22, host: machine[:ssh_port], id: "ssh"

      node.vm.provider :virtualbox do |v|
        v.customize ["modifyvm", :id, "--memory", 512]
        v.customize ["modifyvm", :id, "--name", machine[:hostname]]
      end
         
      if node.vm.hostname == "ubuntu-master"
        node.trigger.after :up do |trigger|
          trigger.name = "Init Script"
          trigger.info = "Running after vagrant up!"
          trigger.run_remote = {inline: '/vagrant/lab/scripts/first_steps.sh', privileged: false}
        end
      end

    end
  end

end