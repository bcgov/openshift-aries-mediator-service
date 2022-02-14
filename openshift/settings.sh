export PROJECT_NAMESPACE="4a9599"
export GIT_URI="https://github.com/hyperledger/aries-mediator-service.git"
export GIT_REF="main"

# The templates that should not have their GIT referances(uri and ref) over-ridden
# Templates NOT in this list will have they GIT referances over-ridden
# with the values of GIT_URI and GIT_REF
export skip_git_overrides="schema-spy-build.yaml search-engine-base-build.yaml backup-build.yaml"