Vault
============================

Create a GitHub access token
-------------------------------

To login and access the Vault, [create a personal access token](https://github.com/settings/tokens/new) in your GitHub user settings (you might label it "LSST Sandbox Vault"), selecting only scopes:

* `read:org`
* `read:user`

***WARNING: You must keep your access token secure.***

Open the [Vault GUI](https://vault.lsst-sandbox.ncsa.illinois.edu/), select the GitHub sign in method, and enter your token.

How to create and use secrets
-------------------------------

When you need to create a Kubernetes Secret resource for use in your apps, instead of defining a `Secret` resource directly, you define a `VaultSecret` resource like so:

```
---
apiVersion: ricoberger.de/v1alpha1
kind: VaultSecret
metadata:
  name: my-secret
spec:
  path: kv/lsst-dm/my-app-repo/my-secret
  type: Opaque
```

The `VaultSecret` resource type is a custom resource definition (CRD) created by the Vault Secrets Operator (VSO) that is running on the cluster.

In this example, the repo in which this app Helm chart is defined is `https://github.com/lsst-dm/my-app-repo`, and, by convention, a secret named `my-secret` should be stored in Vault at the path `kv/lsst-dm/my-app-repo/my-secret`.

The next step is to create the secret in Vault. After logging into the [Vault GUI](https://vault.lsst-sandbox.ncsa.illinois.edu/), select `kv/` from the Secrets page and click "Create secret". Enter the path `lsst-dm/my-app-repo/my-secret` and specify the key-value pairs that will populate the Kubernetes Secret resource that will be automatically created by your app via the VSO machinery. Click Save and you should see your app show Healthy and Synced in ArgoCD when the Secret is generated.