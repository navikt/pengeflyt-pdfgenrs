FROM ghcr.io/navikt/pdfgenrs:1.0.9@sha256:d427066dcf73ce57e2cc816f1746c315aa0f9c56205eeafee0e7353166229c07

COPY templates /app/templates
COPY fonts /app/fonts
COPY resources /app/resources
COPY resources /app/templates/resources
