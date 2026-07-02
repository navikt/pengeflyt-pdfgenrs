FROM ghcr.io/navikt/pdfgenrs:1.0.10@sha256:211c92d1505ae5c99189a97a754250e8b5393634bfb5f4cb9e4b5ceb501c3154

COPY templates /app/templates
COPY fonts /app/fonts
COPY resources /app/resources
COPY resources /app/templates/resources

ENV REQUEST_BODY_LIMIT_BYTES=8388608
