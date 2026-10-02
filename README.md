# Perfomance

Integração do **MCP do Google Ads** para análise de performance de campanhas
direto no Claude Code.

O servidor MCP já está empacotado e registrado neste repositório; só faltam as
credenciais da sua conta. O passo a passo completo está em
**[docs/GOOGLE_ADS_MCP.md](docs/GOOGLE_ADS_MCP.md)**.

## Resumo

```bash
./scripts/setup-google-ads-mcp.sh   # instala o ambiente Python do servidor
./scripts/run-google-ads-mcp.sh     # sobe o servidor MCP (stdio)
```

Variáveis de ambiente necessárias:

```
GOOGLE_ADS_DEVELOPER_TOKEN
GOOGLE_ADS_CLIENT_ID
GOOGLE_ADS_CLIENT_SECRET
GOOGLE_ADS_REFRESH_TOKEN
GOOGLE_ADS_LOGIN_CUSTOMER_ID   # apenas se o acesso for via MCC
```
