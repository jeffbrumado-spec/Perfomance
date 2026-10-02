# Conectar o MCP do Google Ads

Este repositório já traz o servidor MCP do Google Ads empacotado e configurado.
Falta apenas **ligar as suas credenciais**. Este documento tem o passo a passo.

## O que já está pronto

| Item | Onde |
| --- | --- |
| Código do servidor MCP | `vendor/google-ads-mcp/` |
| Registro do servidor no Claude Code | `.mcp.json` |
| Instalação do ambiente Python | `scripts/setup-google-ads-mcp.sh` |
| Inicialização + resolução de credenciais | `scripts/run-google-ads-mcp.sh` |
| Geração do refresh token (rodar localmente) | `scripts/gerar-refresh-token.py` |

Ferramentas expostas depois de conectado:

- `customers_list_accessible_customers` — lista as contas às quais você tem acesso
- `metadata_get_resource_metadata` — descreve um recurso da API (ex.: `campaign`)
- `search_search` — executa consultas GAQL (relatórios, métricas, campanhas)

Todas são de **leitura**. O servidor não altera campanhas nem orçamentos.

## Passo 1 — Developer token

1. Acesse o [API Center](https://ads.google.com/aw/apicenter) a partir da sua
   **conta de administrador (MCC)** do Google Ads.
2. Copie o developer token.
3. Ele precisa de nível **Explorer** ou superior para consultar contas de
   produção. Se aparecer o erro *"The developer token is only approved for use
   with test accounts"*, solicite a elevação de nível no próprio API Center.

## Passo 2 — Projeto no Google Cloud

1. Crie (ou escolha) um projeto no [Google Cloud Console](https://console.cloud.google.com/).
2. Ative a [Google Ads API](https://console.cloud.google.com/apis/library/googleads.googleapis.com).
3. Em **APIs e serviços → Credenciais**, crie um **ID do cliente OAuth** do tipo
   **Aplicativo para computador** e baixe o JSON.

## Passo 3 — Refresh token

Este passo exige navegador, então rode **na sua máquina**, não no container:

```bash
uv run --with google-auth-oauthlib scripts/gerar-refresh-token.py client_secret.json
```

O navegador abre, você autoriza com a conta Google que tem acesso ao Google Ads,
e o script imprime três valores:

```
GOOGLE_ADS_CLIENT_ID=...
GOOGLE_ADS_CLIENT_SECRET=...
GOOGLE_ADS_REFRESH_TOKEN=...
```

> Esses valores dão acesso à sua conta de anúncios. Guarde como segredo: nunca
> cole em chat, issue, PR ou arquivo versionado.

## Passo 4 — Registrar as credenciais

### No Claude Code na nuvem (sessões como esta)

Abra o menu do ambiente na barra de título da sessão → **Edit** → seção de
credenciais / variáveis de ambiente, e cadastre:

| Variável | Obrigatória | Conteúdo |
| --- | --- | --- |
| `GOOGLE_ADS_DEVELOPER_TOKEN` | sim | developer token do Passo 1 |
| `GOOGLE_ADS_CLIENT_ID` | sim | do Passo 3 |
| `GOOGLE_ADS_CLIENT_SECRET` | sim | do Passo 3 |
| `GOOGLE_ADS_REFRESH_TOKEN` | sim | do Passo 3 |
| `GOOGLE_ADS_LOGIN_CUSTOMER_ID` | se usar MCC | ID da conta administradora, só dígitos |

As variáveis valem a partir da **próxima sessão** — o ambiente atual não as
recebe retroativamente.

### Localmente

Exporte as mesmas variáveis no shell (ou num `.env` fora do repositório) antes
de abrir o Claude Code.

Alternativa sem refresh token: se você já usa `gcloud`, basta um ADC com o
escopo do Ads, e o wrapper o utiliza automaticamente:

```bash
gcloud auth application-default login \
  --scopes https://www.googleapis.com/auth/adwords,https://www.googleapis.com/auth/cloud-platform \
  --client-id-file=client_secret.json
```

## Passo 5 — Usar

Abra uma sessão nova neste repositório. O Claude Code lê o `.mcp.json`, pede
aprovação do servidor na primeira vez e instala o ambiente Python sozinho
(~30 s). Depois é só perguntar:

```
quais contas do Google Ads eu tenho acesso?
quantas campanhas ativas tem a conta 1234567890?
como foi o desempenho das campanhas na última semana?
```

O ID do cliente (customer ID) é pedido na maioria das consultas — incluí-lo
direto no prompt costuma ser mais rápido.

## Verificação e diagnóstico

Testar o servidor sem passar pelo Claude Code:

```bash
./scripts/setup-google-ads-mcp.sh   # instala o venv (idempotente)
./scripts/run-google-ads-mcp.sh     # sobe o servidor em stdio; Ctrl-C para sair
```

As mensagens de diagnóstico saem em **stderr** — stdout é reservado ao protocolo
MCP. Problemas comuns:

| Sintoma | Causa provável |
| --- | --- |
| `AVISO: GOOGLE_ADS_DEVELOPER_TOKEN não definido` | variável não cadastrada no ambiente |
| `DEVELOPER_TOKEN_NOT_APPROVED` | token ainda sem acesso de produção (Passo 1) |
| `USER_PERMISSION_DENIED` | a conta autorizada não tem acesso ao customer ID, ou falta `GOOGLE_ADS_LOGIN_CUSTOMER_ID` |
| `nenhuma credencial explícita` | faltam `CLIENT_ID`/`CLIENT_SECRET`/`REFRESH_TOKEN` |

## Modo servidor HTTP (opcional)

Para compartilhar o servidor entre vários clientes/agentes, ele também roda em
`streamable-http` com OAuth próprio, inclusive no Cloud Run. O procedimento está
no README do upstream: `vendor/google-ads-mcp/README.md`.

## Skill e agentes

O método de consulta e análise fica em `.claude/skills/google-ads/` (a skill
carrega sozinha quando o assunto é Ads) e os especialistas em `.claude/agents/`:
`ads-performance`, `ads-auditoria`, `ads-pacing` e `ads-relatorio`. Todos são
somente leitura.

## Origem do código

`vendor/google-ads-mcp/` é o projeto [googleads/google-ads-mcp](https://github.com/googleads/google-ads-mcp)
(Apache-2.0), versão 0.0.4, incluído sem modificações no código do servidor.
