FROM registry.access.redhat.com/ubi9 AS ubi-micro-build
COPY files/ca.crt /etc/pki/ca-trust/source/anchors/ipa.crt
COPY files/cloud-iam-redesign-2.0.6-SNAPSHOT.jar /opt/keycloak/providers/cloud-iam-redesign-2.0.6-SNAPSHOT.jar`
RUN update-ca-trust

FROM quay.io/keycloak/keycloak:latest
COPY --from=ubi-micro-build /etc/pki /etc/pki
