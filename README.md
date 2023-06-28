## Korifi prerequisites installation
This script installs Korifi [prerequisites](https://tutorials.cloudfoundry.org/korifi/local-install/).

Installing Korifi on kind can be easily done by using the `deploy-on-kind.sh` script that can be found on the [CloudFoundry Korifi repo](https://github.com/cloudfoundry/korifi) in the `scripts` directory. 

However, there are still some prerequesites that needs to be installed before you can execute that installation script:
-   [Docker ](https://docs.docker.com/engine/install/): kind uses Docker to run Kubernetes container nodes. 
    
-   [kind](https://kind.sigs.k8s.io/docs/user/quick-start#installation): kind is a tool for running local Kubernetes clusters using Docker container “nodes”. 
    
-   [Helm](https://helm.sh/docs/intro/install/): Helm is a package manager for Kubernetes. Helm is used to install Korifi on a Kubernetes cluster.
    
-   [kubectl](https://kubernetes.io/docs/tasks/tools/): kubectl is the the Kubernetes command-line tool, allowing you to run commands against Kubernetes clusters.
    
-   [cf](https://github.com/cloudfoundry/cli/wiki/V8-CLI-Installation-Guide): cf is the Cloud Foundry command-line tool. 
    
-   [kbld](https://carvel.dev/kbld/): kbld builds and copies the required docker images to the local registry. 

-   [Go](https://go.dev/doc/install): required to install Korifi

This script will install all of the above, it has been tested against a Ubuntu Ubuntu Server 22.04.2 LTS.

More info on how to install and get started with Korifi can be found at this link https://tutorials.cloudfoundry.org/korifi/local-install/