import pytest

@pytest.mark.parametrize("name, enabled, running", [
  ("cron", "enabled", "running"),
  ("docker", "enabled", "running"),
  ("haveged", "enabled", "running"),
  ("ssh", "enabled", "running"),
])

def test_services(Service, name, enabled, running):
  is_enabled = Service(name).is_enabled
  print(is_enabled)
  if enabled == "enabled":
    assert is_enabled
  else:
    assert not is_enabled

  is_running = Service(name).is_running
  print(is_running)
  if running == "running":
    assert is_running
  else:
    assert not is_running

