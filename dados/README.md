# Dados exportados

Exports do Google Ads para alimentar os agentes, organizados por período:

```
dados/renovabe/2026-09/
  01-campanhas.csv
  02-grupos.csv
  ...
```

O guia de exportação, com os relatórios e colunas exatas, está em
`docs/exportar-csv.md`.

## Por que o conteúdo é ignorado pelo git

`.gitignore` bloqueia os arquivos de dados desta pasta. São métricas de conta de
cliente — gasto, receita, produtos — e versioná-las espalha esse dado por todo
clone do repositório, incluindo máquinas de quem só precisava do código.

Se você quiser versionar o histórico de exports (para reproduzir uma análise
antiga, por exemplo), remova a linha `dados/renovabe/**` do `.gitignore`. É uma
decisão consciente, não um esquecimento.

Para uma análise pontual você não precisa salvar nada aqui: basta anexar os
arquivos direto na conversa.
