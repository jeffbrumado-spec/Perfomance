#!/usr/bin/env python3
"""Gera um refresh token OAuth com escopo do Google Ads.

Rode este script NA SUA MAQUINA (precisa de navegador), nao no container.

    uv run --with google-auth-oauthlib scripts/gerar-refresh-token.py client_secret.json

Onde `client_secret.json` e o JSON baixado do seu OAuth Client ID
(tipo "Aplicativo para computador" / "Desktop app") no Google Cloud Console.

O refresh token impresso no final deve ser guardado como variavel de ambiente
secreta (GOOGLE_ADS_REFRESH_TOKEN) -- nunca colado em chat nem commitado.
"""

import sys

SCOPES = ["https://www.googleapis.com/auth/adwords"]


def main(client_secrets_path: str) -> int:
    try:
        from google_auth_oauthlib.flow import InstalledAppFlow
    except ImportError:
        print(
            "Dependencia faltando. Rode:\n"
            "  uv run --with google-auth-oauthlib scripts/gerar-refresh-token.py "
            f"{client_secrets_path}",
            file=sys.stderr,
        )
        return 1

    flow = InstalledAppFlow.from_client_secrets_file(
        client_secrets_path, scopes=SCOPES
    )
    # access_type=offline + prompt=consent garante que o refresh token venha
    # mesmo que a conta ja tenha autorizado este client antes.
    credentials = flow.run_local_server(
        access_type="offline", prompt="consent"
    )

    print("\n=== Guarde estes valores como variaveis de ambiente ===")
    print(f"GOOGLE_ADS_CLIENT_ID={credentials.client_id}")
    print(f"GOOGLE_ADS_CLIENT_SECRET={credentials.client_secret}")
    print(f"GOOGLE_ADS_REFRESH_TOKEN={credentials.refresh_token}")
    return 0


if __name__ == "__main__":
    if len(sys.argv) != 2:
        print(__doc__, file=sys.stderr)
        raise SystemExit(2)
    raise SystemExit(main(sys.argv[1]))
