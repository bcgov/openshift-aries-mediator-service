FROM ghcr.io/hyperledger/aries-cloudagent-python:py3.9-0.10.4

# ========================================================================================================================================
# Install Plugins
# ----------------------------------------------------------------------------------------------------------------------------------------
# Redis PQ
RUN pip install --no-cache-dir git+https://github.com/hyperledger/aries-acapy-plugins.git@main#subdirectory=redis_events
# Firebase Push Notifications
RUN pip install --no-cache-dir -e "git+https://github.com/hyperledger/aries-mediator-service.git@main#egg=firebase_push_notifications&subdirectory=acapy/plugins/firebase_push_notifications"
# ========================================================================================================================================