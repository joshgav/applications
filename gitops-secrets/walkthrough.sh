# install ./openshift-services/sealedsecrets/deploy.sh
# install ./openshift-services/eso/deploy.sh
# install ./openshift-services/gitops/deploy.sh

source ./.env

aws secretsmanager create-secret \
    --name aws-secret01 \
    --secret-string '{ "test-key-01": "test-value-01" }'

cat ./awssm-secret.template.yaml | envsubst > ./awssm-secret.yaml
kubeseal --controller-name sealed-secrets --controller-namespace sealed-secrets \
    --format yaml \
    --secret-file ./awssm-secret.yaml \
    --sealed-secret-file ./awssm-sealed-secret.yaml

export GIT_REPO_URL=https://github.com/openshift
export GIT_USERNAME=my-username
export GIT_PASSWORD=my-password

aws secretsmanager create-secret \
    --name git-repo-creds-02 \
    --secret-string "{ \"url\": \"${GIT_REPO_URL}\", \"username\": \"${GIT_USERNAME}\", \"password\": \"${GIT_PASSWORD}\" }"

kubectl apply -f ./gitops-secrets-app.yaml
