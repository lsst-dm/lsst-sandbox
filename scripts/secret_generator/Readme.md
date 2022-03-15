Secret generator
==========================

Export your Hashicorp Vault secrets using 

```sh
$ bash vault_export.sh "kv"
```

This creates a `secrets.yaml` file. Edit the `secrets.yaml` file to add the Kubernetes Secret names you want associated with each secret. For example

```yaml
- path: "kv/apps/discourse/admin"
  name: discourse-admin
  data: |
      { "discourse-password": "*****" }
```

Run the bulk secrets generator to create Sealed Secret manifests for each secret in `secrets.yaml` that contains a `name` mapping.

```sh
$ python3 seal_bulk_secrets.py --file secrets.yaml 
```
