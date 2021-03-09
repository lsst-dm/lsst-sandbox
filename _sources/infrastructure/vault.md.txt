Vault
============================

Manually create the `vault` namespace so that the app can deploy.

Initialize and unseal the vault:

```
$ kubectl exec -n vault -it vault-0 -- sh

/ $ vault operator init
Unseal Key 1: yo***Us
Unseal Key 2: Uq***8W
Unseal Key 3: Pm***Hv
Unseal Key 4: 2k***/o
Unseal Key 5: 3t***1f

Initial Root Token: s.N7***NE

Vault initialized with 5 key shares and a key threshold of 3. Please securely
distribute the key shares printed above. When the Vault is re-sealed,
restarted, or stopped, you must supply at least 3 of these keys to unseal it
before it can start servicing requests.

Vault does not store the generated master key. Without at least 3 key to
reconstruct the master key, Vault will remain permanently sealed!

It is possible to generate new unseal keys, provided you have a quorum of
existing unseal keys shares. See "vault operator rekey" for more information.

/ $ vault operator unseal yo***Us 
Key                Value
---                -----
Seal Type          shamir
Initialized        true
Sealed             true
Total Shares       5
Threshold          3
Unseal Progress    1/3
Unseal Nonce       7e44f989-3ee4-cca8-36fb-e6b4691e4c2e
Version            1.5.4
HA Enabled         true

/ $ vault operator unseal Uq***8W
Key                Value
---                -----
Seal Type          shamir
Initialized        true
Sealed             true
Total Shares       5
Threshold          3
Unseal Progress    2/3
Unseal Nonce       7e44f989-3ee4-cca8-36fb-e6b4691e4c2e
Version            1.5.4
HA Enabled         true

/ $ vault operator unseal Pm***Hv
Key             Value
---             -----
Seal Type       shamir
Initialized     true
Sealed          false
Total Shares    5
Threshold       3
Version         1.5.4
Cluster Name    vault-cluster-b7f4fe8f
Cluster ID      e5ea8b90-3781-1ccd-b159-7fd89fdd9aa1
HA Enabled      true
HA Cluster      https://vault-0.vault-internal:8201
HA Mode         active

```

Follow [this guide](https://learn.hashicorp.com/tutorials/vault/getting-started-authentication) to enable GitHub authentication.

```
/ $ vault login s.N***E
Success! You are now authenticated. The token information displayed below
is already stored in the token helper. You do NOT need to run "vault login"
again. Future Vault requests will automatically use this token.

Key                  Value
---                  -----
token                s.N***E
token_accessor       H9***n
token_duration       ∞
token_renewable      false
token_policies       ["root"]
identity_policies    []
policies             ["root"]

/ $ vault auth enable github
Success! Enabled github auth method at: github/

/ $ vault write auth/github/config organization=lsst-dm
Success! Data written to: auth/github/config

```
