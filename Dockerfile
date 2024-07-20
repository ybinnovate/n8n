FROM n8nio/n8n:latest

USER root

# Install global npm packages
RUN npm install -g youtube-captions-scraper pdf-parse mammoth csv-parser ffmpeg.js

USER node

# Set PostgreSQL environment variables
ARG PGPASSWORD
ARG PGHOST
ARG PGPORT
ARG PGDATABASE
ARG PGUSER
ENV DB_TYPE=postgresdb
ENV DB_POSTGRESDB_DATABASE=$PGDATABASE
ENV DB_POSTGRESDB_HOST=$PGHOST
ENV DB_POSTGRESDB_PORT=$PGPORT
ENV DB_POSTGRESDB_USER=$PGUSER
ENV DB_POSTGRESDB_PASSWORD=$PGPASSWORD

# Set encryption key
ARG ENCRYPTION_KEY
ENV N8N_ENCRYPTION_KEY=$ENCRYPTION_KEY

WORKDIR /home/nodes/

# Install additional n8n nodes
RUN npm install n8n-nodes-browserless
RUN npm install n8n-nodes-yaml
RUN npm install n8n-nodes-youtube-transcript

CMD ["n8n", "start"]
