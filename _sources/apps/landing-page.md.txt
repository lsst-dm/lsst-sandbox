Landing Page
============================

Deploy:
```
helm repo add stable https://charts.helm.sh/stable/
helm repo update
cd charts/landing-page/
helm dep update
cd ../..
helm upgrade --install landing-page charts/landing-page
```