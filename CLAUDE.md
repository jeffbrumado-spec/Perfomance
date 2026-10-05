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

## Parâmetros do negócio

| Parâmetro | Valor | Status |
| --- | --- | --- |
| **Margem bruta média** | **50%**, já líquida de frete | ✅ informado pelo cliente |
| **ROAS de equilíbrio** | **2,00** (`100 ÷ 50`) | derivado |
| **ROAS saudável** | **4,00** (equilíbrio × 2) | derivado |
| Ticket médio da conta | R$ 318,27 | implícito nos dados de set/out 2026 |
| Meta de receita do período | — | ❌ pendente (trava `trafego-estrategico`) |
| Customer ID da conta | — | ❌ pendente |

> O frete está **dentro** dos 50% (confirmado pelo cliente). Não desconte frete
> de novo ao calcular CPA de empate ou margem por pedido — seria contar duas
> vezes.

### O ticket é por produto, não da conta

`CPA máximo tolerável = Ticket × Margem × 0,50`. Como o ticket varia bastante
entre produtos, **use o ticket do produto analisado**, nunca a média da conta —
ela é puxada para cima pela marca e subestima o aperto dos produtos de ticket
menor.

| Produto | Ticket | CPA de empate | CPA saudável |
| --- | --- | --- | --- |
| Conta (média) | R$ 318,27 | R$ 159,14 | R$ 79,57 |
| Colágeno (Shopping) | R$ 302,78 | R$ 151,39 | R$ 75,70 |
| Creatina | R$ 298,05 | R$ 149,03 | R$ 74,51 |
| **Colágeno tipo 2** | **R$ 232,95** | **R$ 116,48** | **R$ 58,24** |

**Duas linhas, não uma.** `Ticket × Margem` é onde a mídia empata com a margem
bruta. `Ticket × Margem × 0,50` é o alvo saudável, que deixa metade da margem
para o resto da operação. Entre as duas, a campanha dá lucro bruto mas consome
mais da operação do que deveria — é 🟡 OTIMIZAR, não 🔴 CORTAR.

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

## Economia de contexto

As especificações em `docs/metodologia/` somam cerca de **57 mil tokens** — a de
tráfego sozinha tem 33 mil. Carregá-las inteiras esgota o contexto antes de a
análise começar. Regras que valem sempre:

**Leitura dirigida.** Leia as seções que o pedido exige, não o arquivo inteiro.
Cada agente em `.claude/agents/` traz um mapa de qual seção serve para quê —
use-o. Ler a especificação de tráfego inteira para responder uma pergunta de
orçamento custa mais que a resposta vale.

**Dado tabular se processa, não se lê.** CSV e planilha vão para um script
Python que calcula e imprime só o resultado. Despejar as linhas no contexto
gasta muito e ainda convida a erro de aritmética mental — os números precisam
vir de cálculo, não de leitura.

**Resposta no tamanho da pergunta.** "Qual o ROAS da campanha X" se responde em
uma linha. Tabela completa, ressalvas e plano de ação são para quando a análise
foi pedida. Quando o usuário pedir resposta curta, corte o preâmbulo e entregue
o número com a conclusão.

**Subagente custa um contexto inteiro.** Vale quando o trabalho é grande e
isolável — uma auditoria completa, um relatório. Para ler um CSV e responder uma
pergunta, faça direto.

**Uma análise por sessão.** Conversa longa é o maior consumidor de todos: tudo
que já passou continua sendo reenviado a cada mensagem. Terminou uma análise,
abra sessão nova — o `CLAUDE.md`, a skill e as especificações continuam lá.

## Idioma e formato

Português do Brasil, direto, output-first. Números no padrão BR: vírgula
decimal, milhar com ponto, `R$`. Gasto sempre em R$, taxas sempre em %.
Período real (sem o dia corrente, que está incompleto) no título e no nome de
qualquer arquivo entregue.
