# Sealed Secrets

[Overview of Sealed Secrets](https://engineering.bitnami.com/articles/sealed-secrets.html):

>Sealed Secrets are a "one-way" encrypted Secret that can be created by anyone, but can only be decrypted by the controller running in the target cluster. The Sealed Secret is safe to share publicly, upload to git repositories, post to twitter, etc. Once the SealedSecret is safely uploaded to the target Kubernetes cluster, the sealed secrets controller will decrypt it and recover the original Secret.

We chose Sealed Secrets over alternatives like Vault due to its simplicity. As long as an admin downloads the secret key, all secret file manipulation can be performed locally without access to the Kubernetes cluster. Additionally, secrets can be natively version-controlled within the GitOps deployment repo, which increases reproducibility when for example application configurations are stored as secrets.

## How to create sealed secrets

We use a custom script to make generating sealed secrets more convenient. First, construct a YAML file `scripts/secret_generator/secrets/secrets.yaml` where secrets are specified in plaintext following this example:

```yaml
secrets:
- name: argocd-secret
  data: |
    dex.gitlab.clientId: *****
    dex.gitlab.clientSecret: *****
    admin.password: *****
    admin.passwordMtime: *****
    server.secretkey: *****
- name: gitlab-read-api
  data: |
    .dockerconfigjson: |
      {
        "auths": {
          "registry.gitlab.com": {
            "auth": "*****"
          }
        }
      }
```

Run the Sealed Secret generator script

```bash
cd scripts/secret_generator
python3 seal_bulk_secrets.py --file secrets/secrets.yaml 
```

Copy the contents of the desired secret into the Helm chart `secrets.yaml` template file. For example, if the `keel` chart needs a secret `gitlab-read-api`, then append the YAML content of `scripts/secret_generator/sealed-secrets/sealed.gitlab-read-api.secret.yaml` to `charts/keel/templates/secrets.yaml`:

```yaml
---
apiVersion: bitnami.com/v1alpha1
kind: SealedSecret
metadata:
  annotations:
    sealedsecrets.bitnami.com/cluster-wide: "true"
  creationTimestamp: null
  name: gitlab-read-api
spec:
  encryptedData:
    .dockerconfigjson: AgB...+pq1A=
  template:
    data: null
    metadata:
      annotations:
        sealedsecrets.bitnami.com/cluster-wide: "true"
      creationTimestamp: null
      name: gitlab-read-api
    type: Opaque
```

## Master key backup

The master key required to decrypt the Sealed Secrets can be downloaded for backup purposes [following the documentation here](https://github.com/bitnami-labs/sealed-secrets#how-can-i-do-a-backup-of-my-sealedsecrets):

```bash
kubectl get secret -n sealed-secrets \
    -l sealedsecrets.bitnami.com/sealed-secrets-key -o yaml \
    >> sealed-secrets-master-key.yaml
```
