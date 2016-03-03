# Ansible
Testing Ansible

This is a collection of Ansible Playbook for experimenting Varnish Plus Products. It currently supports VAC, VCS, Varnish, Varnish-agent, Vstatdprobe, VHA at the current stage.

Here is a list the top YML files to be called.
 - `vac.yml`
   - roles:
     - `vac`
 - `vcs.yml`
   - roles:
     - `vcs`
 - `varnish-cache.yml`
   - roles:
     - `varnish-cache`
 - `varnish-agent.yml`
   - roles:
     - `varnish-agent`
       - required: `-e vac_server=IP/HOSTNAME`
 - `vstatdprobe.yml`
   - roles:
     - `vstatdprobe`
       - required: `-e vcs_server=IP/HOSTNAME`
 - `vha.yml`
   - roles:
     - `vha`
       - required: `-e other_vha_node=IP/HOSTNAME`

There are also a serveral alias YML files to run some roles at once. Just for convenience.
 - `vac-vcs.yml`
   - roles: 
     - `vac`
     - `vcs`
 - `vcp`
   - roles:
     - `varnish-cache`
     - `varnish-agent`
     - `vstatdprobe`
 - `vcp-vha`
   - roles:
     - `varnish-cache`
     - `varnish-agent`
     - `vstatdprobe`
     - `vha`

To run the playbook, you run it by `ansible-playbook /path/to/YML/file.yml` and then pass required varibles `-e` or scope down your target hosts with `-l` regarding your ansible hosts file `/etc/ansible/hosts`.

```
# for example
# /etc/ansible/hosts
[cache-servers]
10.0.0.1
10.0.0.2
[vac]
10.0.0.100

# on terminal
$ ansible-playbook /root/ansible-repo/vcp.yml -l cache-servers -e vac_server=10.0.1.100 -e vcs_server=10.0.1.100
```
