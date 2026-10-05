# Projeto Perfomance — Growth e Performance de Google Ads · Renovabe

## Escopo

Este repositório trata de **uma coisa só**: growth e performance do **Google Ads
da Renovabe**.

Todo contexto, análise e recomendação parte daí. Meta Ads, TikTok, Pinterest e
os demais canais aparecem apenas como referência de metodologia ou como contexto
de distribuição de sessões quando o cálculo exigir — nunca como objeto de
trabalho por iniciativa própria. GA4 entra como **fonte de caixa e de
comportamento do site**, para auditar a mídia, não como análise separada.

Se um pedido sair desse escopo, atenda o que for de Google Ads e diga
explicitamente o que ficou de fora.

## Agentes

| Agente | Quando | Especificação |
| --- | --- | --- |
| `ads-analise` | diagnóstico de conta por eficiência (PMax + Search) | `docs/metodologia/20-analise-google-ads.md` |
| `ads-diagnostico-canal` | por que o ROAS está onde está, qual alavanca trava | `docs/metodologia/28-diagnostico-performance-canal.md` |
| `ga4-comportamento` | comportamento e demanda do site, MER real | `docs/metodologia/34-especialista-ga4.md` |
| `trafego-estrategico` | quanto investir para bater a meta, estrutura e escala | `docs/metodologia/07-trafego-estrategico.md` |

As especificações em `docs/metodologia/` são a **fonte de verdade**. Os arquivos
em `.claude/agents/` apenas ancoram cada agente no projeto — quando divergirem,
a especificação vence.

A skill `google-ads` (`.claude/skills/google-ads/`) traz o método de consulta ao
MCP oficial e carrega sozinha quando o assunto é Ads.

## Princípios inegociáveis

Herdados da metodologia e válidos para qualquer trabalho aqui:

**Clique mente. Eficiência manda.** Nada se classifica por volume de cliques.
A régua é ROAS/CPA/margem contra o ROAS de equilíbrio (`100 ÷ % margem bruta`),
nunca uma taxa de conversão fixa.

**Mensuração é gate.** Se a medição está quebrada — valor de conversão fixo ou
zerado, dupla contagem, tag errada — as recomendações de verba **congelam**.
Não se escala receita sobre medição que mente.

**Não inventar.** Métrica sem dado confiável vira `n/d` declarado. Campo que a
fonte não expõe é `n/d`, não estimativa. Ressalva de integridade omitida para o
relatório "ficar bonito" é defeito.

**Significância antes de conclusão.** Sem volume mínimo de cliques e conversões
é ruído. Ruído não decide verba.

**Somente leitura por padrão.** Nenhum agente altera campanha, lance ou
orçamento sem pedido explícito e confirmação.

## Parâmetros do negócio — ⚠️ em aberto

A metodologia inteira depende de dois números que **não vêm de API** e ainda não
foram informados:

| Parâmetro | Para quê | Status |
| --- | --- | --- |
| Margem bruta média | ROAS de equilíbrio = `100 ÷ margem` | ❌ pendente |
| Ticket médio | CPA máximo tolerável, piso de taxa de conversão | ❌ pendente |
| Meta de receita do período | cálculo de sessões e investimento necessários | ❌ pendente |
| Customer ID da conta | toda consulta | ❌ pendente |

Sem margem e ticket **não existe linha de corte**, e a matriz de tiering não
classifica nada. Peça esses números antes de rodar `ads-analise` ou
`trafego-estrategico` — não os estime.

## Fonte de dados — status

| Fonte | Status | Observação |
| --- | --- | --- |
| MCP oficial do Google Ads | ⚙️ instalado, sem credencial | falta o developer token; ver `docs/GOOGLE_ADS_MCP.md` |
| Windsor.ai | ❌ não conectado | é o que as especificações assumem; **dispensa developer token** |
| Export CSV do Google Ads | ✅ disponível | funciona hoje, sem credencial; relatórios e colunas em `docs/exportar-csv.md` |

Exports ficam em `dados/renovabe/<AAAA-MM>/` (conteúdo ignorado pelo git — ver
`dados/README.md`), ou simplesmente anexados na conversa.

As especificações foram escritas sobre o Windsor (`google_ads`,
`googleanalytics4`). O método de leitura não muda com a fonte — o que muda é
quais campos existem. Valide o que a fonte expõe antes de montar qualquer tabela
e marque `n/d` o que não vier.

## Idioma e formato

Português do Brasil, direto, output-first. Números no padrão BR: vírgula
decimal, milhar com ponto, `R$`. Gasto sempre em R$, taxas sempre em %.
Período real (sem o dia corrente, que está incompleto) no título e no nome de
qualquer arquivo entregue.
