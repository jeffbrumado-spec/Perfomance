# Modelo de pedido do developer token

Mensagem pronta para enviar a quem administra a conta do Google Ads, quando
você não tem acesso administrativo e a Central de API não aparece para você.

---

Oi [nome],

Preciso de um código da conta do Google Ads para conectar uma ferramenta de
análise de relatórios. Chama-se **token de desenvolvedor**, e só aparece para
quem é administrador — por isso não consigo pegar sozinho.

**Onde encontrar (leva 2 minutos):**

1. Entre em ads.google.com com a conta administradora
2. No topo, clique no ícone de ferramenta (chave inglesa) → **Configuração** →
   **Central de API**
3. Copie o campo **Token de desenvolvedor**
4. Na mesma tela aparece o **nível de acesso**. Me diga qual está: *Teste*,
   *Básico* ou *Padrão*

**Também preciso de duas coisas simples:**

- O **ID da conta** que vou analisar — 10 dígitos, aparece no canto superior
  da tela (ex.: 123-456-7890)
- Confirmar que o meu e-mail tem acesso de leitura a essa conta

**Sobre segurança:** esse código sozinho não abre a conta de ninguém. Ele só
identifica o programa que faz a consulta; quem define o que eu consigo ver
continua sendo a permissão do meu login. E a ferramenta é **somente leitura** —
não cria, não pausa e não altera campanha, lance ou orçamento.

Ainda assim é um dado confidencial: pode me mandar por mensagem privada ou
gerenciador de senhas, em vez de e-mail aberto ou grupo?

Obrigado!

---

## Se a resposta for "nível Teste"

Um token no nível *Teste* só consulta contas de teste — não lê a conta real.
Nesse caso peça ao admin para solicitar o nível **Básico** na mesma tela da
Central de API. A aprovação é do Google e costuma levar alguns dias.

## Se o acesso for via conta administradora (MCC)

Peça também o **ID da conta administradora**. Ele vira a variável
`GOOGLE_ADS_LOGIN_CUSTOMER_ID`.
