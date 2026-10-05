# Importação · Campanha Colágeno Tipo II

**Campanha:** `01_vendas_search_colageno-tipo2_fundo_max-conv_articulacoes_out2026`
**Gerado em:** 05/10/2026

## ⚠️ A campanha vem PAUSADA

O arquivo `01-campanha.csv` traz `Status = Paused` de propósito. Importe,
revise tudo dentro do Editor e só então ative. Campanha importada e ativa no
mesmo movimento é como se descobre erro gastando dinheiro.

## Nomenclatura

Segue o padrão da conta, com o segmento de data acrescentado no fim:

```
NN_objetivo_canal_produto_funil_lance_detalhe_mmmAAAA
01_vendas_search_colageno-tipo2_fundo_max-conv_articulacoes_out2026
                                                             └── novo
```

Underscore separa segmento, hífen une palavras dentro do segmento, tudo
minúsculo — igual ao resto da conta.

## Ordem de importação

No Google Ads Editor: **Conta → Importar → Do arquivo**. Importe nesta ordem,
porque cada arquivo depende do anterior existir:

| # | Arquivo | O que cria |
| --- | --- | --- |
| 1 | `01-campanha.csv` | a campanha, orçamento, lance, rede |
| 2 | `02-grupos.csv` | 6 grupos — o `06_Formula_Comparacao` vem pausado (segunda onda) |
| 3 | `03-palavras-chave.csv` | 50 palavras-chave (exata + frase) |
| 4 | `04-negativas-campanha.csv` | 70 negativas no nível campanha, com coluna de polaridade |
| 5 | `05-anuncios-rsa.csv` | 12 RSAs (2 por grupo) |

Depois de importar tudo: **Publicar**.

## Conferir antes de ativar

- [ ] **Localização:** Brasil, com "Presença: pessoas no local". Não vem no CSV —
      configure na interface. Sem isso você paga clique de fora do país.
- [ ] **🔴 PRIMEIRO DE TUDO — conferir as negativas no Editor.** Depois de
      importar o arquivo 04, confirme que as 70 linhas apareceram em
      **"Palavras-chave negativas"** e não em "Palavras-chave". Se entrarem como
      positivas, você sobe anúncio para `pele`, `cachorro`, `remedio` e
      `youtube`. Não publique sem checar isso com os próprios olhos.
- [ ] **Negativas cruzadas — só contra as campanhas de Verisol.** Adicione os
      termos de tipo 2 como negativa em `01_Colageno_Verisol`,
      `01_Colageno_Verisol_emagrecimento` e `02_Verisol_Intencao`. São Search
      contra Search, mesmo leilão.
      **Não negative no Shopping.** O grupo `tipo-2` do Shopping entrega CPA de
      R$ 89,83 — 14% melhor que o Search que esta campanha substitui. Shopping e
      Search ocupam posições diferentes da SERP e podem aparecer na mesma busca;
      cegar o Shopping desligaria o canal mais eficiente do produto para
      proteger o menos eficiente.
- [ ] **Verificar o Shopping de colágeno antes de subir.** A campanha
      `01_vendas_shopping_colageno...2025-todos-produtos` gasta
      **R$ 149.968,64/mês** com ROAS 3,55. Se o SKU do Tipo II estiver nesse
      feed, ela é o maior concorrente interno desta campanha — quatro vezes
      maior que todos os outros somados. Confira no Merchant Center.
- [ ] **Pausar `03_Tipo2_Articulacoes`** na campanha `02_vendas_search_generico`.
      Esta campanha o substitui — manter os dois sobe o próprio CPC.
- [ ] **Extensões:** sitelinks, frases de destaque e snippets não vêm no CSV.
      A lista está em `docs/campanhas/search-colageno-tipo2-articulacoes.md`.
- [ ] **Força do anúncio** ao menos "Boa" em cada RSA.
- [ ] **🔴 Conversão — isto é um gate, não um item de lista.** O `CLAUDE.md`
      manda congelar decisão de verba enquanto a mensuração não for validada, e
      ela não foi. Com **Maximizar valor de conversão**, o algoritmo lê o sinal
      de conversão a cada leilão: se houver micro-conversão ou valor errado no
      conjunto de metas, ele otimiza para a coisa errada desde o primeiro dia.
      Confira quais ações de conversão estão nas metas padrão da conta e se a
      campanha nova vai herdá-las. Indício de risco: 56% das conversões da conta
      (4.548 de 8.055) vêm da campanha de marca, com CPA de R$ 12,03.

## Por que a campanha vem assim

| Decisão | Motivo |
| --- | --- |
| Orçamento R$ 235/dia | igual ao gasto atual do grupo que ela substitui |
| **Maximizar valor de conversão** | toda a análise é de valor (ticket, mix de kit, ROAS). Maximizar *conversões* perseguiria a conversão mais barata — o pote avulso de R$ 117,70 — e empurraria o ticket para baixo, derrubando junto o CPA que você pode pagar |
| Só Rede de Pesquisa | parceiros e Display diluem o CPA |
| Sem grupo de marca | a campanha de marca entrega ROAS 28,16 e CPA R$ 11,63 — canibalizá-la troca conversão barata por cara |
| Copy sem "dor" | o Google já reprovou criativo de dor articular nesta conta; o grupo `tipo-2_dor-articular_remarketing` está com zero impressões há 30 dias |

## Alvo

Com margem de 50% e ticket de R$ 232,95 para o tipo 2:

- **CPA de empate:** R$ 116,48
- **CPA saudável:** R$ 58,24
- **CPA hoje (grupo que ela substitui):** R$ 104,63

A campanha entra 🟡 OTIMIZAR. **Não abra orçamento até o CPA cruzar R$ 80.**

### ⚠️ Espere o CPA SUBIR nas primeiras semanas

O CPC de R$ 2,86 do grupo atual é um CPC **sufocado**: ele roda dentro de
`02_vendas_search_generico`, que usa CPA desejado e está marcada pelo Google
como *"limitado pelo tipo de estratégia de lances"* — gasta R$ 2.263,63/dia de
um orçamento de R$ 5.100.

Esta campanha remove esse teto. Tirar uma trava de tCPA **sobe** CPC e CPA em
troca de volume — é o mecanismo, não acaso. Entre esperando CPA acima de
R$ 104,63 nas primeiras duas a três semanas, e não trate isso como fracasso.

Se preferir não perder o chão, suba com tCPA em R$ 116 (o ponto de empate) em
vez de lance livre.

## Primeiros 30 dias

| Quando | O quê |
| --- | --- |
| Dia 3 | checar reprovação por política **e quanto a campanha está gastando**. Se gastar menos de R$ 150/dia, o problema é cobertura (50 palavras-chave restritas num nicho estreito, com 70 negativas por cima) e não lance — abra 2 ou 3 amplas nos grupos de média intenção |
| Dia 7 | primeira mineração de termos de pesquisa |
| Dia 14 | comparar CTR contra os 4,99% do grupo antigo — é a métrica da tese |
| Dia 30 | avaliar CPA contra o alvo. Só então decidir escala |

Não mexa em lance nos primeiros 7 dias: campanha nova entra em aprendizado e
alterar lance reinicia o ciclo.
