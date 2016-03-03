# Ansible
Testing Ansible

Support VAC, VCS, Varnish, Varnish-agent, Vstatdprobe, VHA at the current stage.

The playbook contains these following roles:
 - `vac`
 - `vcs`
 - `varnish-cache`
 - `varnish-agent`
   - required: `-e vac_server=IP/HOSTNAME`
 - `vstatdprobe`
   - required: `-e vcs_server=IP/HOSTNAME`
 - `vha`
   - required: `-e other_vha_node=IP/HOSTNAME`

Here is a list the top YML files to call.
 - `vac.yml`
 - `vcs.yml`
 - `varnish-cache.yml`
 - `varnish-agent.yml`
 - `vstatdprobe.yml`
 - `vha.yml`

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
