# hardened-container
Template and SELinux policy for a development container.

It works with VSCode.


# How-TO

- use [udica](https://github.com/containers/udica)  for SELinux policies 
- build a podman image from the template with the necessary libraries, user, etc
- create a container with minimal capabilities
- create a very first restrictive policy with udica
- create a container with everything you need and apply the restrictive policy
- Set SELinux to Permissive and check for denials
- use udica to refine the policy from  the  observed denials 



# Setup

```bash
./create_minimal_container.sh
podman inspect minimal > inspect.json 

udica --full-network-access -j inspect.json devbox
sudo semodule -i devbox.cil /usr/share/udica/templates/{base_container.cil,net_container.cil}

sudo setenforce 0  # permissive
sudo semodule -DB  # to disable the dontaudit (to see also hidden audits)

./create_devbox.sh
tail -f /var/log/audit/audit.log   # see the logs

# do normal work and see what denials pop up. put them in a file

podman stop devbox
podman rm devbox

# Improve the policy with Udica using the denials. You can give all denials it is smart enough to match it to the policy
# NOTE: policy name must be the same (devbox)
udica --full-network-access -j inspect.json --append-rules denials.file devbox

# update the policy
sudo semodule -i devbox.cil /usr/share/udica/templates/{base_container.cil,net_container.cil}

sudo setenforce 1  # enforced
sudo semodule -B   # set back dontaudit

./create_devbox.sh

# check that everything works, if not repeat.

```

# How to disable/enable SELinux and Check for denials

```bash
sudo setenforce 0  # permissive
sudo semodule -DB  # to disable the dontaudit (to see also hidden audits)

tail -f /var/log/audit/audit.log   # see the logs

sudo semodule -B   # set back dontaudit
sudo setenforce 1  # enforced

```
