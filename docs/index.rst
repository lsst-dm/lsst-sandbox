LSST Sandbox
========================================

The LSST Sandbox is a development environment for projects that need a robust means of service deployment with the flexibility afforded by the NCSA Radiant cloud computing platform.

.. toctree::
   :maxdepth: 1
   :caption: Apps
   :glob:

   apps/*

.. toctree::
   :maxdepth: 1
   :caption: Infrastructure
   :glob:

   infrastructure/*

Administration and Support
-------------------------------------------

The sysadmin of the LSST Sandbox is `T. Andrew Manning <https://lsstc.slack.com/team/UPU070294>`_ (`@manning-ncsa:matrix.org <https://matrix.to/#/@manning-ncsa:matrix.org>`_).

The Kubernetes cluster is a VM instance hosted by the `NCSA Radiant system <https://wiki.ncsa.illinois.edu/display/PUBCR/Radiant>`_ in the ``bbdr`` project (ID ``dedb408d1b0a4aa0acdbf08180e4069e``).

Anyone with root access to the Radiant VM host OS can copy the ``/etc/rancher/k3s/k3s.yaml`` kubeconfig and control the Kubernetes cluster with admin privileges.
