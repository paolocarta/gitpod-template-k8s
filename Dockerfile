# FROM gitpod/workspace-full

FROM gitpod/workspace-base@sha256:0048b2636ab97828a1ead9e566740504a436d14617610233aaf3a215104c552d

RUN sudo apt-get update -y

# Kubectl
RUN sudo curl -o /usr/bin/kubectl -LO https://dl.k8s.io/release/v1.24.0/bin/linux/amd64/kubectl
RUN sudo chmod +x /usr/bin/kubectl

# Kubectl autocomplete    
RUN echo "source <(kubectl completion bash)" >> ~/.bashrc
RUN echo "alias k=kubectl" >> ~/.bashrc
RUN echo "complete -F __start_kubectl k" >> ~/.bashrc

# Helm
RUN APT_KEY_DONT_WARN_ON_DANGEROUS_USAGE=1 && curl https://baltocdn.com/helm/signing.asc | sudo apt-key add -
RUN DEBIAN_FRONTEND=noninteractive && sudo apt-get install -y --no-install-recommends apt-utils
RUN DEBIAN_FRONTEND=noninteractive && sudo apt-get install apt-transport-https --yes
RUN echo "deb https://baltocdn.com/helm/stable/debian/ all main" | sudo tee /etc/apt/sources.list.d/helm-stable-debian.list
RUN sudo apt-get update
RUN DEBIAN_FRONTEND=noninteractive && sudo apt-get install helm

RUN sudo git clone https://github.com/ahmetb/kubectx /usr/local/kubectx
RUN sudo ln -s /usr/local/kubectx/kubectx /usr/local/bin/kubectx
RUN sudo ln -s /usr/local/kubectx/kubens /usr/local/bin/kubens

RUN mkdir /home/gitpod/.kube
COPY ./config /home/gitpod/.kube/config
RUN sudo chown gitpod /home/gitpod/.kube/config
RUN ls -l