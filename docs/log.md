Log
===========================

2022/03/15
---------------------------

* Deleted the Pipetask Plot Navigator after discussion with stakeholders.

* Replaced the Vault system with Sealed Secrets, migrating the TIM public interface Syncthing config secret to SealedSecret kind.

* Added ArgoCD as an ArgoCD app so it can manage itself.

* Removed the `lsst-dm` AppProject and migrated the TIM to the `default` project.

* Upgraded k3s to `v1.22.7+k3s1`:

  ```bash
  ubuntu@lsst-sandbox:~$ sudo curl -sfL https://get.k3s.io | sh -
  [INFO]  Finding release for channel stable
  [INFO]  Using v1.22.7+k3s1 as release
  [INFO]  Downloading hash https://github.com/k3s-io/k3s/releases/download/v1.22.7+k3s1/sha256sum-amd64.txt
  [INFO]  Downloading binary https://github.com/k3s-io/k3s/releases/download/v1.22.7+k3s1/k3s
  [INFO]  Verifying binary download
  [INFO]  Installing k3s to /usr/local/bin/k3s
  [INFO]  Skipping installation of SELinux RPM
  [INFO]  Skipping /usr/local/bin/kubectl symlink to k3s, already exists
  [INFO]  Skipping /usr/local/bin/crictl symlink to k3s, already exists
  [INFO]  Skipping /usr/local/bin/ctr symlink to k3s, already exists
  [INFO]  Creating killall script /usr/local/bin/k3s-killall.sh
  [INFO]  Creating uninstall script /usr/local/bin/k3s-uninstall.sh
  [INFO]  env: Creating environment file /etc/systemd/system/k3s.service.env
  [INFO]  systemd: Creating service file /etc/systemd/system/k3s.service
  [INFO]  systemd: Enabling k3s unit
  Created symlink /etc/systemd/system/multi-user.target.wants/k3s.service → /etc/systemd/system/k3s.service.
  [INFO]  systemd: Starting k3s
  ```


2021/07/14
---------------------------

Upgraded to a newer NFS provisioner client.

Installed Longhorn. Set default replicas to 1 by directly editing the StorageClass via kubectl.

Migrated the Vault to longhorn instead of nfs-condo to avoid crashes due to Radiant's NFS-based Condo storage system instabilities. There were only a handful of secrets so these were recreated manually instead of using the more complex process of mounting the longhorn and nfs-condo PVCs in the same container and copying over the original Vault data files.


2020/03/08
---------------------------

Deployed ArgoCD (https://lsst-sandbox.ncsa.illinois.edu/argo-cd) and converted the landing page and pipe-analysis-navigator deployments to ArgoCD apps, following the "app of apps" pattern by creating a parent `root` app. 

Enabled GitHub authentication for the `lsst-dm` organization following [this documentation](https://argoproj.github.io/argo-cd/operator-manual/user-management/#dex). The [GitHub Oauth application definition](https://github.com/settings/developers) was created through my `manning-ncsa` GitHub account. Users logging in via GitHub do not see the applications deployed under the `admin` account.

2020/03/05
---------------------------

Saved a VM snapshot as `k3s-ubuntu-20.04-20210305`.

2020/03/04
---------------------------

Radiant VM creation and k3s installation.

Emailed `help+neteng@ncsa.illinois.edu` to obtain a dedicated domain name and a DNS record pointing to ``lsst-sandbox.ncsa.illinois.edu``.
