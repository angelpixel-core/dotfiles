# Secret Hygiene & Environment Normalization

## Contexto

Este repositorio es el source of truth de mi entorno.
Históricamente hubo variables de entorno diseminadas en:

- shell/exports.sh
- archivos .env sueltos
- $HOME
- scripts aislados
- variables cargadas manualmente

Objetivo: normalizar y profesionalizar la gestión de secretos.

---

## Tu tarea

Realizar auditoría completa de:

- export hardcodeados
- tokens
- API keys
- endpoints privados
- rutas sensibles
- secretos embedidos en scripts

Clasificar hallazgos por severidad:
- CRITICAL (hardcoded secret)
- HIGH (env sin documentación)
- MEDIUM (variable ambigua)
- LOW (ruido)

---

## Arquitectura objetivo

Implementar el siguiente modelo:

### 1. Estructura estándar
```txt
- env/
  - .env.example        # plantilla versionada
  - README.md           # documentación del flujo
  - .env.local          # ignorado por git
```

### 2. Reglas

- Nunca hardcodear secretos en shell scripts.
- Nunca commitear `.env.local`.
- `.env.example` solo contiene claves, nunca valores reales.
- `.gitignore` debe cubrir:
  - env/.env.local
  - *.secret
  - *.key
  - cualquier archivo sensible detectado

---

## Integración con 1Password (opcional)

Si `op` está disponible (con placeholders):

- Permitir carga dinámica:

```bash
export OPENAI_API_KEY=$(op read "op://<Vault>/<Item>/<Field>")
```

- Documentar en env/README.md:
  - Cómo autenticar op
  - Cómo mapear variables
  - Cómo fallbackear a .env.local

⸻

### Entregables
1.	Reporte de secretos detectados con paths.
2.	Eliminación segura de hardcoded secrets.
3.	Implementación de env/ structure.
4.	Documentación en español del flujo completo.
5.	Script opcional:
  - scripts/security/scan-secrets.sh
6.	Recomendación de pre-commit o CI scan (ej: gitleaks).

⸻

### No permitido
- No eliminar sin explicar.
- No cambiar comportamiento sin documentar.
- No asumir que todo puede ir en 1Password.

---

# 3️⃣ Estructura recomendada final para secretos (versión final limpia)

Te dejo la arquitectura recomendada consolidada:

```txt
- env/
  - .env.example
  - README.md
  - .env.local        # ignored
- scripts/
   - security/
   - scan-secrets.sh
- .gitignore
```

---

# 4️⃣ `.env.example` recomendado

```bash
# API Keys
OPENAI_API_KEY=<value>
MXBAI_API_KEY=<value>

# Cloud
AWS_PROFILE=
AWS_REGION=

# Custom tooling
MY_CUSTOM_TOOL_TOKEN=<value>
```
