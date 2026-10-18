# syntax=docker/dockerfile:1
# Minimal Node-based static server for the helpdesk theme previews.
# Tip: once you have verified a base image, pin it by digest (image@sha256:...).

FROM node:26-alpine
ENV NODE_ENV=production PORT=8080
WORKDIR /app
COPY . .
USER 1000
EXPOSE 8080
HEALTHCHECK --interval=30s --timeout=3s --start-period=10s --retries=3 \
  CMD ["node", "-e", "fetch('http://localhost:8080/healthz').then(r=>process.exit(r.ok?0:1)).catch(()=>process.exit(1))"]
CMD ["node", "server.js"]
