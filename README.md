Kustomize validation pre-commit
===============================

The customize `pre-commit-hook` to validated a Kustomize resources available.  
This repo use docker to executed a shot-script to generate manifest files and verified  
from [kubernetes-validate](https://github.com/willthames/kubernetes-validate). If it doesn't syntax or indent error,  
It will be return **OK**. However, It doesn't garantee your manifest is able to provisioned on Kubernetes.

Using pre-commit
-------------------

Add the following in `.pre-commit-config.yaml`. It done when nothing return.

```yaml
- repo: https://github.com/StartloJ/k8s-validations
  rev: v0.1.0
  hooks:
  - k8s-validations
```
