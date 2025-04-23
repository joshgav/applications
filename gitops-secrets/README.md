# gitops-secrets

Goal is to create a secret of the following form for GitOps:

(from https://argo-cd.readthedocs.io/en/stable/operator-manual/declarative-setup/#repository-credentials)

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