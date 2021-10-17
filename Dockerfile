# FROM gitpod/workspace-full

FROM gitpod/workspace-base@sha256:0048b2636ab97828a1ead9e566740504a436d14617610233aaf3a215104c552d

RUN sudo apt-get update -y

RUN sudo curl -o /usr/bin/kubectl -LO https://dl.k8s.io/release/v1.22.0/bin/linux/amd64/kubectl
RUN sudo chmod +x /usr/bin/kubectl
      
RUN echo "source <(kubectl completion bash)" >> ~/.bashrc

RUN curl https://baltocdn.com/helm/signing.asc | sudo apt-key add - \
    sudo apt-get install apt-transport-https --yes \
    echo "deb https://baltocdn.com/helm/stable/debian/ all main" | sudo tee /etc/apt/sources.list.d/helm-stable-debian.list \
    sudo apt-get update \
    sudo apt-get install helm

# RUN alias k=kubectl
# RUN complete -F __start_kubectl k

RUN mkdir /home/gitpod/.kube

# COPY config /home/gitpod/.kube
