# 06 · Escolher o app pronto

**Objetivo:** escolher bem o que publicar e entender do que o app precisa para rodar.

## O app: EcoColeta

| Item | Resposta |
|---|---|
| Nome | EcoColeta |
| O que faz | App de zeladoria urbana: o cidadão pede a coleta de descartes específicos (eletrônicos, entulho, recicláveis) informando tipo, volume, endereço e foto, e acompanha o pedido. |
| Origem | Projeto que desenvolvi com a minha equipe (Guilherme, Geovanni e João Wilson) na disciplina de desenvolvimento mobile. Código em https://github.com/rafaellourenco10/ecocoleta_app (app Flutter e site); a API fica em um repositório privado. |
| Licença | **MIT**, no arquivo `LICENSE` do repositório. Permite usar, copiar, modificar e distribuir, desde que o aviso de copyright seja mantido. |

Como o app é nosso, adicionei a licença MIT ao repositório antes de publicar, para deixar explícito que o uso é permitido.

## Motivo da escolha

- É um app **mobile real com parte de servidor**, exatamente o caso da pista "pense no que de fato fica no servidor".
- Conheço o código. Assim, o foco do trabalho ficou em nuvem e entrega, e não em entender um app novo.
- Ele já tinha passado por uma migração (PHP e MySQL locais para Node.js e Firestore), o que me deu problemas reais para documentar.
- A stack é leve (Node.js, HTML estático e um banco gerenciado) e cabe toda em planos gratuitos.

## O que fica em cada lugar

| Parte | Tecnologia | Onde roda |
|---|---|---|
| App Android | Flutter | No celular do usuário. O APK é distribuído pelo **GitHub Releases**; o site tem o botão de download. |
| Site (landing page) | HTML e CSS puros, sem build (pasta `site/`) | **Netlify** |
| API | Node.js e Express 5 | **Render**, como Web Service |
| Banco de dados | Cloud Firestore | **Firebase**, em `southamerica-east1` |

## Requisitos para rodar

| Requisito | Valor |
|---|---|
| Runtime | Node.js 18 ou mais novo, e npm |
| Dependências | `express`, `firebase-admin`, `bcryptjs`, `cors`, `dotenv` |
| Porta | a que o Render informa em `PORT` (3000 no meu PC) |
| Banco | Cloud Firestore do projeto `ecocoleta-27def`, coleções `usuarios` e `coletas` |
| Variáveis | `PORT` e `FIREBASE_SERVICE_ACCOUNT_PATH` (caminho da chave) |
| Segredo | arquivo JSON da service account do Firebase, fora do Git |
| Tamanho das requisições | até 2 MB, porque a foto da coleta vai em base64 dentro do JSON |
| App | URL da API em `lib/core/api_constants.dart`, que pode ser trocada sem editar código com `--dart-define=API_BASE_URL=...` |

## Plano de publicação

1. **Firebase:** criar o banco em São Paulo, com regras bloqueadas, e gerar a chave da service account.
2. **Render:** criar o Web Service ligado ao repositório da API, com a chave como Secret File e a variável apontando para ela.
3. **Netlify:** publicar a pasta `site/` (configuração no `netlify.toml`).
4. **GitHub Releases:** gerar o APK assinado e publicar como release, com o arquivo chamado `app-release.apk`.
5. Fazer tudo isso à mão uma vez (capítulo 07) e depois automatizar com o GitHub Actions (capítulo 08).

## O que deu errado e como corrigi

Ao enviar uma coleta com foto, a API respondia **413 (Payload Too Large)**. A foto vai em base64 dentro do JSON, e o Express aceita só 100 KB por padrão. Aumentei o limite para 2 MB (`express.json({ limit: '2mb' })`). Esse valor ficou como requisito da API.

## Evidência

![Repositório do EcoColeta no GitHub com a licença MIT visível](img/06-licenca.png)

## Fontes

- Repositório do EcoColeta. https://github.com/rafaellourenco10/ecocoleta_app
- Choose a License. *MIT License*. https://choosealicense.com/licenses/mit/
- Express. *express.json()*. https://expressjs.com/en/api.html#express.json
