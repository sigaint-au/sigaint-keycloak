# Keycloak

Custom keycloak with Sigaint CA embedded and theme.

## Setup
Create the following directories.

```
mkdir  -p /data/keycloak
```

## Run

use the following script
```
podman run -p 8080:8080 \
    --name keycloak \
    -d \
    -v /data/keycloak:/opt/keycloak/data/h2:Z \
        -e KC_BOOTSTRAP_ADMIN_USERNAME=xxxxxxxx \
        -e KC_BOOTSTRAP_ADMIN_PASSWORD=xxxxxxx \
        -e KC_HOSTNAME_STRICT_BACKCHANNEL=false \
        -e KC_HOSTNAME_STRICT_HTTPS=false \
        -e KC_PROXY=edge \
        -e PROXY_ADDRESS_FORWARDING=true \
        -e KC_PROXY_HEADERS=xforwarded \
        -e KC_HTTP_ENABLED=true \
        -e KC_HOSTNAME_STRICT_HTTPS=false \
        -e KC_HOSTNAME_STRICT=false \
        -e KC_HOSTNAME=auth.sigaint.au \
        quay.sigaint.au/sigaint/keycloak:latest start \
                --proxy-headers xforwarded \
                --hostname-strict=false \
        --hostname https://auth.sigaint.au
```

Generate the systemd service.
```
podman generate systemd keycloak >  /etc/systemd/system/keycloak.service
```

# Building
Create build manifest.
```
apiVersion: shipwright.io/v1beta1
kind: Build
metadata:
  name: kaniko-golang-build
spec:
  source:
    type: Git
    git:
      url: https://github.com/sigaint-au/sigaint-keycloak
v  strategy:
    name: buildah
    kind: ClusterBuildStrategy
  output:
    image: quay.sigaint.au/sigaint/keycloak:latest
```