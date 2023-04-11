FROM alpine:3.17

ENV kustomize_version="v5.0.1"
ENV PYTHONUNBUFFERED=1

# Install python3 block
RUN apk add --update --no-cache python3 curl \
    && ln -sf python3 /usr/bin/python \
    && python3 -m ensurepip
RUN pip3 install --no-cache --upgrade pip setuptools kubernetes-validate

# install kustomize
RUN curl -L --output /tmp/kustomize_${kustomize_version}_linux_amd64.tar.gz https://github.com/kubernetes-sigs/kustomize/releases/download/kustomize%2F${kustomize_version}/kustomize_${kustomize_version}_linux_amd64.tar.gz \
    && echo "dca623b36aef84fbdf28f79d02e9b3705ff641424ac1f872d5420dadb12fb78d  /tmp/kustomize_${kustomize_version}_linux_amd64.tar.gz" | sha256sum -c \
    $$ tar -xvzf /tmp/kustomize_${kustomize_version}_linux_amd64.tar.gz -C /usr/local/bin \
    && chmod +x /usr/local/bin/kustomize

# You should add folder to /k8s
COPY verify.sh /

USER kustomize
WORKDIR /src