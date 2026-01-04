FROM registry.access.redhat.com/ubi9 AS ubi-micro-build
COPY files/ca.crt /etc/pki/ca-trust/source/anchors/ipa.crt
RUN update-ca-trust

FROM quay.io/keycloak/keycloak:latest
COPY --from=ubi-micro-build /etc/pki /etc/pki
COPY --chown=keycloak:keycloak --chmod=644 files/cloud-iam-redesign-2.0.6-SNAPSHOT.jar /opt/keycloak/providers/cloud-iam-redesign-2.0.6-SNAPSHOT.jar
ADD  --chown=keycloak:keycloak --chmod=644 https://github.com/keycloakify/keycloakify-starter/releases/download/v11.9.3/keycloak-theme-for-kc-22-to-25.jar /opt/keycloak/providers/keycloakify.jar
