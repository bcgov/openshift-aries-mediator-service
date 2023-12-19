#! /bin/bash
_includeFile=$(type -p overrides.inc)
if [ ! -z ${_includeFile} ]; then
  . ${_includeFile}
else
  _red='\033[0;31m'; _yellow='\033[1;33m'; _nc='\033[0m'; echo -e \\n"${_red}overrides.inc could not be found on the path.${_nc}\n${_yellow}Please ensure the openshift-developer-tools are installed on and registered on your path.${_nc}\n${_yellow}https://github.com/BCDevOps/openshift-developer-tools${_nc}"; exit 1;
fi

# Generate profile config map
# - To include all of the files in the application instance's profile directory.
# Injected by genDepls.sh
# - CONFIG_MAP_NAME
# - SUFFIX
# - DEPLOYMENT_ENV_NAME
# - PROFILE
PROFILE=${PROFILE:-default}
CONFIG_MAP_NAME=${CONFIG_MAP_NAME:-mediator-config}
CONFIG_ROOT=$( dirname "$0" )/config
OUTPUT_FORMAT=json
OUTPUT_FILE=${CONFIG_MAP_NAME}-configmap_DeploymentConfig.json

# Generate the config map ...
generateProfileConfigMap "${PROFILE}" "${DEPLOYMENT_ENV_NAME}" "${CONFIG_MAP_NAME}${SUFFIX}" "${CONFIG_ROOT}" "${OUTPUT_FORMAT}" "${OUTPUT_FILE}"

unset SPECIALDEPLOYPARMS

if createOperation; then
  # Ask the user to supply the sensitive parameters ...
  readParameter "WALLET_SEED - Please provide the indy wallet seed for the environment.  If left blank, a seed will be randomly generated using openssl:" WALLET_SEED $(generateSeed) "false"
  readParameter "WALLET_KEY - Please provide the wallet encryption key for the environment.  If left blank, a 48 character long base64 encoded value will be randomly generated using openssl:" WALLET_KEY $(generateKey) "false"
  readParameter "ADMIN_API_KEY - Please provide the key for the agent's Admin API.  If left blank, a 32 character long base64 encoded value will be randomly generated using openssl:" ADMIN_API_KEY $(generateKey 32) "false"

  readParameter "FIREBASE_PROJECT_ID - Please provide the firebase project id for the environment.  The defaut is a blank string:" FIREBASE_PROJECT_ID "" "false"
  readParameter "FIREBASE_NOTIFICATION_TITLE - Please provide the firebase notification title for the environment.  The defaut is a blank string:" FIREBASE_NOTIFICATION_TITLE "" "false"
  readParameter "FIREBASE_NOTIFICATION_BODY - Please provide the firebase notification body for the environment.  The defaut is a blank string:" FIREBASE_NOTIFICATION_BODY "" "false"
  readParameter "FIREBASE_SERVICE_ACCOUNT - Please provide the firebase service account infomration, in the form of flattened account json, for the environment.  The defaut is a blank string:" FIREBASE_SERVICE_ACCOUNT "" "false"
else
  # Secrets are removed from the configurations during update operations ...
  printStatusMsg "Update operation detected ...\nSkipping the prompts for the WALLET_SEED, WALLET_KEY, ADMIN_API_KEY, FIREBASE_PROJECT_ID, FIREBASE_NOTIFICATION_TITLE, FIREBASE_NOTIFICATION_BODY, and FIREBASE_SERVICE_ACCOUNT secrets... \n"
  writeParameter "WALLET_SEED" "prompt_skipped" "false"
  writeParameter "WALLET_KEY" "prompt_skipped" "false"
  writeParameter "ADMIN_API_KEY" "prompt_skipped" "false"

  writeParameter "FIREBASE_PROJECT_ID" "prompt_skipped" "false"
  writeParameter "FIREBASE_NOTIFICATION_TITLE" "prompt_skipped" "false"
  writeParameter "FIREBASE_NOTIFICATION_BODY" "prompt_skipped" "false"
  writeParameter "FIREBASE_SERVICE_ACCOUNT" "prompt_skipped" "false"
fi

SPECIALDEPLOYPARMS="--param-file=${_overrideParamFile}"
echo ${SPECIALDEPLOYPARMS}