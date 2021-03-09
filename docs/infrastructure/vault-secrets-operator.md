Vault Secrets Operator (VSO)
============================

Prepare the Vault with the policy and token for VSO. Follow the guide at https://github.com/ricoberger/vault-secrets-operator.

Enable key-value secrets (version 2):
```
$ kubectl exec -n vault -it vault-0 -- sh
/ $ vault secrets enable -path=kv -version=2 kv
Success! Enabled the kv secrets engine at: kv/
```

Create a policy allowing VSO to access the secrets at that path:
```
/ $ cat <<EOF | vault policy write vault-secrets-operator -
> path "kv/*" {
>   capabilities = ["read"]
> }
> EOF
Success! Uploaded policy: vault-secrets-operator
```

Generate an access token to be used by the deployed VSO:
```
/ $ vault token create -period=24h -policy=vault-secrets-operator
Key                  Value
---                  -----
token                s.j***V
token_accessor       ZX***cX
token_duration       24h
token_renewable      true
token_policies       ["default" "vault-secrets-operator"]
identity_policies    []
policies             ["default" "vault-secrets-operator"]
```

Generate secret containing the access token and deploy via `kubectl`:
```
export VAULT_TOKEN=s.j***V
export VAULT_TOKEN_LEASE_DURATION=86400

cat <<EOF | kubectl -n vault apply -f -
apiVersion: v1
kind: Secret
metadata:
  name: vault-secrets-operator
  namespace: vault
type: Opaque
data:
  VAULT_TOKEN: $(echo -n "$VAULT_TOKEN" | base64)
  VAULT_TOKEN_LEASE_DURATION: $(echo -n "$VAULT_TOKEN_LEASE_DURATION" | base64)
EOF
```

To allow the users authenticating via GitHub to manage their secrets in a way that VSO can also read, create an additional policy named `lsst-dm`:

```
/ $ cat <<EOF | vault policy write lsst-dm -
path "kv/*" {
  capabilities = ["create", "read", "update", "delete", "list"]
}
```

In the auth methods page (`/ui/vault/settings/auth/configure/github/configuration`), modify the `github` entry to apply this policy. Add the entry `lsst-dm` to the section "Generated Token's Policies".
