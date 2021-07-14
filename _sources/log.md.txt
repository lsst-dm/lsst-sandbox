Log
===========================

2021/07/14
---------------------------

Upgraded to a newer NFS provisioner client.

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
