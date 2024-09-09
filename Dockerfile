FROM opensearchproject/opensearch-dashboards:latest as builder

# Create the directory if it doesn't exist
RUN mkdir -p /usr/share/opensearch-dashboards/config

# Copy the configuration file
COPY opensearch_dashboards.yml /usr/share/opensearch-dashboards/config/opensearch_dashboards.yml

# Install plugins
RUN ./bin/opensearch-dashboards-plugin install https://github.com/openarmor/osd-plugins/releases/download/v1.0.0/openarmor.zip && \
    ./bin/opensearch-dashboards-plugin install https://github.com/openarmor/osd-plugins/releases/download/v1.0.0/openarmorCheckUpdates-4.9.0.zip && \
    ./bin/opensearch-dashboards-plugin install https://github.com/openarmor/osd-plugins/releases/download/v1.0.0/openarmorCore-4.9.0.zip && \
    ./bin/opensearch-dashboards-plugin remove securityDashboards && \
    ./bin/opensearch-dashboards-plugin install https://github.com/openarmor/osd-security-plugin/releases/download/v1.0.0/security-dashboards-2.16.0.0.zip

# Start from a fresh image to reduce size
FROM opensearchproject/opensearch-dashboards:latest

# Copy the configuration and installed plugins from the builder stage
COPY --from=builder /usr/share/opensearch-dashboards /usr/share/opensearch-dashboards

# Use the default entrypoint and CMD from the base image
