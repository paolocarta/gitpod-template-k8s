# FROM gitpod/workspace-full
FROM gitpod/workspace-base@sha256:0048b2636ab97828a1ead9e566740504a436d14617610233aaf3a215104c552d

RUN mkdir /home/gitpod/.kube
COPY config /home/gitpod/.kube