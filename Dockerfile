FROM ghcr.io/navikt/pdfgenrs:0.1.60@sha256:9e3f4059dcabbd7a607082e92381487b969eb7a049149b6cc0a8f74ba6581773

COPY templates /app/templates
COPY fonts /app/fonts
COPY resources /app/resources
COPY resources /app/templates/resources
