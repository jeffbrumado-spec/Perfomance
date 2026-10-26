-- =====================================================================
-- Conciliação GA4 × Google Ads · 19 a 25/10/2026
-- Pergunta: os R$ 417,8 mil que o Google reivindica cabem no que o site faturou?
--
-- TROQUE DOIS VALORES:
--   PROJETO    -> o project ID do BigQuery
--   PROPERTY   -> o ID numérico da propriedade GA4 (ex.: analytics_123456789)
--
-- O fuso das tabelas é o da propriedade GA4. Confirme que é America/Sao_Paulo
-- antes de comparar com o relatório do Google Ads.
-- =====================================================================


-- ---------------------------------------------------------------------
-- 1 · O TOTAL DO SITE  (roda em qualquer versão do export)
--
-- Se a receita total vier perto ou abaixo de R$ 417,8 mil, o Google está
-- reivindicando quase tudo que o site faturou — incluindo venda que viria
-- de orgânico, direto e CRM. Aí 3,87 é ROAS de plataforma, não caixa.
--
-- Bônus de Pilar 0: se "eventos_purchase" for maior que "transacoes",
-- a tag está disparando a mesma compra mais de uma vez.
-- ---------------------------------------------------------------------
SELECT
  COUNT(*)                                            AS eventos_purchase,
  COUNT(DISTINCT ecommerce.transaction_id)            AS transacoes,
  ROUND(SUM(ecommerce.purchase_revenue), 2)           AS receita_total,
  ROUND(SAFE_DIVIDE(SUM(ecommerce.purchase_revenue),
        COUNT(DISTINCT ecommerce.transaction_id)), 2) AS ticket_medio
FROM `PROJETO.analytics_PROPERTY.events_*`
WHERE _TABLE_SUFFIX BETWEEN '20261019' AND '20261025'
  AND event_name = 'purchase';


-- ---------------------------------------------------------------------
-- 2 · RECEITA POR ORIGEM  (export de 2024 em diante)
--
-- Usa atribuição de último clique da sessão — é a que se compara com o
-- Google Ads. A linha google/cpc é o número a confrontar com os R$ 417,8 mil.
--
-- Se o campo session_traffic_source_last_click não existir na sua propriedade,
-- use a consulta 2-B abaixo.
-- ---------------------------------------------------------------------
SELECT
  COALESCE(session_traffic_source_last_click.manual_campaign.source,
           session_traffic_source_last_click.google_ads_campaign.account_name,
           '(direct)')                                AS origem,
  COALESCE(session_traffic_source_last_click.manual_campaign.medium,
           IF(session_traffic_source_last_click.google_ads_campaign.campaign_id IS NOT NULL,
              'cpc', '(none)'))                       AS midia,
  COUNT(DISTINCT ecommerce.transaction_id)            AS transacoes,
  ROUND(SUM(ecommerce.purchase_revenue), 2)           AS receita,
  ROUND(100 * SAFE_DIVIDE(SUM(ecommerce.purchase_revenue),
        SUM(SUM(ecommerce.purchase_revenue)) OVER ()), 1) AS pct_da_receita
FROM `PROJETO.analytics_PROPERTY.events_*`
WHERE _TABLE_SUFFIX BETWEEN '20261019' AND '20261025'
  AND event_name = 'purchase'
GROUP BY origem, midia
ORDER BY receita DESC;


-- ---------------------------------------------------------------------
-- 2-B · ALTERNATIVA  (export mais antigo, sem session_traffic_source_last_click)
-- ---------------------------------------------------------------------
SELECT
  COALESCE(collected_traffic_source.manual_source, '(direct)') AS origem,
  COALESCE(collected_traffic_source.manual_medium, '(none)')   AS midia,
  COUNT(DISTINCT ecommerce.transaction_id)                     AS transacoes,
  ROUND(SUM(ecommerce.purchase_revenue), 2)                    AS receita
FROM `PROJETO.analytics_PROPERTY.events_*`
WHERE _TABLE_SUFFIX BETWEEN '20261019' AND '20261025'
  AND event_name = 'purchase'
GROUP BY origem, midia
ORDER BY receita DESC;


-- ---------------------------------------------------------------------
-- 3 · MARCA x NÃO-MARCA DENTRO DO GOOGLE PAGO
--
-- Confere o "9% do investimento, 54% da venda" do relatório pelo lado do site.
-- Depende de a UTM de campanha seguir a nomenclatura da conta (branding/vendas).
-- ---------------------------------------------------------------------
SELECT
  CASE
    WHEN LOWER(session_traffic_source_last_click.manual_campaign.campaign_name)
         LIKE '%branding%' THEN 'marca'
    ELSE 'nao-marca'
  END                                                 AS bucket,
  COUNT(DISTINCT ecommerce.transaction_id)            AS transacoes,
  ROUND(SUM(ecommerce.purchase_revenue), 2)           AS receita,
  ROUND(100 * SAFE_DIVIDE(SUM(ecommerce.purchase_revenue),
        SUM(SUM(ecommerce.purchase_revenue)) OVER ()), 1) AS pct
FROM `PROJETO.analytics_PROPERTY.events_*`
WHERE _TABLE_SUFFIX BETWEEN '20261019' AND '20261025'
  AND event_name = 'purchase'
  AND (session_traffic_source_last_click.manual_campaign.medium = 'cpc'
    OR session_traffic_source_last_click.google_ads_campaign.campaign_id IS NOT NULL)
GROUP BY bucket
ORDER BY receita DESC;


-- ---------------------------------------------------------------------
-- 4 · SEMANA ANTERIOR, para o comparativo de -7%
-- ---------------------------------------------------------------------
SELECT
  _TABLE_SUFFIX                                       AS dia,
  COUNT(DISTINCT ecommerce.transaction_id)            AS transacoes,
  ROUND(SUM(ecommerce.purchase_revenue), 2)           AS receita
FROM `PROJETO.analytics_PROPERTY.events_*`
WHERE _TABLE_SUFFIX BETWEEN '20261012' AND '20261025'
  AND event_name = 'purchase'
GROUP BY dia
ORDER BY dia;
