FROM ghcr.io/openwallet-foundation/acapy-agent:py3.12-1.1.0

# ========================================================================================================================================
# Install Plugins
# ----------------------------------------------------------------------------------------------------------------------------------------
# Redis PQ
RUN pip install --no-cache-dir git+https://github.com/openwallet-foundation/acapy-plugins.git@main#subdirectory=redis_events
# Firebase Push Notifications
RUN pip install --no-cache-dir git+https://github.com/openwallet-foundation/acapy-plugins.git@main#subdirectory=firebase_push_notifications
# ========================================================================================================================================
