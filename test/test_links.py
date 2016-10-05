import pytest

@pytest.mark.parametrize("name, linked_to", [
  ("/home/wicksy/vagrant/Vagrantfile", "/git/wicksy/configfiles/vagrant/Vagrantfile"),
  ("/home/wicksy/.vimrc", "/git/wicksy/configfiles/dotfiles/.vimrc"),
  ("/home/wicksy/.bashrc", "/git/wicksy/configfiles/dotfiles/.bashrc"),
])

def test_links(File, name, linked_to):
  assert File(name).exists
  assert File(name).is_symlink
  assert File(name).linked_to == str(linked_to)