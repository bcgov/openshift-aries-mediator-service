#! /bin/bash
_includeFile=$(type -p overrides.inc)
if [ ! -z ${_includeFile} ]; then
  . ${_includeFile}
else
  _red='\033[0;31m'; _yellow='\033[1;33m'; _nc='\033[0m'; echo -e \\n"${_red}overrides.inc could not be found on the path.${_nc}\n${_yellow}Please ensure the openshift-developer-tools are installed on and registered on your path.${_nc}\n${_yellow}https://github.com/BCDevOps/openshift-developer-tools${_nc}"; exit 1;
fi

# Generate application config map
# - To include all of the files in the application instance's profile directory.
# Injected by genDepls.sh
# - CONFIG_MAP_NAME
# - SUFFIX

CONFIG_MAP_NAME=${CONFIG_MAP_NAME:-caddy-conf}
SOURCE_FILE=$( dirname "$0" )/caddy/Caddyfile

OUTPUT_FORMAT=json
OUTPUT_FILE=${CONFIG_MAP_NAME}-configmap_Deployment.json

printStatusMsg "Generating ConfigMap; ${CONFIG_MAP_NAME} ..."
generateConfigMap "${CONFIG_MAP_NAME}${SUFFIX}" "${SOURCE_FILE}" "${OUTPUT_FORMAT}" "${OUTPUT_FILE}"

unset SPECIALDEPLOYPARMS
echo ${SPECIALDEPLOYPARMS}
