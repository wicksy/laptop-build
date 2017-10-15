import pytest

@pytest.mark.parametrize("name, linked_to", [
  ("/home/wicksy/vagrant/Vagrantfile", "/git/wicksy/configfiles/vagrant/Vagrantfile"),
  ("/home/wicksy/.vimrc", "/git/wicksy/configfiles/dotfiles/.vimrc"),
  ("/home/wicksy/.bashrc", "/git/wicksy/configfiles/dotfiles/.bashrc"),
  ("/home/wicksy/.aws", "/git/wicksy/configfiles/dotfiles/.aws"),
  ("/home/wicksy/.config", "/git/wicksy/configfiles/dotfiles/.config"),
  ("/home/wicksy/.gitconfig", "/git/wicksy/configfiles/dotfiles/.gitconfig"),
  ("/home/wicksy/.ssh/config", "/git/wicksy/configfiles/dotfiles/.ssh/config"),
  ("/usr/local/bin/git-semver", "/git/wicksy/git-semver/git-semver.sh"),
])

def test_links(host, name, linked_to):
  file = host.file(name)
  assert file.exists
  assert file.is_symlink
  assert file.linked_to == str(linked_to)