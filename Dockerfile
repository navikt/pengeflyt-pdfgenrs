FROM ghcr.io/navikt/pdfgenrs:0.1.54@sha256:151d72451943b6e6dbff6e8ad0de22d5711399e8a3993e362562a53e47d6ff2c

COPY templates /app/templates
COPY fonts /app/fonts
COPY resources /app/resources
COPY resources /app/templates/resources
