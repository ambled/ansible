# Ansible
Testing Ansible

Support VAC, VCS, Varnish, Varnish-agent, Vstatdprobe, VHA at the current stage.

The playbook contains these following roles:
 - vac
 - vcs
 - varnish-cache
 - varnish-agent
   - required: -e vac_server=IP/HOSTNAME
 - vstatdprobe
   - required: -e vcs_server=IP/HOSTNAME
 - vha
   - required: -e other_vha_node=IP/HOSTNAME
 
There are alias starting point YML files. Just for convenience.
 - vac-vcs
   - roles: vac,vcs
 - vcp
   - roles: varnish-cache, varnish-agent, vstatdprobe
 - vcp-vha
   - roles: varnish-cache, varnish-agent, vstatdprobe, vha
