# Gestión de secretos (entorno local)

Este repositorio no debe contener secretos en texto plano.

## Flujo recomendado

1. Crear archivo local desde plantilla:
```bash
cp env/.env.example env/.env.local
```
2. Completar valores reales en `env/.env.local`.
3. `shell/exports.sh` carga `env/.env.local` automáticamente.

`env/.env.local` está ignorado por git.

## Integración opcional con 1Password CLI (`op`)

Puedes usar URIs de 1Password en vez de guardar secretos locales:

```bash
OPENAI_API_KEY_OP_URI="op://<Vault>/<Item>/<Field>"
MXBAI_API_KEY_OP_URI="op://<Vault>/<Item>/<Field>"
```

Si `op` está disponible, `shell/exports.sh` resuelve variables automáticamente con `op read`.

## Prioridad de carga

1. Valor ya definido en entorno/sesión
2. `env/.env.local`
3. Resolución por `*_OP_URI` con `op`
4. Sin valor (fallo explícito en la herramienta consumidora)

## Guardrails de seguridad

- Escaneo manual:
```bash
scripts/security/scan-secrets.sh
```
- Hook local con `pre-commit` (si está instalado): usa `.pre-commit-config.yaml`
- CI de secretos: `.github/workflows/secret-scan.yml`

## Recomendaciones

- Rotar cualquier token expuesto históricamente.
- No copiar IDs reales de vault/item en archivos versionados.
- Mantener sólo placeholders en documentación.
