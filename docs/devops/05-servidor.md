# 05 · Deixar o backend mínimo e seguro

**Objetivo:** colocar na API só o necessário, reduzir a superfície de ataque e testar com uma resposta simples antes de ligar o app.

## O que a API usa e por quê

| Dependência | Por quê |
|---|---|
| `express` | Servidor HTTP e rotas da API. |
| `firebase-admin` | Acesso ao Firestore com a service account. |
| `bcryptjs` | Guarda as senhas como hash, nunca em texto puro. |
| `cors` | Libera chamadas da API vindas de navegadores. |
| `dotenv` | Lê o `.env` quando a API roda no meu PC. |

São só cinco dependências diretas. **Não** usei ORM, framework de autenticação, painel administrativo nem banco local: o Firestore é gerenciado e a API só tem oito rotas. No Render, o plano Free já entrega o sistema operacional atualizado pela própria plataforma, então não há sistema para eu manter.

## Comandos usados

Para rodar e testar a API no meu PC:

```bash
cd ecocoleta_api
npm install
# .env (fora do Git):
#   PORT=3000
#   FIREBASE_SERVICE_ACCOUNT_PATH=arquivo-da-service-account.json
npm start
curl http://localhost:3000/        # {"message":"EcoColeta API is running!"}
```

Para atualizar as dependências e conferir as vulnerabilidades conhecidas:

```bash
npm audit --omit=dev   # antes: 16 vulnerabilidades (2 críticas, 3 altas, 10 moderadas, 1 baixa)
npm audit fix
npm audit --omit=dev   # depois: 8 moderadas, todas no pacote uuid usado dentro do firebase-admin
```

As 8 que restaram só somem com `npm audit fix --force`, que troca o `firebase-admin` de versão maior e pode quebrar a API. Deixei registrado para o capítulo 09.

## "Usuário próprio" para o app

A API não usa a minha Conta Google. Ela tem a própria identidade, a service account `firebase-adminsdk-fbsvc`, com uma chave que só existe no Render e no meu PC. Se eu precisar cortar o acesso da API, apago a chave dela, e a minha conta continua intacta.

## Duas camadas de proteção

Sem VM, não há `iptables`. As duas camadas ficam assim:

| Acesso | Camada 1: plataforma e rede | Camada 2: banco (Rules e IAM) |
|---|---|---|
| App ou navegador → API | permitido, só por HTTPS (443) | não se aplica |
| App ou navegador → Firestore direto | a rede do Google aceita a conexão | **negado** pelas Security Rules (`if false`) |
| API → Firestore | saída por HTTPS (443) | **permitido**: service account autenticada |
| Alguém sem a chave → Firestore como administrador | a conexão chega | **negado**: sem a chave privada não há token de acesso |
| Qualquer um → SSH ou shell | **não existe** no plano Free | não se aplica |

Dentro da API, a terceira linha de defesa é o próprio código:

- senhas com hash **bcrypt**, e a API nunca devolve a senha nem o hash;
- e-mail duplicado é recusado com HTTP 409;
- as rotas `PUT` só aceitam os campos permitidos, então ninguém troca o `usuario_id` de uma coleta ou a senha pelo perfil;
- corpo da requisição limitado a 2 MB.

## Teste com uma resposta simples

Antes de ligar o app à API, testei só a rota de status `GET /`, que responde sem tocar no banco. Primeiro no meu PC e depois no endereço público do Render, pelo navegador.

![Resposta HTTP da API no navegador](img/05-resposta-http.png)

## O que deu errado e como corrigi

Revisando a segurança antes de publicar, encontrei três problemas:

1. **Senhas em texto puro.** O cadastro gravava a senha como foi digitada, e o login devolvia o documento inteiro, **com a senha**. Passei a gravar com bcrypt e a remover a senha de todas as respostas. As contas antigas são convertidas para hash no primeiro login.
2. **Atalho de teste no app.** O login do app tinha um atalho com a senha `teste123`, que entrava sem consultar a API. Removi, e o login passou a ser só pela API.
3. **Dependências vulneráveis.** O `npm audit` apontou duas falhas críticas em dependências indiretas. Corrigi com `npm audit fix`, sem trocar versões maiores.

## Fontes

- npm Docs. *npm audit*. https://docs.npmjs.com/cli/commands/npm-audit
- OWASP. *Password Storage Cheat Sheet*. https://cheatsheetseries.owasp.org/cheatsheets/Password_Storage_Cheat_Sheet.html
- Firebase. *Get started with Cloud Firestore Security Rules*. https://firebase.google.com/docs/firestore/security/get-started
- Express. *Production Best Practices: Security*. https://expressjs.com/en/advanced/best-practice-security.html
