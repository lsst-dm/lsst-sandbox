Host node provisioning
===========================

Using Radiant project account `bbdr`, I followed the [Radiant instance creation guide](https://wiki.ncsa.illinois.edu/display/ICI/Creating+new+instances#Creatingnewinstances-SecurityGroups) to create a m1.large (4vCPU/8GB) VM.

Installed [k3s](https://k3s.io/) and updated system packages (apt upgrade).

```
manninga@darkmatter$ kubectl get node
NAME           STATUS   ROLES                  AGE   VERSION
lsst-sandbox   Ready    control-plane,master   21m   v1.20.4+k3s1

```
