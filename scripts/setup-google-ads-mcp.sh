#!/usr/bin/env bash
# Instala o servidor MCP do Google Ads num virtualenv isolado dentro do repo.
# Idempotente: se o venv já existe e está íntegro, não faz nada.
# Todo log vai para stderr para nunca poluir o canal stdio do MCP.
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
VENV="${GOOGLE_ADS_MCP_VENV:-$ROOT/.venv-google-ads-mcp}"
SRC="$ROOT/vendor/google-ads-mcp"

log() { printf '[setup-google-ads-mcp] %s\n' "$*" >&2; }

if [ -x "$VENV/bin/google-ads-mcp" ]; then
  log "venv já instalado em $VENV"
  exit 0
fi

if command -v uv >/dev/null 2>&1; then
  log "criando venv com uv em $VENV"
  uv venv "$VENV" >&2
  uv pip install --python "$VENV/bin/python" --quiet "$SRC" >&2
else
  log "uv não encontrado; usando python -m venv"
  python3 -m venv "$VENV" >&2
  "$VENV/bin/python" -m pip install --quiet --upgrade pip >&2
  "$VENV/bin/python" -m pip install --quiet "$SRC" >&2
fi

log "instalação concluída"
