# Introduction

NOTE: The template and project structure here is almost entirely based up on this: https://github.com/enginyoyen/ansible-best-practises and modified. I highly recommend going through this repo as they recommend a lot of good practices related to ansible. 

```
# Do initial setup 
# This will return you a pip command using which you will have to install required pip packages manually depending on your python environment
./extensions/setup/setup.sh

# Pull in all ansible-galaxy roles or github roles defined in roles/roles_requirements.yml
./extensions/setup/role_update.sh


# Basic Idea

```
This is the directory layout of this repository with explanation.

production.ini            # inventory file for production stage
development.ini           # inventory file for development stage
test.ini                  # inventory file for test stage
vpass                     # ansible-vault password file
                          # This file should not be committed into the repository
                          # therefore file is in ignored by git
group_vars/
    all/                  # variables under this directory belongs all the groups
        apt.yml           # ansible-apt role variable file for all groups
    webservers/           # here we assign variables to webservers groups
        apt.yml           # Each file will correspond to a role i.e. apt.yml
        nginx.yml         # ""
    postgresql/           # here we assign variables to postgresql groups
        postgresql.yml    # Each file will correspond to a role i.e. postgresql
        postgresql-password.yml   # Encrypted password file
plays/
    ansible.cfg           # Ansible.cfg file that holds all ansible config
    webservers.yml        # playbook for webserver tier
    postgresql.yml        # playbook for postgresql tier

roles/
    roles_requirements.yml# All the information about the roles
    external/             # All the roles that are in git or ansible galaxy
                          # Roles that are in roles_requirements.yml file will be downloaded into this directory
    internal/             # All the roles that are not public

extension/
    setup/                 # All the setup files for updating roles and ansible dependencies

``` 

To install any external role from github or ansible-galaxy you will have to define it in `roles/role_requirements.yml` and then run `./extensions/setup/role_update.sh`
