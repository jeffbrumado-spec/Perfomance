# Importação · Campanha Colágeno Tipo II

**Campanha:** `01_vendas_search_colageno-tipo2_fundo_max-conv_articulacoes_20261005`
**Gerado em:** 05/10/2026

## ⚠️ A campanha vem PAUSADA

O arquivo `01-campanha.csv` traz `Status = Paused` de propósito. Importe,
revise tudo dentro do Editor e só então ative. Campanha importada e ativa no
mesmo movimento é como se descobre erro gastando dinheiro.

## Nomenclatura

Segue o padrão da conta, com o segmento de data acrescentado no fim:

```
NN_objetivo_canal_produto_funil_lance_detalhe_AAAAMMDD
01_vendas_search_colageno-tipo2_fundo_max-conv_articulacoes_20261005
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
| 2 | `02-grupos.csv` | os 6 grupos de anúncios |
| 3 | `03-palavras-chave.csv` | 51 palavras-chave (exata + frase) |
| 4 | `04-negativas-campanha.csv` | 48 negativas no nível campanha |
| 5 | `05-anuncios-rsa.csv` | 12 RSAs (2 por grupo) |

Depois de importar tudo: **Publicar**.

## Conferir antes de ativar

- [ ] **Localização:** Brasil, com "Presença: pessoas no local". Não vem no CSV —
      configure na interface. Sem isso você paga clique de fora do país.
- [ ] **Negativas cruzadas:** adicione `colageno tipo 2`, `articulacao`, `joelho`
      e `cartilagem` como negativas nas campanhas de Verisol (tipo 1) e no
      Shopping, senão elas disputam o mesmo leilão que esta.
- [ ] **Pausar `03_Tipo2_Articulacoes`** na campanha `02_vendas_search_generico`.
      Esta campanha o substitui — manter os dois sobe o próprio CPC.
- [ ] **Extensões:** sitelinks, frases de destaque e snippets não vêm no CSV.
      A lista está em `docs/campanhas/search-colageno-tipo2-articulacoes.md`.
- [ ] **Força do anúncio** ao menos "Boa" em cada RSA.
- [ ] **Conversão** ativa e com valor dinâmico (Pilar 0 ainda não foi validado
      nesta conta).

## Por que a campanha vem assim

| Decisão | Motivo |
| --- | --- |
| Orçamento R$ 235/dia | igual ao gasto atual do grupo que ela substitui — permite comparar o efeito da LP sem confundir com efeito de verba |
| Maximizar conversões, sem tCPA | tCPA irreal sufoca entrega; é o que já trava o `02_vendas_search_generico` |
| Só Rede de Pesquisa | parceiros e Display diluem o CPA |
| Sem grupo de marca | a campanha de marca entrega ROAS 28,16 e CPA R$ 11,63 — canibalizá-la troca conversão barata por cara |
| Copy sem "dor" | o Google já reprovou criativo de dor articular nesta conta; o grupo `tipo-2_dor-articular_remarketing` está com zero impressões há 30 dias |

## Alvo

Com margem de 50% e ticket de R$ 232,95 para o tipo 2:

- **CPA de empate:** R$ 116,48
- **CPA saudável:** R$ 58,24
- **CPA hoje (grupo que ela substitui):** R$ 104,63

A campanha entra 🟡 OTIMIZAR. **Não abra orçamento até o CPA cruzar R$ 80.**

## Primeiros 30 dias

| Quando | O quê |
| --- | --- |
| Dia 3 | checar reprovação por política — risco nº 1 nesta conta |
| Dia 7 | primeira mineração de termos de pesquisa |
| Dia 14 | comparar CTR contra os 4,99% do grupo antigo — é a métrica da tese |
| Dia 30 | avaliar CPA contra o alvo. Só então decidir escala |

Não mexa em lance nos primeiros 7 dias: campanha nova entra em aprendizado e
alterar lance reinicia o ciclo.
