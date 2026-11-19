# 04 · Criar o banco e a chave de acesso

**Objetivo:** criar o banco do EcoColeta dentro da cota gratuita e dar à API um acesso por chave, nunca por senha.

## Configuração escolhida

| Item | Escolha | Justificativa |
|---|---|---|
| Banco | Cloud Firestore, modo nativo, banco `(default)` | É o único banco gratuito do projeto e não precisa de servidor. Os dados (usuários e coletas) são documentos, o que encaixa no formato do app. |
| Região | `southamerica-east1` (São Paulo) | Capítulo 02. |
| Regras iniciais | modo produção (tudo bloqueado) | O app não acessa o banco direto, então não há motivo para liberar nada. |
| Coleções | `usuarios` e `coletas` | Cada coleta guarda o `usuario_id` de quem pediu. |
| API | Web Service no Render, plano Free, branch `main` | Roda o Node.js sem eu manter servidor; o build é `npm install` e o start é `npm start`. |
| Acesso da API ao banco | chave da service account do Firebase Admin SDK | Acesso por chave. A API nunca usa a minha senha. |

## Chave pública e chave privada

A service account funciona com um **par de chaves**. A **pública** fica com o Google e serve só para conferir. A **privada** está dentro do arquivo JSON que baixei em **Configurações do projeto > Contas de serviço > Gerar nova chave privada**.

Quando a API inicia, o Admin SDK monta um pedido de acesso e o **assina** com a chave privada. O Google confere a assinatura com a pública e devolve um token de acesso temporário. A chave privada nunca é enviada pela rede; só a assinatura viaja.

| Metade | Onde fica |
|---|---|
| Pública | no Google, ligada à service account `firebase-adminsdk-fbsvc@ecocoleta-27def.iam.gserviceaccount.com` |
| Privada | no meu PC, na pasta da API (o arquivo está no `.gitignore`), e no Render como **Secret File**, que fica em `/etc/secrets/` e não aparece no código nem nos logs |

O Google não guarda a chave privada. Se eu perder o arquivo, gero outra e apago a antiga. Se ela vazar, a revogação é a mesma: apagar a chave no console.

## Acesso

O Render não oferece SSH no plano Free. Acompanho a API pelo painel: status do serviço, logs em tempo real e histórico de deploys. Quando a API sobe com a chave certa, o log mostra:

```text
Chave do Firebase carregada via Arquivo (/etc/secrets/firebase-key.json).
✅ Firebase conectado com sucesso.
   Projeto: ecocoleta-27def
Server is running on port 10000
```

## O que deu errado e como corrigi

1. **Erro sem explicação.** Subi a API antes de criar o banco no console. A conexão com o Firebase dava certo, mas o cadastro e o login falhavam com um erro 500 genérico. Para descobrir a causa, melhorei o tratamento de erros: a API passou a traduzir os códigos do Firebase em mensagens claras e a registrar o erro no log.
2. **Erro dentro do tratamento de erro.** A primeira versão dessa tradução quebrou com `TypeError`. Eu chamava `error.code.includes(...)`, mas no Firebase o `code` é um **número** (o padrão do gRPC), e não um texto. Converti para texto antes de comparar (`String(error.code)`).
3. **Banco não criado.** Com a mensagem certa, apareceu o motivo real: "A API do Cloud Firestore está desabilitada ou sem permissão". O projeto existia, mas o banco Cloud Firestore nunca tinha sido criado. Criei o banco em `southamerica-east1` e as consultas passaram a funcionar no mesmo minuto.

## Evidências

![Banco criado no console, com as coleções usuarios e coletas (dados pessoais ocultos)](img/04-banco-dados.png)

![API "Live" no Render, com o log da conexão ao Firebase](img/04-render-live.png)

## Fontes

- Firebase. *Add the Firebase Admin SDK to your server*. https://firebase.google.com/docs/admin/setup
- Google Cloud. *Service accounts overview*. https://cloud.google.com/iam/docs/service-account-overview
- Render. *Environment Variables and Secrets* (Secret Files). https://render.com/docs/configure-environment-variables
- Render. *Deploy for Free* (sem SSH no plano Free). https://render.com/docs/free
