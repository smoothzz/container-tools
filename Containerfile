FROM alpine:3.21

RUN apk update && \
    apk add --no-cache doas go git wget curl make vim zsh python3 kubectl ca-certificates aws-cli gcompat jq yq && \
    apk upgrade --no-cache

RUN addgroup -S yodagroup && adduser -S yoda -G yodagroup && \
    echo 'permit nopass yoda' >> /etc/doas.conf

ENV \
    HOME=/home/yoda \
    OCM_VERSION="1.0.5" \
    BACKPLANE_VERSION="0.1.45"

WORKDIR $HOME

RUN sh -c "$(wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)" && \
    curl -skL https://raw.githubusercontent.com/jonmosco/kube-ps1/refs/heads/master/kube-ps1.sh > kube-ps1.sh && \
    cd /usr/local/bin && \
    curl -skL https://github.com/openshift/backplane-cli/releases/download/v${BACKPLANE_VERSION}/ocm-backplane_${BACKPLANE_VERSION}_Linux_x86_64.tar.gz | tar xzvf - ocm-backplane && \
    curl -skL https://mirror.openshift.com/pub/openshift-v4/clients/ocp/stable/openshift-client-linux.tar.gz | tar xzvf - oc && \
    curl -skL https://github.com/openshift-online/ocm-cli/releases/download/v${OCM_VERSION}/ocm-linux-amd64 > ocm && \
    curl -skL https://mirror.openshift.com/pub/openshift-v4/clients/rosa/latest/rosa-linux.tar.gz | tar xzvf - rosa && \
    chmod -R +x /usr/local/bin/ && \
    mkdir -p $HOME/go/bin && \
    mkdir -p $HOME/.config/backplane

COPY zshrc $HOME/.zshrc

RUN chown -R yoda:yodagroup $HOME

USER yoda

ENTRYPOINT ["/bin/zsh"]