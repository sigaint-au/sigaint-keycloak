FROM registry.access.redhat.com/ubi9 AS ubi-micro-build
COPY files/ca.crt /etc/pki/ca-trust/source/anchors/ipa.crt
RUN update-ca-trust

FROM registry.redhat.io/rhbk/keycloak-rhel9:26.2
COPY --from=ubi-micro-build /etc/pki /etc/pki
ADD --chown=keycloak:keycloak --chmod=644 https://github.com/keycloakify/keycloakify-starter/releases/download/v11.9.3/keycloak-theme-for-kc-22-to-25.jar /opt/keycloak/providers/keycloakify.jar
