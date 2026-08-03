FROM ghcr.io/navikt/pdfgenrs:1.0.20@sha256:1200c5859bdfa3714a90fc6dee7ce3a660fc4410048a53c7661ae3a88e9e80c0

COPY templates /app/templates
COPY fonts /app/fonts
COPY resources /app/resources
COPY resources /app/templates/resources
