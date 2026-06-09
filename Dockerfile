FROM ghcr.io/navikt/pdfgenrs:0.1.86@sha256:10d2ce326591aefa6e4c5b273edab0b3e511055da79789b985a7061c5b73aba2

COPY templates /app/templates
COPY fonts /app/fonts
COPY resources /app/resources
COPY resources /app/templates/resources
