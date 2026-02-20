# Security Guardrails

## Objetivo

Reducir el riesgo de commits con secretos o metadata sensible.

## Escaneo local

```bash
scripts/security/scan-secrets.sh
```

## Hook opcional pre-commit

Si usas `pre-commit`:

```bash
pre-commit install
pre-commit run --all-files
```

Config: `.pre-commit-config.yaml`

## CI

Workflow: `.github/workflows/secret-scan.yml`

Se ejecuta en `push` a `main` y en `pull_request`.
