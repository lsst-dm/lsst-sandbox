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

The sysadmin of the LSST Sandbox is `T. Andrew Manning <https://lsstc.slack.com/team/UPU070294>`_.

The Kubernetes cluster is `a VM instance <https://radiant.ncsa.illinois.edu/dashboard/project/instances/419c229f-0029-44af-bd1b-309c4254854b/>`_ hosted by the `NCSA Radiant system <https://wiki.ncsa.illinois.edu/pages/viewpage.action?spaceKey=ICI&title=Radiant>`_ in the ``bbdr`` project (ID ``dedb408d1b0a4aa0acdbf08180e4069e``).

The keys required to unseal the Vault are stored as a Kubernetes Secret (``/api/v1/namespaces/vault/secrets/vault-keys``). Anyone with root access to the Radiant VM host OS can copy the ``/etc/rancher/k3s/k3s.yaml`` kubeconfig and control the Kubernetes cluster with admin privileges.
