#!/usr/bin/env bash
# This script installs required prerequisites for Korifi installation
# Korifi can be easily installed the using the deploy-on-kind.sh script that can be found on Korifi Github repository https://github.com/cloudfoundry/korifi in the scripts folder
# More info on how to install Korifi https://tutorials.cloudfoundry.org/korifi/local-install/
# Script tested for Ubuntu Server 22.04.2 LTS

# Docker installation
# Korifi needs the latest Docker version, what apt provides natively won't work with Korifi (at the time of testing)
# https://docs.docker.com/engine/install/ubuntu/
function docker_install() {
    echo "Installing Docker 🐳"
    sudo install -m 0755 -d /etc/apt/keyrings
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
    sudo chmod a+r /etc/apt/keyrings/docker.gpg

    echo "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" |sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    sudo apt-get update -y
    sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y
}

# Helm installation
# https://helm.sh/docs/intro/install/
function helm_install() {
    echo "Installing helm ⛑"
    curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3
    chmod +x get_helm.sh
    ./get_helm.sh
}

# Kubectl installation
# https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/
function kubectl_install() {
    echo "Installing kubectl 🎛"
    curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
    sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
}

# Kind installation
# https://kind.sigs.k8s.io/docs/user/quick-start/#installation
function kind_install() {
    echo "Installing kind ☺️"
    [ "$(uname -m)" = x86_64 ] && curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.20.0/kind-linux-amd64
    chmod +x ./kind
    sudo mv ./kind /usr/local/bin/kind
}

# cf8 cli installation
# https://docs.cloudfoundry.org/cf-cli/install-go-cli.html
function cf8-cli_install() {
    echo "Installing cf8 cli☁️"
    wget -q -O - https://packages.cloudfoundry.org/debian/cli.cloudfoundry.org.key | sudo apt-key add -
    echo "deb https://packages.cloudfoundry.org/debian stable main" | sudo tee /etc/apt/sources.list.d/cloudfoundry-cli.list
    sudo apt-get update
    sudo apt-get install cf8-cli -y
}

# Go & make installation
# Required to build Korifi
function go_make_install() {
    echo "Installing make & go 🛠"
    sudo apt-get install make -y
    sudo snap install go --classic
}

# kbld installation
# https://carvel.dev/kbld/docs/v0.32.0/install/
function kbld_install() {
    echo "Installing kbld"
    wget -O- https://carvel.dev/install.sh > install.sh
    sudo bash install.sh
}

# Add the current user to the Docker group so that you can interact with the deamon
function add_user_docker_group() {
    sudo usermod -aG docker "$(whoami)"
    newgrp docker
}

function main() {
    docker_install
    helm_install
    kubectl_install
    kind_install
    cf8-cli_install
    go_make_install
    kbld_install
    echo "Installation of prerequisites for Korifi ✅"
    add_user_docker_group # Placed it as the end of the script as newgrp creates a new shell execution environment
}

main
