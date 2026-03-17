# Create ssh-key
ssh-keygen -t ed25519 -C "comment"

# copy public key to remote server
ssh-copy-id -i ~/.ssh/id_ed25519.pub user@remote_host

# create inventory
nvim inventory
------------
192.168.178.36


# /etc/ansible/hosts
ansible-remote-host-01 ansible_ssh_host=192.168.178.33 ansible_user=michel

# ansible syntax check
ansible-playbook --syntax-check first-playbook.yml

# check if tasks are working without excecuting them
ansible-playbook --check first-playbook.yml

# use sudo password for ansible tasks
# https://www.tutorialpedia.org/blog/missing-sudo-password-in-ansible/
ansible-vault create vault.yml

# add to vault.yml
ansible_become_pass: "password"

# use vault in playbook
---
- name: Use sudo password from vault
  hosts: all
  vars_files: 
    - vault.yml
  become: true

# pass the vault to the playbook run command
ansible-playbook playbook.yml --ask-vault-pass

