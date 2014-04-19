VAGRANTFILE_API_VERSION = "2"

BASE_PATH = File.expand_path(File.dirname(__FILE__))
CONFIG_FILE = File.join(BASE_PATH, 'config.sh')

def get_config_script
  if File.exists?(CONFIG_FILE)
    config = File.open(CONFIG_FILE) { |f| f.read }
  end
end

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = 'precise64'
  config.vm.box_url = 'http://files.vagrantup.com/precise64.box'

  config.vm.network :forwarded_port, guest: 3000, host: 3000

  config.vm.provision :shell do |s|
    s.path = File.join(BASE_PATH, 'install-server.sh')
    s.args = "'#{get_config_script}'"
  end
end
