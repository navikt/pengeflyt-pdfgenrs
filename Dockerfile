FROM ghcr.io/navikt/pdfgenrs:1.0.14@sha256:f296ff2728e68d868eb49ac668290338240032baf2f71e6ddb93e9fddb48491e

COPY templates /app/templates
COPY fonts /app/fonts
COPY resources /app/resources
COPY resources /app/templates/resources
