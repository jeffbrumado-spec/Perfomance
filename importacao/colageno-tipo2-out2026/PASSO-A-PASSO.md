# Passo a passo — subir a campanha

Leia uma linha por vez. Não pule etapa.

---

## ANTES: baixe o programa

A campanha não sobe pelo site do Google Ads. Sobe por um programa gratuito
chamado **Google Ads Editor**.

👉 Baixe em: https://ads.google.com/intl/pt-BR_br/home/tools/ads-editor/

Instale e abra. Faça login com a mesma conta que você usa no Google Ads.

---

## PASSO 1 — Baixe os 7 arquivos

Clique em cada arquivo que eu mandei no chat e salve todos **na mesma pasta**
do seu computador. Pode ser a Área de Trabalho.

Você vai ter:

```
01-campanha.csv
02-grupos.csv
03-palavras-chave.csv
04-negativas-campanha.csv
05-anuncios-rsa.csv
LEIA-ME.md
PASSO-A-PASSO.md   ← este aqui
```

---

## PASSO 2 — Puxe a conta para o Editor

No Google Ads Editor:

1. Clique em **Obter dados recentes** (botão no canto superior esquerdo)
2. Escolha a sua conta
3. Espere carregar

> Isso baixa tudo o que já existe na conta. Precisa ser feito antes de importar,
> senão o Editor não sabe onde encaixar as coisas novas.

---

## PASSO 3 — Importe os arquivos, UM POR VEZ, NESTA ORDEM

Para cada arquivo, faça a mesma coisa:

1. Menu de cima: **Conta** → **Importar** → **Do arquivo**
2. Escolha o arquivo
3. O Editor mostra uma tela de confirmação. Leia e clique em **Concluir e
   revisar alterações**

**A ordem importa.** Cada arquivo precisa do anterior já estar lá:

| Ordem | Arquivo | O que ele cria |
|---|---|---|
| 1º | `01-campanha.csv` | a campanha |
| 2º | `02-grupos.csv` | os 6 grupos |
| 3º | `03-palavras-chave.csv` | as 50 palavras-chave |
| 4º | `04-negativas-campanha.csv` | as 70 palavras bloqueadas |
| 5º | `05-anuncios-rsa.csv` | os 12 anúncios |

Se der erro em algum, pare e me mande o print. Não tente adivinhar.

---

## PASSO 4 — 🔴 A CONFERÊNCIA MAIS IMPORTANTE

Depois de importar o arquivo 4, faça isto **antes de continuar**:

1. Na lista da esquerda, clique na campanha nova
2. Procure a aba **Palavras-chave negativas**
3. Conte: devem aparecer **70 palavras** lá dentro

**Se as 70 palavras aparecerem na aba "Palavras-chave" (sem o "negativas"),
PARE.** Está errado. Me avise.

> Por quê: essas 70 palavras são as que você **não** quer. Coisas como `pele`,
> `cachorro`, `remédio`, `youtube`. Se entrarem no lugar errado, você vai pagar
> anúncio para quem procura ração de cachorro.

---

## PASSO 5 — Configure o local

Isso não vem nos arquivos. Tem que fazer na mão.

1. Clique na campanha nova
2. Procure **Locais** (ou "Segmentação por local")
3. Adicione: **Brasil**
4. Procure a opção de **presença** e escolha:
   **"Presença: pessoas que estão no local segmentado"**

> Por quê: sem isso você paga clique de gente de fora do Brasil que nunca vai
> comprar.

---

## PASSO 6 — Publique

1. Botão **Publicar** (canto superior direito)
2. Confirme

Pronto. A campanha está no Google Ads.

---

## PASSO 7 — Ela está PAUSADA. É de propósito.

Agora entre no site do Google Ads (ads.google.com) e confira com calma:

- [ ] Os 6 grupos apareceram?
- [ ] As palavras-chave estão nos grupos certos?
- [ ] Os anúncios aparecem sem erro de política?
- [ ] O orçamento está **R$ 235 por dia**?

**Quando tudo estiver conferido, aí sim você ativa a campanha.**

---

## O QUE NÃO FAZER

❌ **Não aumente o orçamento** nas primeiras semanas. R$ 235/dia e só.

❌ **Não mexa em lance nos primeiros 7 dias.** Campanha nova está aprendendo.
   Mexer faz ela recomeçar do zero.

❌ **Não se assuste se o custo por venda subir** nas primeiras 2 ou 3 semanas.
   Isso é esperado — a campanha antiga tinha um freio que esta não tem.

---

## O QUE OLHAR DEPOIS

| Quando | O que fazer |
|---|---|
| **Dia 3** | Algum anúncio foi reprovado? E quanto ela gastou? Se gastou menos de R$ 150/dia, me avise |
| **Dia 7** | Me mande o relatório de **termos de pesquisa** — vou achar o que está desperdiçando |
| **Dia 14** | Me mande o relatório de **grupos de anúncios** |
| **Dia 30** | Avaliamos juntos se vale aumentar a verba |

---

## AINDA FALTA UMA COISA

Antes de **ativar** (não de importar), me mande o relatório de **ações de
conversão**:

> No Google Ads: **Metas** → **Resumo**, e baixe em CSV

É rápido e é importante: esse relatório diz se o Google está contando as vendas
certas. Se estiver contando errado, a campanha vai otimizar para a coisa errada
desde o primeiro dia.

Pode importar tudo e configurar sem ele. Só não ative.
