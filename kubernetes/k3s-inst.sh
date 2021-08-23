#!/bin/bash

# advice from https://www.linode.com/docs/guides/how-to-deploy-k3s-on-linode/


#        --disable servicelb \
extra_args=

test -r /tmp/k3s_token || {
	dd if=/dev/random of=/tmp/k3s_token count=1 bs=66
}

test -r /tmp/k3s_token || {
	echo failed to create k3s_token
	exit 1
}

export K3S_TOKEN=$(base64 < /tmp/k3s_token | tr -d '\012')
export K3S_KUBECONFIG_MODE="644"

#NB this only works for one cluster member
# change if you adding more servers or agents
export K3S_NODE_NAME="k3s-server-1"

curl -sfL https://get.k3s.io | bash -s - \
	server \
        --cluster-init \
        --docker \
        --selinux \
        --secrets-encryption \
        --tls-san=troop15shaker.org \
        $extra_args


