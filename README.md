# Perfomance

Análise de Google Ads dentro do Claude Code: o MCP oficial do Google conectado,
mais uma skill e quatro agentes especializados em performance de mídia paga.

## Estrutura

| Caminho | O que é |
| --- | --- |
| `vendor/google-ads-mcp/` | MCP oficial do Google Ads (Apache-2.0, v0.0.4) |
| `.mcp.json` | registra o servidor no Claude Code |
| `.claude/skills/google-ads/` | skill com método de consulta e análise |
| `.claude/agents/` | subagentes especializados |
| `scripts/` | instalação, inicialização e geração de refresh token |
| `docs/GOOGLE_ADS_MCP.md` | passo a passo da conexão |

## Agentes

| Agente | Para quê |
| --- | --- |
| `ads-performance` | o que mudou no desempenho e por quê |
| `ads-auditoria` | verba vazando e configuração quebrada |
| `ads-pacing` | ritmo de gasto contra a meta e projeção |
| `ads-relatorio` | relatório consolidado para cliente ou diretoria |

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
