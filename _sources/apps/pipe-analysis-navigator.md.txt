Pipe Analysis Navigator
============================

Build
------------------------
The Pipe Analysis Navigator container image is built automatically by GitHub Actions when a commit modifying the `src/pipe-analysis-navigator` folder is pushed to the `master` branch. See `.github/workflows/build-pipe-analysis-navigator.yaml`. The image consists of a base image that has all the dependencies, and a top-level image that copies in the source code for the application from `src/pipe-analysis-navigator/src`.

Deploy
------------------------
```
helm upgrade --install pipe-analysis-navigator charts/pipe-analysis-navigator
```