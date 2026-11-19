# 07 · Publicar o app manualmente

**Objetivo:** colocar o EcoColeta no ar fazendo cada passo à mão, para entender o que depois será automatizado.

## Passo a passo

### 1. Firebase

1. No console do Firebase, criei o projeto `ecocoleta-27def`.
2. Em **Firestore Database > Criar banco de dados**, escolhi o modo produção e a região `southamerica-east1`.
3. Em **Regras**, publiquei as regras que negam acesso direto (capítulo 03).
4. Em **Configurações do projeto > Contas de serviço**, gerei uma nova chave privada e salvei o JSON na pasta da API, que já está no `.gitignore`.

### 2. API no meu PC

```bash
cd ecocoleta_api
npm install
npm start
curl http://localhost:3000/
curl -X POST http://localhost:3000/api/usuarios/registrar \
  -H "Content-Type: application/json" \
  -d '{"nome":"Teste","email":"teste@exemplo.com","senha":"123456"}'
```

O cadastro de teste apareceu na coleção `usuarios` do console, com a senha em hash. Depois apaguei esse usuário.

### 3. API no Render

Em **New > Web Service**, conectei o repositório `ecocoleta_api`:

| Campo | Valor |
|---|---|
| Runtime | Node |
| Branch | `main` |
| Build Command | `npm install` |
| Start Command | `npm start` |
| Instance Type | Free |
| Secret File | `firebase-key.json`, com o conteúdo do JSON da service account |
| Variável de ambiente | `FIREBASE_SERVICE_ACCOUNT_PATH=/etc/secrets/firebase-key.json` |

Cliquei em **Create Web Service** e acompanhei o log até aparecer `✅ Firebase conectado com sucesso.` Depois testei `https://ecocoleta-api-imd4.onrender.com/` no navegador.

### 4. Site na Netlify

Em **Add new site > Import an existing project**, escolhi o repositório `ecocoleta_app`. O `netlify.toml` na raiz já define que só a pasta `site/` é publicada e que não há comando de build:

```toml
[build]
  base = "site"
  publish = "."
  command = ""
```

### 5. APK no GitHub Releases

```bash
flutter build apk --release
```

Criei a release `v2.0.0` no GitHub e anexei o arquivo `build/app/outputs/flutter-apk/app-release.apk`. O botão do site aponta para `releases/latest/download/app-release.apk`, então sempre baixa a versão mais recente.

## Como o app sobrevive a um reinício

- **O processo não depende de mim.** O Render inicia a API com `npm start` e a reinicia sozinho se ela cair. Não existe terminal meu que, ao fechar, derrube o app.
- **Nenhum dado fica no servidor.** O disco do Render é apagado a cada reinício ou deploy, mas a API não grava nada nele: tudo fica no Firestore. Reiniciar não perde nenhum cadastro nem coleta.
- **O plano Free "dorme".** Depois de 15 minutos sem acesso, o Render desliga a API. O próximo acesso a liga de novo e espera ela subir. Medi **23 segundos** nesse primeiro acesso; os seguintes respondem na hora.

Para provar, usei **Manual Deploy > Restart service** no Render e, sem fazer mais nada, abri o app e vi as coletas que já existiam.

## Endereços públicos e acesso de fora

- API: **https://ecocoleta-api-imd4.onrender.com/**
- Site: **https://ecocoleta-app.netlify.app**
- APK: **https://github.com/rafaellourenco10/ecocoleta_app/releases/latest/download/app-release.apk**

Testei no meu celular com o Wi-Fi desligado, usando a rede 4G, para garantir que o acesso não dependia da minha rede de casa.

![App funcionando no celular pela rede 4G](img/07-app-4g.png)

![Site aberto no celular pela rede 4G](img/07-site-4g.png)

## O que deu errado e como corrigi

1. **Chave só funcionava no meu PC.** A primeira versão lia a chave com `require('../../' + caminho)`, pensando em um arquivo dentro da pasta do projeto. No Render, isso não funcionava. Mudei a configuração para aceitar a chave também por variável de ambiente.
2. **Caminho absoluto do Secret File.** Usei o Secret File do Render, que fica em `/etc/secrets/firebase-key.json`. Como o código juntava `../../` com esse caminho, o resultado apontava para um lugar que não existe e a API não achava a chave. Passei a testar se o caminho é absoluto (`path.isAbsolute`): se for, uso direto; se não, resolvo a partir da pasta do projeto. Assim, o mesmo código funciona no meu PC e no Render.
3. **Primeiro acesso lento.** Testando no celular, o primeiro login parecia travado. Era o Render acordando a API. Documentei no README que o primeiro acesso pode levar de 20 a 50 segundos.

## Fontes

- Firebase. *Add the Firebase Admin SDK to your server*. https://firebase.google.com/docs/admin/setup
- Render. *Web Services*. https://render.com/docs/web-services
- Render. *Environment Variables and Secrets*. https://render.com/docs/configure-environment-variables
- Netlify Docs. *File-based configuration*. https://docs.netlify.com/build/configure-builds/file-based-configuration/
- Flutter. *Build and release an Android app*. https://docs.flutter.dev/deployment/android
