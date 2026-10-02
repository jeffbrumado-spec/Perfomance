# Referência de consulta — MCP do Google Ads

Guia comum a todos os agentes de Ads deste repositório. Leia antes de montar
qualquer consulta.

## As três ferramentas

| Ferramenta | Para quê |
| --- | --- |
| `customers_list_accessible_customers` | descobrir os IDs de conta acessíveis |
| `metadata_get_resource_metadata` | descobrir os campos válidos de um recurso |
| `search_search` | buscar os dados |

Todas são **somente leitura**. Nenhum agente deste repositório altera campanha,
lance, orçamento ou anúncio — quando a conclusão for "mude X", ela sai como
recomendação escrita, nunca como execução.

## Como chamar o `search_search`

A ferramenta **não aceita GAQL cru**. Ela monta a query a partir de argumentos:

```
search_search(
  customer_id = "1234567890",            # só dígitos, sem hífens
  resource    = "campaign",              # a cláusula FROM
  fields      = ["campaign.id", "campaign.name", "metrics.cost_micros"],
  conditions  = ["segments.date BETWEEN '2026-09-01' AND '2026-09-30'",
                 "campaign.status = 'ENABLED'"],
  orderings   = ["metrics.cost_micros DESC"],
  limit       = 50,
)
```

- `conditions` são combinadas com **AND**. Não há como fazer OR entre elas —
  se precisar, rode consultas separadas e junte o resultado.
- `fields` exige o **nome completo**: `campaign.name`, nunca `name`. Curingas
  não funcionam.
- `orderings` usa a forma `campo DESC` / `campo ASC`.

## Regra de ouro: não adivinhe campos

Antes de usar um recurso pela primeira vez numa sessão, chame
`metadata_get_resource_metadata` para esse recurso. A API rejeita a query
inteira se um único campo for inválido ou incompatível com o recurso, e nem
toda métrica existe em todo recurso.

## Armadilhas que custam tempo

**Micros.** `cost_micros`, `average_cpc`, `budget.amount_micros` e afins vêm
multiplicados por 1.000.000. Divida antes de mostrar qualquer valor. Um gasto
de R$ 1.234,56 chega como `1234560000`.

**Moeda.** Pegue `customer.currency_code` do recurso `customer` antes de
formatar dinheiro. Não presuma BRL.

**Fuso.** As datas seguem o fuso da conta (`customer.time_zone`), não o seu.
O dia "de hoje" costuma estar incompleto — compare períodos fechados.

**Datas.** Formato `YYYY-MM-DD` com hífens. Para intervalos use
`segments.date BETWEEN 'inicio' AND 'fim'`. Os atalhos do GAQL também
funcionam (`segments.date DURING LAST_30_DAYS`, `LAST_MONTH`, `THIS_MONTH`,
`YESTERDAY`), mas para comparar dois períodos use datas explícitas — assim
você controla exatamente o recorte.

**Segmentação infla linhas.** Incluir qualquer campo `segments.*` nos `fields`
quebra o resultado em uma linha por valor do segmento. Se você só quer o total
do período, **não** selecione `segments.date` — use-o apenas em `conditions`.

**Conversões são `double`.** `metrics.conversions` pode vir fracionado (ex.:
2.5) por causa de modelos de atribuição. Isso é normal, não é erro.

**Zero divisão.** CPA e ROAS explodem quando não há conversão no período.
Trate o caso e reporte "sem conversões", não `∞` nem `0`.

## Recursos mais usados

| Recurso | Serve para |
| --- | --- |
| `customer` | moeda, fuso, nome e ID da conta |
| `campaign` | métricas e configuração por campanha |
| `campaign_budget` | valor do orçamento, tipo de entrega |
| `ad_group` | métricas por grupo de anúncios |
| `ad_group_ad` | anúncios, status de aprovação, política |
| `ad_group_criterion` | palavras-chave, lances, índice de qualidade |
| `search_term_view` | termos reais buscados pelo usuário |
| `keyword_view` | desempenho por palavra-chave |
| `conversion_action` | configuração das ações de conversão |
| `campaign_criterion` | negativas, locais, idiomas no nível campanha |
| `asset` / `campaign_asset` | extensões e recursos criativos |
| `change_event` | histórico de alterações (exige `LIMIT` ≤ 10000) |

## Métricas que sustentam quase toda análise

```
metrics.impressions
metrics.clicks
metrics.ctr
metrics.cost_micros
metrics.average_cpc
metrics.conversions
metrics.conversions_value
metrics.cost_per_conversion
metrics.search_impression_share
metrics.search_budget_lost_impression_share
metrics.search_rank_lost_impression_share
```

`search_impression_share` e as variantes de perda só existem em campanhas de
Rede de Pesquisa e vêm como fração (0 a 1), não percentual.

## Conta MCC

Se o acesso é via conta administradora, passe `login_customer_id` com o ID da
MCC na chamada, ou confie na variável `GOOGLE_ADS_LOGIN_CUSTOMER_ID` do
ambiente. O `customer_id` continua sendo o da conta que você quer consultar.
