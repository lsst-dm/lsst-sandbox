Host node provisioning
===========================

Using Radiant project account `bbdr`, I followed the [Radiant instance creation guide](https://wiki.ncsa.illinois.edu/display/ICI/Creating+new+instances#Creatingnewinstances-SecurityGroups) to create a m1.large (4vCPU/8GB) VM.

Installed [k3s](https://k3s.io/) and updated system packages (apt upgrade).

```bash
$ kubectl get node 
NAME           STATUS   ROLES                  AGE    VERSION
lsst-sandbox   Ready    control-plane,master   376d   v1.22.7+k3s1
```
