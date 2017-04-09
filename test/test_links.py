import pytest

@pytest.mark.parametrize("name, linked_to", [
  ("/home/wicksy/vagrant/Vagrantfile", "/git/wicksy/configfiles/vagrant/Vagrantfile"),
  ("/home/wicksy/.vimrc", "/git/wicksy/configfiles/dotfiles/.vimrc"),
  ("/home/wicksy/.bashrc", "/git/wicksy/configfiles/dotfiles/.bashrc"),
  ("/home/wicksy/.aws", "/git/wicksy/configfiles/dotfiles/.aws"),
  ("/home/wicksy/.config", "/git/wicksy/configfiles/dotfiles/.config"),
  ("/home/wicksy/.gitconfig", "/git/wicksy/configfiles/dotfiles/.gitconfig"),
  ("/home/wicksy/.ssh/config", "/git/wicksy/configfiles/dotfiles/.ssh/config"),
])

def test_links(File, name, linked_to):
  assert File(name).exists
  assert File(name).is_symlink
  assert File(name).linked_to == str(linked_to)