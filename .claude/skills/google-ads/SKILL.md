---
name: google-ads
description: Análise de contas do Google Ads via MCP oficial — performance de campanhas, auditoria de conta, pacing de orçamento, termos de busca, índice de qualidade, conversões e relatórios para cliente. Use sempre que a conversa envolver Google Ads, Ads, PPC, mídia paga, campanhas, CPA, ROAS, impression share, palavras-chave negativas ou análise de verba de anúncios — inclusive quando o usuário não citar "Google Ads" explicitamente mas pedir para olhar campanhas, gasto, conversões ou desempenho de anúncios.
---

# Análise de Google Ads

Este repositório tem o MCP oficial do Google Ads conectado (`vendor/google-ads-mcp`).
Esta skill ensina a extrair conclusões confiáveis dele.

## Antes de tudo: as ferramentas são somente leitura

O servidor expõe três ferramentas, nenhuma delas escreve na conta:

- `customers_list_accessible_customers` — IDs acessíveis
- `metadata_get_resource_metadata` — campos válidos de um recurso
- `search_search` — busca os dados

Então toda conclusão do tipo "pause isso", "suba o lance", "corte essa palavra"
sai como **recomendação escrita**, com o número que a sustenta. Nunca prometa ao
usuário que algo foi alterado na conta.

Se uma chamada falhar com *"Your default credentials were not found"*, o
servidor está conectado mas sem credenciais: aponte o usuário para
`docs/GOOGLE_ADS_MCP.md` em vez de tentar contornar.

## Como consultar

Leia **`references/consultas.md`** antes de montar a primeira query da sessão.
Ele cobre a assinatura do `search_search` (que monta o GAQL a partir de
argumentos, não aceita query crua), os recursos mais usados e as armadilhas que
mais queimam tempo — micros, fuso, segmentação que infla linhas.

Dois hábitos que evitam a maior parte dos erros:

1. **Confirme os campos antes de usar um recurso novo.** Chame
   `metadata_get_resource_metadata`. A API rejeita a query inteira por causa de
   um campo inválido, e nem toda métrica existe em todo recurso — o erro não diz
   qual campo quebrou.
2. **Descubra o `customer_id` antes de perguntar.** Se o usuário não deu um ID,
   chame `customers_list_accessible_customers`. Se voltar mais de uma conta, aí
   sim pergunte qual — mostrando os IDs, não pedindo que ele descubra sozinho.

## Como analisar

A diferença entre um despejo de métricas e uma análise útil é a **comparação** e
a **causa**. Três passos:

**1. Estabeleça a base.** Puxe o período pedido e o período anterior equivalente
(7 dias contra os 7 anteriores, mês contra mês anterior). Um número sozinho não
diz nada: R$ 40 de CPA é ótimo ou terrível dependendo de onde estava antes e da
meta.

**2. Encontre o que se moveu.** Quando um indicador muda, decomponha:
conta → campanha → grupo → anúncio/palavra-chave. Quase sempre o movimento
agregado vem de uma ou duas entidades, não de uma piora geral. Ache quais.

**3. Separe causa de sintoma.** CPA subiu é sintoma. A causa está numa destas
camadas, e vale checar nesta ordem:

| Camada | O que olhar |
| --- | --- |
| Volume | impressões e `search_impression_share` caíram? |
| Concorrência | `search_rank_lost_impression_share` subiu? |
| Verba | `search_budget_lost_impression_share` subiu? |
| Relevância | CTR caiu? índice de qualidade piorou? |
| Conversão | cliques estáveis mas conversões caíram → problema no site ou no rastreamento |
| Mix | uma campanha cara ganhou participação no gasto total |

O caso mais comum e mais mal diagnosticado: **conversões sumiram de repente em
toda a conta**. Antes de culpar as campanhas, verifique `conversion_action` —
ação pausada, tag removida do site ou mudança de janela de atribuição produzem
exatamente esse sintoma, e nenhuma otimização de campanha resolve.

## Como reportar

Escreva para quem vai decidir, não para quem já conhece a conta.

- **Comece pela conclusão.** "O CPA subiu 38% porque a campanha Institucional
  absorveu 40% da verba sem converter" — não comece pela tabela.
- **Todo número com contexto.** Variação percentual e valor absoluto. "Caiu 12%"
  esconde se foram R$ 50 ou R$ 50.000.
- **Converta micros e formate a moeda** lida de `customer.currency_code`.
- **Diga o tamanho da amostra.** Uma campanha com 3 cliques não sustenta
  conclusão nenhuma. Quando o volume for baixo, diga isso em vez de inventar
  leitura.
- **Recomendações acionáveis e priorizadas**, com o impacto estimado em dinheiro
  quando der para estimar. Três boas valem mais que doze genéricas.

### Honestidade sobre os dados

Esta parte é o que separa uma análise confiável de uma perigosa. Se um dado não
veio, diga que não veio. Se a conta não tem `conversions_value`, não há ROAS —
diga isso em vez de calcular com conversão como proxy de receita. Se o período
pedido inclui hoje, os dados estão incompletos e a comparação fica enviesada:
avise. Quem lê o relatório vai mover verba com base nele.

## Agentes especializados

Para trabalhos maiores, este projeto tem agentes dedicados em `.claude/agents/`,
cada um apoiado numa especificação em `docs/metodologia/`:

| Agente | Quando |
| --- | --- |
| `ads-analise` | diagnóstico de conta por eficiência (PMax + Search) |
| `ads-diagnostico-canal` | qual das três alavancas do ROAS está travando |
| `ga4-comportamento` | comportamento e demanda do site, MER real |
| `trafego-estrategico` | quanto investir para bater a meta |

Esta skill cobre o uso direto do MCP e dá a base comum a todos. Quando houver
divergência entre ela e uma especificação de `docs/metodologia/`, a
especificação vence — ela carrega o método da casa.

## Escopo do projeto

Leia `CLAUDE.md`: este repositório trata só de growth e performance do Google
Ads da Renovabe, e a análise depende de dois parâmetros do negócio (margem
bruta e ticket médio) que não vêm de API. Sem eles não há ROAS de equilíbrio e
nada se classifica.
