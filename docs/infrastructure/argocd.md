ArgoCD
==========================

Foundation
-------------------------------------

ArgoCD (https://lsst-sandbox.ncsa.illinois.edu/argo-cd) is installed for both Kubernetes cluster admin deployments of global services and components and for individual developers to use for app development. The ArgoCD applications defined by the admin in the `default` project follow the "[app of apps](https://argo-cd.readthedocs.io/en/stable/operator-manual/declarative-setup/#app-of-apps)" pattern by creating a parent `root` app that includes separately defined apps in a hierarchical way.

Following [this documentation](https://argoproj.github.io/argo-cd/operator-manual/user-management/#dex), GitHub has been added as an identity provider for authentication to the ArgoCD sevice. The [GitHub Oauth application definition](https://github.com/settings/developers) was created through the admin's personal GitHub account. 

App development
-------------------------------------

Members of the `lsst-dm` GitHub organization can use the "Log in via GitHub" button. They have shared access to the `lsst-dm` ArgoCD application project, allowing them to create applications from independent GitHub repositories. The application definitions **must**:

* Reside in a namespace with the prefix `lsst-dm-` (e.g. `lsst-dm-my-app`)
* Reference a git repository within the `lsst-dm` organization namespace on GitHub (i.e. `https://github.com/lsst-dm/*`)

Command line access
-------------------------------------

To use the local [ArgoCD CLI](https://argoproj.github.io/argo-cd/getting_started/#2-download-argo-cd-cli), use the more complex login command, which will open a browser window to complete the GitHub authentication:

```
$ argocd login lsst-sandbox.ncsa.illinois.edu --grpc-web-root-path /argo-cd --sso

Opening browser for authentication
Performing authorization_code flow login: https://lsst-sandbox.ncsa.illinois.edu/argo-cd/api/dex/auth?access_type=offline&client_id=argo-cd-cli&code_challenge=_WcC...xU&code_challenge_method=S256&redirect_uri=http%3A%2F%2Flocalhost%3A8085%2Fauth%2Fcallback&response_type=code&scope=openid+profile+email+groups+offline_access&state=XFlqXMCGVO
Authentication successful
'manninga@illinois.edu' logged in successfully
Context 'lsst-sandbox.ncsa.illinois.edu:443/argo-cd' updated
```
