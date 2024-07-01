# Use the official Arch Linux image from the Docker Hub
FROM archlinux:latest

# Install necessary packages
RUN pacman -Syu --noconfirm \
  && pacman -S --noconfirm sudo ansible openssh

# Create a non-root user (optional)
RUN useradd -m -s /bin/bash ansibleuser \
  && echo 'ansibleuser:password' | chpasswd \
  && echo 'ansibleuser ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

USER ansibleuser
WORKDIR /home/ansibleuser

# Copy the SSH directory to the container (optional, for testing purposes)
COPY . /home/ansibleuser/ansible
# CMD ["sh", "-c", "cd ansible && ./ansible-run.bash"]
# CMD ["sh", "-c", "ansible-playbook playbooks/local.yml"]
