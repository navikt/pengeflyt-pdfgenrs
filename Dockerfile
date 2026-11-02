FROM ghcr.io/navikt/pdfgenrs:1.0.48@sha256:8e8a28d532fd6350d99263b099b9afc04cafb534b281634b6dd8b3652f8e2bad

COPY templates /app/templates
COPY fonts /app/fonts
COPY resources /app/resources
COPY resources /app/templates/resources
