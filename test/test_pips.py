import pytest

@pytest.mark.parametrize("name", [
  ("awscli"),
  ("boto3"),
  ("docker-py"),
  ("GitPython"),
  ("mkdocs"),
  ("pep8"),
  ("virtualenv"),
  ("virtualenvwrapper"),
])

def test_pips(host, name):
  assert name in host.pip_package.get_packages()