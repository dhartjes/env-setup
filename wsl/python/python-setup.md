# Python setup

## Normal setup

### Standard Installation

```bash
sudo apt update
sudo apt upgrade
sudo apt install python3
sudo apt install python3-pip
sudo apt install python3-dev python3-venv build-essential
```

### Troubleshooting

sudo rm /var/lib/apt/lists/lock
sudo rm /var/cache/apt/archives/lock

## For more fiddliness, use a version manager to install python instead

### Pyenv Installation

```bash
sudo apt install -y build-essential libssl-dev zlib1g-dev libsqlite3-dev libffi-dev
curl https://pyenv.run/ | bash
```

### Configuration

```bash
# configure shell via bashrc
echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.bashrc
echo 'command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.bashrc
echo 'eval "$(pyenv init -)"' >> ~/.bashrc

# activates new shell configuration
source ~/.bashrc

# configure a global default
pyenv global <version>

# configure a version for a specific project
pyenv local <version>
```

### Utilization

```bash
pyenv install --list
pyenv install -v 3.13.1
```

### Pyenv Troubleshooting

```bash
# Build failures?
CFLAGS="-02" pyenv install 3.12.1

# SSL related errors?
sudo apt install libssl-dev
```

## Test

```bash
python --version
```

## Source

- [Python installation](https://www.geeksforgeeks.org/python/how-to-install-python-on-linux/)
