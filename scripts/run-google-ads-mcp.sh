#!/usr/bin/env bash
# Wrapper de inicialização do servidor MCP do Google Ads (transporte stdio).
#
# Resolve as credenciais na seguinte ordem:
#   1. GOOGLE_APPLICATION_CREDENTIALS já apontando para um arquivo existente.
#   2. GOOGLE_ADS_CLIENT_ID + GOOGLE_ADS_CLIENT_SECRET + GOOGLE_ADS_REFRESH_TOKEN
#      -> gera um arquivo ADC do tipo "authorized_user" em .secrets/adc.json.
#   3. ADC padrão do gcloud (~/.config/gcloud/application_default_credentials.json).
#
# stdout é reservado ao protocolo MCP: todo diagnóstico vai para stderr.
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
VENV="${GOOGLE_ADS_MCP_VENV:-$ROOT/.venv-google-ads-mcp}"

log() { printf '[google-ads-mcp] %s\n' "$*" >&2; }

[ -x "$VENV/bin/google-ads-mcp" ] || "$ROOT/scripts/setup-google-ads-mcp.sh"

if [ -n "${GOOGLE_APPLICATION_CREDENTIALS:-}" ] && [ -f "${GOOGLE_APPLICATION_CREDENTIALS}" ]; then
  log "usando GOOGLE_APPLICATION_CREDENTIALS=${GOOGLE_APPLICATION_CREDENTIALS}"
elif [ -n "${GOOGLE_ADS_CLIENT_ID:-}" ] && [ -n "${GOOGLE_ADS_CLIENT_SECRET:-}" ] && [ -n "${GOOGLE_ADS_REFRESH_TOKEN:-}" ]; then
  ADC="$ROOT/.secrets/adc.json"
  mkdir -p "$ROOT/.secrets"
  umask 077
  CLIENT_ID="$GOOGLE_ADS_CLIENT_ID" \
  CLIENT_SECRET="$GOOGLE_ADS_CLIENT_SECRET" \
  REFRESH_TOKEN="$GOOGLE_ADS_REFRESH_TOKEN" \
  "$VENV/bin/python" - "$ADC" <<'PY'
import json, os, sys
path = sys.argv[1]
with open(path, "w", encoding="utf-8") as fh:
    json.dump(
        {
            "type": "authorized_user",
            "client_id": os.environ["CLIENT_ID"],
            "client_secret": os.environ["CLIENT_SECRET"],
            "refresh_token": os.environ["REFRESH_TOKEN"],
        },
        fh,
    )
os.chmod(path, 0o600)
PY
  export GOOGLE_APPLICATION_CREDENTIALS="$ADC"
  log "credenciais ADC geradas a partir das variáveis de ambiente"
else
  log "nenhuma credencial explícita; tentando o ADC padrão do gcloud"
fi

[ -n "${GOOGLE_ADS_DEVELOPER_TOKEN:-}" ] || log "AVISO: GOOGLE_ADS_DEVELOPER_TOKEN não definido"

exec "$VENV/bin/google-ads-mcp"
