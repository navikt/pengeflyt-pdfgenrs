FROM ghcr.io/navikt/pdfgenrs:0.1.82@sha256:39f02306e2d672883fa1bbaf48ae4c502994f75cfa055f2a178f0332c7b2d5a5

COPY templates /app/templates
COPY fonts /app/fonts
COPY resources /app/resources
COPY resources /app/templates/resources
