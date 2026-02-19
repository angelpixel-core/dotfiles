# Gestion de Secretos y Entorno Local

Este repositorio **no debe** contener secretos en texto plano.

## Flujo recomendado

1. Copia la plantilla:
```bash
cp env/.env.example env/.env.local
```
2. Completa `env/.env.local` con valores reales.
3. `shell/exports.sh` carga automaticamente `env/.env.local` si existe.

`env/.env.local` esta ignorado por git.

## Integracion opcional con 1Password (op)

Si prefieres no guardar el secreto en `.env.local`, define la URI:

```bash
MXBAI_API_KEY_OP_URI="op://<Vault>/<Item>/<Field>"
```

Cuando `op` esta disponible y `MXBAI_API_KEY` no viene definido en local, `shell/exports.sh` intentara resolver:

```bash
op read "$MXBAI_API_KEY_OP_URI"
```

## Buenas practicas

- Rotar cualquier token que haya estado expuesto en git.
- Mantener solo placeholders en archivos versionados.
- Ejecutar escaneo de secretos antes de abrir PR.
