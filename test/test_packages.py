import pytest

@pytest.mark.parametrize("name", [
  ("apt-file"),
  ("apt-transport-https"),
  ("arandr"),
  ("atom"),
  ("blktrace"),
  ("ca-certificates"),
  ("chromium-browser"),
  ("cowsay"),
  ("cron"),
  ("curl"),
  ("diod"),
  ("docker-ce"),
  ("dropbox"),
  ("fonts-font-awesome"),
  ("git"),
  ("gnupg"),
  ("gnupg2"),
  ("gnupg-agent"),
  ("hardinfo"),
  ("handbrake"),
  ("handbrake-cli"),
  ("haveged"),
  ("htop"),
  ("i3"),
  ("iotop"),
  ("ipython"),
  ("language-pack-en-base"),
  ("laptop-mode-tools"),
  ("nfs-common"),
  ("ntop"),
  ("ntp"),
  ("openssh-client"),
  ("openssh-server"),
  ("openssh-sftp-server"),
  ("openssl"),
  ("pavucontrol"),
  ("pinta"),
  ("pulseaudio"),
  ("pulseaudio-module-x11"),
  ("pulseaudio-utils"),
  ("python"),
  ("python-pip"),
  ("scrot"),
  ("sl"),
  ("software-properties-common"),
  ("suckless-tools"),
  ("sysdig"),
  ("sysstat"),
  ("tree"),
  ("vagrant"),
  ("vim"),
  ("virtualbox"),
  ("vlc"),
  ("wget"),
  ("wireshark"),
  ("whois"),
  ("x264"),
  ("xfce4-terminal"),
  ("xfonts-terminus"),
  ("xinit"),
])

def test_packages(host, name):
  pkg = host.package(name)
  assert pkg.is_installed
