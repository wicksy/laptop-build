import pytest

@pytest.mark.parametrize("name, user, group, mode, contains", [
  ("/etc/apt/sources.list.d/docker.list", "root", "root", "0644", "https://apt.dockerproject.org/repo"),
  ("/git", "root", "root", "0755", "null"),
  ("/git/wicksy", "root", "root", "0755", "null"),
  ("/git/wicksy/configfiles", "root", "root", "0755", "null"),
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
  ("/home/wicksy/.vim/syntax/jinja.vim", "wicksy", "wicksy", "0777", "Jinja templat"),
  ("/home/wicksy/.vim/syntax/puppet.vim", "wicksy", "wicksy", "0777", "puppet.vim"),
  ("/home/wicksy/.vim/syntax/dockerfile.vim", "wicksy", "wicksy", "0777", "dockerfile.vim"),
  ("/home/wicksy/.bashrc", "wicksy", "wicksy", "0777", "function _show_git_status"),
  ("/home/wicksy/.gitconfig", "wicksy", "wicksy", "0644", "name = Martin Wicks"),
])

def test_files(File, name, user, group, mode, contains):
  assert File(name).exists
  assert File(name).user == user
  assert File(name).group == group
  assert oct(File(name).mode) == mode
  if File(name).is_directory is not True:
    assert File(name).contains(contains)
  else:
    assert File(name).is_directory