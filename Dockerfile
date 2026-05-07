FROM ghcr.io/navikt/pdfgenrs:0.1.35@sha256:49dd2b54bd3f48c1959ee611edb0e7ae54300824b2abae4d5413f9abb9b6ba74

COPY templates /app/templates
COPY fonts /app/fonts
COPY resources /app/resources
