Longhorn
============================

[Longhorn](https://longhorn.io/) is cloud native distributed block storage for Kubernetes, developed by Rancher. It provisions PVCs using locally-mounted storage available to the worker nodes, supporting replication for high availability.

The system is deployed via the official Helm chart as an ArgoCD app. It requires manually creating the `longhorn-system` namespace so that the app can deploy.

The Longhorn interface can be accessed via `kubectl port-forward` (replace `8080` with the desired local port):
```
manninga@darkmatter$ kubectl port-forward -n longhorn-system svc/longhorn-frontend 8080:80
Forwarding from 127.0.0.1:8080 -> 8000
Forwarding from [::1]:8080 -> 8000
```
Open a browser to http://127.0.0.1:8080/#/dashboard to view the Longhorn admin dashboard.
