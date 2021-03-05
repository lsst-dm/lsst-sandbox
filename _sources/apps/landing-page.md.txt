Landing Page
============================

Build
------------------------
The landing page container image is built automatically by GitHub Actions when a commit modifying the `src/landing-page` folder is pushed to the `master` branch. See `.github/workflows/build-landing-page.yaml`.

Deploy
------------------------
```
helm repo add stable https://charts.helm.sh/stable/
helm repo update
cd charts/landing-page/
helm dep update
cd ../..
helm upgrade --install landing-page charts/landing-page
```