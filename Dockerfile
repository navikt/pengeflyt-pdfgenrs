FROM ghcr.io/navikt/pdfgenrs:0.1.80@sha256:3cc37ca4dd73216ac399d50deba30a3352af6a1d1913648168088901493fc1b3

COPY templates /app/templates
COPY fonts /app/fonts
COPY resources /app/resources
COPY resources /app/templates/resources
