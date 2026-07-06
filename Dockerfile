FROM ghcr.io/navikt/pdfgenrs:1.0.12@sha256:d1dabcba7a97b080ecaacf973cd3baae5901a7239d4e71805f74ad4c40d2b016

COPY templates /app/templates
COPY fonts /app/fonts
COPY resources /app/resources
COPY resources /app/templates/resources

ENV REQUEST_BODY_LIMIT_BYTES=8388608
