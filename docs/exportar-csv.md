# Como exportar os relatórios do Google Ads

Guia para alimentar os agentes sem depender de API. Siga uma vez e você terá
tudo que a metodologia precisa.

> Os nomes de coluna variam um pouco entre versões da interface do Google Ads.
> Se não achar uma com o nome exato, procure a equivalente — e se não existir na
> sua conta, deixe passar: o agente marca `n/d` em vez de inventar.

## Regras que valem para todos os relatórios

**Período.** Defina o intervalo no canto superior direito. Não inclua **hoje** —
o dia corrente está incompleto e enviesa qualquer comparação. Para comparar,
exporte duas vezes: o período atual e o anterior, com o **mesmo número de dias**.

**Não segmente por dia.** Se você ligar "Segmento → Dia", cada linha vira uma
por data e o arquivo explode. Queremos o **total do período** por entidade.
Exceção: o relatório 7 (sazonalidade), que existe justamente para isso.

**Formato.** Baixe em **.csv**. O botão de download (⬇) fica acima da tabela, no
canto direito.

**Colunas.** Use "Colunas → Modificar colunas" para adicionar as que faltarem.
Vale salvar o conjunto como predefinição — da próxima vez é um clique.

---

## 1 · Campanhas ⭐ obrigatório

**Onde:** Campanhas → Campanhas

| Coluna | Para quê |
| --- | --- |
| Campanha · Tipo de campanha · Status | identificação e separar PMax de Search |
| Orçamento | pacing |
| Custo | base de tudo |
| Impressões · Cliques · CTR · CPC médio | entrega e engajamento |
| Conversões · Taxa de conversão | resultado |
| Custo/conversão | CPA |
| Valor da conversão | receita — **sem isso não existe ROAS** |
| Parcela de impressões de pesquisa | headroom |
| Parcela de impr. perdida (orçamento) | 🟢 verba está limitando |
| Parcela de impr. perdida (classificação) | 🟡 competitividade |

As três últimas são o diagnóstico que separa "falta verba" de "falta lance" —
não pule.

## 2 · Grupos de anúncios ⭐ obrigatório

**Onde:** Campanhas → Grupos de anúncios

Campanha · Grupo de anúncios · Status · Custo · Impressões · Cliques · CTR ·
CPC médio · Conversões · Taxa de conversão · Custo/conv. · Valor da conversão

> No PMax os grupos vêm vazios — é limitação do Google, não erro seu.

## 3 · Palavras-chave ⭐ obrigatório se tem Search

**Onde:** Campanhas → Anúncios e recursos → Palavras-chave de pesquisa

Palavra-chave · Tipo de correspondência · Grupo · Campanha · Status ·
**Índice de qualidade** · Custo · Impressões · Cliques · CTR · CPC médio ·
Conversões · Taxa de conversão · Custo/conv. · Valor da conversão ·
Parcela de impressões · % na parte superior

## 4 · Termos de pesquisa ⭐ obrigatório se tem Search

**Onde:** Campanhas → Insights e relatórios → Termos de pesquisa

Termo de pesquisa · Tipo de correspondência · Palavra-chave · Grupo · Campanha ·
Custo · Impressões · Cliques · Conversões · Valor da conversão

> É aqui que mora o desperdício a negativar e o termo bom a promover. Costuma
> ser o relatório com maior retorno por minuto gasto.

## 5 · Produtos — se tem Shopping ou PMax

**Onde:** Campanhas → Insights e relatórios → Produtos (ou "Produtos" no menu)

Título do item · ID do item · Campanha · Custo · Impressões · Cliques · CTR ·
Conversões · Taxa de conversão · Valor da conversão

> No PMax o produto é a **única alavanca acionável** — grupos e anúncios não são
> expostos. Este relatório abre a caixa-preta.

## 6 · Recursos (criativos) — se quer análise de criativo

**Onde:** Campanhas → Anúncios e recursos → Recursos

Recurso · Tipo de recurso · Grupo de recursos · Campanha ·
**Classificação de desempenho** (Baixo/Bom/Melhor) · Impressões · Cliques

Na aba **Anúncios**, pegue também a **Força do anúncio** por RSA.

> Traz o metadado, não o arquivo da imagem. Para julgar o criativo em si, anexe
> as imagens junto no chat.

## 7 · Ações de conversão 🚨 o mais importante

**Onde:** Metas → Resumo (ou Conversões → Ações de conversão)

Nome da ação · Categoria · Status · **Origem** ·
**Incluir em "Conversões"** (sim/não) · Contagem (uma/todas) ·
Janela de conversão · Modelo de atribuição · Conversões · Valor

> Este é o **Pilar 0**, o gate da metodologia. Se a conversão estiver mal
> configurada — valor fixo, contagem errada, ação duplicada — o CPA e o ROAS da
> conta inteira estão mentindo, e nenhuma recomendação de verba se sustenta.
> **Exporte este mesmo que não exporte os outros.**

## 8 · Opcionais (quando a análise pedir)

| Relatório | Onde | Para quê |
| --- | --- | --- |
| Dispositivo | Campanhas → segmento Dispositivo | gap mobile × desktop |
| Geográfico | Insights e relatórios → Locais | praças que convertem |
| Hora e dia | Insights e relatórios → Programação | sazonalidade intradiária |

---

## Depois de exportar

Anexe os arquivos direto na conversa (clipe 📎 no campo de mensagem). Pode
mandar todos de uma vez, junto com as imagens se houver.

Diga sempre **qual é o período** de cada arquivo — o nome que o Google dá nem
sempre deixa claro, e período errado é a forma mais fácil de uma análise sair
errada sem ninguém perceber.

Se quiser guardar o histórico de exports no repositório, salve em
`dados/renovabe/<AAAA-MM>/`. A pasta é ignorada pelo git por padrão (são dados
de conta de cliente) — veja `dados/README.md` para mudar isso.
