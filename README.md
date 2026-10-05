# Perfomance

Growth e performance do **Google Ads da Renovabe** dentro do Claude Code: o MCP
oficial do Google, a metodologia ADSUP e quatro agentes especializados.

O escopo e os princípios do projeto estão em [CLAUDE.md](CLAUDE.md).

## Estrutura

| Caminho | O que é |
| --- | --- |
| `vendor/google-ads-mcp/` | MCP oficial do Google Ads (Apache-2.0, v0.0.4) |
| `.mcp.json` | registra o servidor no Claude Code |
| `.claude/skills/google-ads/` | skill com método de consulta e análise |
| `.claude/agents/` | subagentes especializados |
| `docs/metodologia/` | especificações dos agentes (fonte de verdade) |
| `docs/exportar-csv.md` | quais relatórios exportar e com quais colunas |
| `dados/renovabe/` | exports por período (ignorado pelo git) |
| `scripts/` | instalação, inicialização e geração de refresh token |
| `docs/GOOGLE_ADS_MCP.md` | passo a passo da conexão |

## Agentes

| Agente | Para quê |
| --- | --- |
| `ads-analise` | diagnóstico de conta por eficiência (PMax + Search) |
| `ads-diagnostico-canal` | qual das três alavancas do ROAS está travando |
| `ga4-comportamento` | comportamento e demanda do site, MER real |
| `trafego-estrategico` | quanto investir para bater a meta |

Todos operam **somente em leitura**. Nenhum altera campanha, lance ou orçamento.

## Conectar

As credenciais ainda precisam ser cadastradas — o passo a passo está em
[docs/GOOGLE_ADS_MCP.md](docs/GOOGLE_ADS_MCP.md). Resumo das variáveis:

```
GOOGLE_ADS_DEVELOPER_TOKEN
GOOGLE_ADS_CLIENT_ID
GOOGLE_ADS_CLIENT_SECRET
GOOGLE_ADS_REFRESH_TOKEN
GOOGLE_ADS_LOGIN_CUSTOMER_ID   # apenas se o acesso for via MCC
```

Para verificar a instalação sem passar pelo Claude Code:

```bash
./scripts/setup-google-ads-mcp.sh   # instala o ambiente Python
./scripts/run-google-ads-mcp.sh     # sobe o servidor MCP (stdio)
```
