# Branching Strategy

Decisión canónica para mantener PRs chicas, reversibles y con commits atómicos.

## Objetivo

- Reducir riesgo de regresiones.
- Facilitar rollback por commit.
- Mantener trazabilidad clara de cambios.

## Estrategia

1. `main` es la rama estable y siempre integrable.
2. Todo cambio entra por rama corta y temática.
3. Un commit debe resolver una sola intención técnica.
4. Cada PR debe incluir verificación mínima (`make test` como baseline).

## Naming de ramas

- `fix/<scope>-<topic>` para correcciones.
- `feat/<scope>-<topic>` para funcionalidades.
- `docs/<scope>-<topic>` para documentación.
- `chore/<scope>-<topic>` para mantenimiento/refactors no funcionales.
- `security/<scope>-<topic>` para hardening y secretos.

## Política de commits

- Mensajes con convención tipo `type(scope): summary`.
- Evitar commits mixtos (código + docs + seguridad en el mismo cambio).
- Si hay duda, dividir en commits más pequeños.

## Rollback

- Rollback preferido: revert de commit puntual.
- Evitar acciones destructivas sobre historial compartido.
- Si un PR trae varios commits, poder revertir selectivamente por intención.

## Verificación mínima por PR

1. `make test`
2. `git status --short --branch` limpio
3. Confirmar que no se agregaron secretos ni artefactos sensibles
