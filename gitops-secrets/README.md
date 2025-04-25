# gitops-secrets

An example of using SealedSecrets for the connection secret ("secret zero") for
an ESO SecretStore.

The git repo connection secret is then synced from the SecretStore.

NOTE that this requires _this_ repo to be accessible _without_ a git secret from
ArgoCD. Only further repos can depend on the git secret.

## Usage

1. Install SealedSecrets, External Secrets Operator (ESO), and OpenShift GitOps (ArgoCD).
1. Create and seal a SealedSecret for access to AWS SM based on
   [awssm-secret.template.yaml](./awssm-secret.template.yaml). Place it in the
   [./resources](./resources/) directory.
1. Put secrets into AWS Secrets Manager via CLI or UI.
1. Create an ArgoCD application based on
   [gitops-secrets-app.yaml](./gitops-secrets-app.yaml) to create a SecretStore and
   some initial ExternalSecrets.

See example commands in [walkthrough.sh](./walkthrough.sh).

## Goal

Goal is to create a secret of the following form for further GitOps repos:

```yaml
---
apiVersion: v1
kind: Secret
metadata:
  name: example-git-repo-creds
  namespace: openshift-gitops
  labels:
    argocd.argoproj.io/secret-type: repo-creds
stringData:
  type: git
  url: https://github.com/openshift
  password: my-password
  username: my-username
```

## Resources

- https://external-secrets.io/latest/guides/templating/
- https://argo-cd.readthedocs.io/en/stable/operator-manual/declarative-setup/#repository-credentials
