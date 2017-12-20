import pytest

@pytest.mark.parametrize("name, user, group, mode, contains", [
  ("/etc/apt/sources.list.d/docker.list", "root", "root", "0644", "https://download.docker.com/linux/ubuntu"),
  ("/etc/apt/sources.list.d/draios.list", "root", "root", "0644", "http://download.draios.com/stable/deb"),
  ("/etc/apt/sources.list.d/ppa_launchpad_net_webupd8team_atom_ubuntu.list", "root", "root", "0644", "http://ppa.launchpad.net/webupd8team/atom/ubuntu"),
  ("/git", "wicksy", "wicksy", "0755", "null"),
  ("/git/wicksy", "wicksy", "wicksy", "0755", "null"),
  ("/git/wicksy/configfiles", "wicksy", "wicksy", "0755", "null"),
  ("/git/wicksy/git-semver", "wicksy", "wicksy", "0755", "null"),
  ("/mnt/buffalo", "root", "root", "0755", "null"),
  ("/mnt/samsung", "root", "root", "0755", "null"),
  ("/mnt/ds415plus", "root", "root", "0755", "null"),
  ("/etc/fstab", "root", "root", "0644", "# mount -t nfs ds415plus:"),
  ("/etc/ntp.conf", "root", "root", "0644", "server 0.pool.ntp.org"),
  ("/etc/ssh/sshd_config", "root", "root", "0644", "PermitRootLogin no"),
  ("/home/wicksy/vagrant", "wicksy", "wicksy", "0755", "null"),
  ("/home/wicksy/vagrant/Vagrantfile", "wicksy", "wicksy", "0777", "Vagrant.configure(2) do |config|"),
  ("/home/wicksy/.vim", "wicksy", "wicksy", "0755", "null"),
  ("/home/wicksy/.vimrc", "wicksy", "wicksy", "0777", "filetype plugin indent on"),
  ("/home/wicksy/.vim/bundle/ansible-vim", "wicksy", "wicksy", "0755", "null"),
  ("/home/wicksy/.vim/bundle/dockerfile.vim", "wicksy", "wicksy", "0755", "null"),
  ("/home/wicksy/.vim/bundle/powerline", "wicksy", "wicksy", "0755", "null"),
  ("/home/wicksy/.vim/bundle/python-syntax", "wicksy", "wicksy", "0755", "null"),
  ("/home/wicksy/.vim/bundle/vim-ansible-yaml", "wicksy", "wicksy", "0755", "null"),
  ("/home/wicksy/.vim/bundle/vim-jinja2-syntax", "wicksy", "wicksy", "0755", "null"),
  ("/home/wicksy/.vim/bundle/vim-puppet", "wicksy", "wicksy", "0755", "null"),
  ("/home/wicksy/.vim/bundle/Vundle.vim", "wicksy", "wicksy", "0755", "null"),
  ("/home/wicksy/.bashrc", "wicksy", "wicksy", "0777", "function _show_git_status"),
  ("/home/wicksy/.aws/config", "wicksy", "wicksy", "0644", "region = eu-west-1"),
  ("/home/wicksy/.config/font/config", "wicksy", "wicksy", "0644", "Terminus"),
  ("/home/wicksy/.config/i3/config", "wicksy", "wicksy", "0644", "xfce4-terminal"),
  ("/home/wicksy/.config/xfce4/terminal/terminalrc", "wicksy", "wicksy", "0644", "FontName=Terminus 9"),
  ("/home/wicksy/.ssh/config", "wicksy", "wicksy", "0777", "ServerAliveInterval 60"),
  ("/home/wicksy/.git-semver", "wicksy", "wicksy", "0755", "null"),
  ("/home/wicksy/.git-semver/config", "wicksy", "wicksy", "0644", "UPDATE_CHECK"),
  ("/home/wicksy/.gnupg", "wicksy", "wicksy", "0700", "null"),
  ("/opt/boxcryptor/Boxcryptor_Portable.sh", "root", "root", "0755", "boxcryptor"),
])

def test_files(host, name, user, group, mode, contains):
  file = host.file(name)
  assert file.exists
  assert file.user == user
  assert file.group == group
  assert oct(file.mode) == mode
  if file.is_directory is not True:
    assert file.contains(contains)
  else:
    assert file.is_directory