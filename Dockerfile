FROM ghcr.io/navikt/pdfgenrs:1.0.5@sha256:5d62273c428dfa953570c04765fca9e6c8dc11ba9ef8ee20ed0d48f1bf3d46a8

COPY templates /app/templates
COPY fonts /app/fonts
COPY resources /app/resources
COPY resources /app/templates/resources
