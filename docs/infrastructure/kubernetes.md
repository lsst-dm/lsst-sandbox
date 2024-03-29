Kubernetes (k3s)
==========================

Rancher
-------------------------------------

The [NCSA Rancher instance](https://gonzo-rancher.ncsa.illinois.edu) was given control of the cluster. People who have been granted access to the cluster [via the Rancher cluster settings](https://gonzo-rancher.ncsa.illinois.edu/dashboard/c/c-tlvqg/manager/provisioning.cattle.io.cluster/fleet-default/c-tlvqg?mode=edit) can download the kubeconfig.

Rancher generates a kubeconfig separate from the one generated by k3s, because it acts as a proxy between the client and k8s cluster. One of the benefits of this configuration is that you do not need to use the NCSA VPN in order to issue `kubectl` commands. The `kubectl` commands referenced in this documentation assume that this kubeconfig has been save locally to somewhere like `$HOME/.kube/lsst-sandbox.kubeconfig` and that prior to `kubectl` command you run `export KUBECONFIG="$HOME/.kube/lsst-sandbox.kubeconfig"`.

Persistent Volumes
-------------------------------------

Install NFS mounting support on the host:

```bash
ubuntu@lsst-sandbox:~$ sudo apt-get install nfs-common
```

Deploy the NFS client provisioner configured to use the NCSA Condo storage system for PVs:

```bash
helm repo add stable https://charts.helm.sh/stable/
helm repo update
cd charts/nfs-condo/
helm dep update
cd ../..
helm upgrade --install --create-namespace --namespace nfs-condo nfs-condo charts/nfs-condo
```

**WARNING**:
  There is a deprecation in Kubernetes v1.20 that prevents the NFS client provisioner from working due to a known issue. Adding the ``feature-gates`` flag to the apiserver allows it to function; however this is not a solution but a workaround. See the **Networking** section for details.
  
Traefik and Networking
-------------------------------------

Email `help+neteng@ncsa.illinois.edu` to request a dedicated domain name and a DNS record pointing to ``lsst-sandbox.ncsa.illinois.edu``.

After k3s is installed and running, modify ``/etc/systemd/system/k3s.service`` to run k3s without deploying Traefik. (Alternatively, initially you can install k3s with the option that disables Traefik.)

```plain
...
ExecStart=/usr/local/bin/k3s \
  server \
  --disable traefik \
  --kube-apiserver-arg feature-gates=RemoveSelfLink=false \
```

Then apply and reload the k3s service:

```bash
ubuntu@lsst-sandbox:~$ sudo systemctl daemon-reload
ubuntu@lsst-sandbox:~$ sudo service k3s restart
```

Deploy the Traefik Helm chart:

```bash
helm repo add traefik https://helm.traefik.io/traefik
helm repo update
cd charts/traefik/
helm dep update
cd ../..
helm upgrade --install --create-namespace --namespace traefik traefik charts/traefik
```
