# 09 · Validar e refletir

**Objetivo:** comprovar que tudo funciona, que não ficou custo nem recurso esquecido, e registrar o que eu faria diferente.

## Checklist dos três objetivos

| Objetivo | Situação | Evidência |
|---|---|---|
| 1. **Nuvem gratuita**: banco no Firebase (Spark), API no Render e site na Netlify, contas protegidas e custo zero | Cumprido | uso do Firestore dentro da cota (abaixo) |
| 2. **Backend mínimo e seguro**: cinco dependências, banco fechado para acesso direto, app no ar e acessível de qualquer rede | Cumprido | app funcionando pela rede 4G (abaixo) |
| 3. **Pipeline com GitHub**: push, testes e publicação automática, sem abrir nenhum painel | Cumprido | execução verde na aba Actions (abaixo) |

![Objetivo 1: uso do Firestore dentro da cota gratuita, no plano Spark](img/09-uso.png)

![Objetivo 2: EcoColeta funcionando no celular pela rede 4G](img/07-app-4g.png)

![Objetivo 3: pipeline executado com sucesso após um push](img/08-actions-sucesso.png)

## Refazendo o caminho como outra pessoa

Reli a documentação do início e segui os passos do capítulo 07 em um clone limpo da API, como se não conhecesse o projeto. Encontrei um ponto que só funcionava porque eu já tinha feito antes: nenhum lugar dizia que é preciso criar o `.env` da API com `PORT` e `FIREBASE_SERVICE_ACCOUNT_PATH`. Sem ele, a API sobe, mas avisa que não encontrou a credencial do Firebase. O passo agora está no capítulo 05.

## Custo e recursos esquecidos

- **Firebase:** o projeto continua no Spark, sem conta de faturamento. Em **Contas de serviço**, apaguei as chaves antigas geradas durante os testes; ficou só a que está no Render.
- **Google Cloud:** só existe o projeto `ecocoleta-27def`.
- **Render:** um único Web Service; não há serviço antigo de teste esquecido.
- **Netlify:** um único site.
- Nenhum dos três serviços tem forma de pagamento cadastrada.

## Limitações do ambiente gratuito

- **A API "dorme":** depois de 15 minutos sem acesso, o primeiro acesso leva de 20 segundos a 1 minuto (medi 23 s).
- **Distância entre API e banco:** o Render não tem região na América do Sul, então a API roda nos EUA e cada consulta vai até São Paulo e volta.
- **Cotas diárias do Firestore:** 50 mil leituras e 20 mil gravações por dia. Se acabarem, o banco para até a cota renovar.
- **Sem backup automático:** a recuperação a um ponto no tempo (PITR) está desligada e não há exportação programada.
- **Sem SSH e com disco efêmero no Render:** não dá para investigar a máquina por dentro. O diagnóstico depende dos logs.

## Riscos de segurança que restam e melhorias

| Risco | Melhoria |
|---|---|
| A API não tem autenticação por token: quem souber o ID de um usuário consegue ler ou apagar os dados dele. | Usar o Firebase Authentication (gratuito) no app e conferir o token e o dono do dado em cada rota da API. |
| A service account usa o papel padrão do Admin SDK, que tem mais permissões do que a API precisa. | Criar uma service account só com o papel **Cloud Datastore User**. |
| Restam 8 vulnerabilidades moderadas no `uuid`, dentro do `firebase-admin`. | Atualizar o `firebase-admin` para a próxima versão maior e testar. |
| A proteção contra exclusão do banco está desligada. | Ativar a *delete protection* do Firestore. |
| O CORS aceita qualquer origem e não há limite de requisições. | Restringir o CORS e limitar tentativas de login (por exemplo, com `express-rate-limit`). |
| O APK é instalado fora da Play Store. | Publicar na Play Store, que verifica o app e cuida das atualizações. |

## O que eu faria diferente

- Começaria com o **Firebase Authentication** em vez de um login próprio. Senha, hash e tokens ficariam com o Google, e a API só conferiria o token.
- Escreveria **testes na API** antes do pipeline. Hoje a etapa de CI dela só confere a sintaxe.
- Colocaria a API **perto do banco**, em um serviço com região em São Paulo, quando o app tiver uso que justifique sair do plano gratuito.

## Aprendizados

O que mais me marcou foi perceber que "usar a nuvem" não tira a responsabilidade de segurança, só muda o lugar dela. Mesmo sem servidor próprio, precisei decidir a região do banco sabendo que não poderia trocar depois, entender que as regras do Firestore não protegem a API, guardar a chave da service account fora do Git e corrigir senhas que estavam em texto puro. Também aprendi a ler o erro de verdade: uma mensagem genérica de "erro 500" escondia que o banco nem tinha sido criado. Por fim, montar o pipeline mostrou que o deploy automático que eu já tinha não era seguro, porque publicava sem testar. CD de verdade é publicar só o que passou pelo CI.

## Fontes

- Firebase. *Usage and limits* (Cloud Firestore). https://firebase.google.com/docs/firestore/quotas
- Firebase. *Firebase Authentication*. https://firebase.google.com/docs/auth
- Google Cloud. *Firestore roles and permissions*. https://cloud.google.com/firestore/docs/security/iam
- Google Cloud. *Protect databases from deletion*. https://cloud.google.com/firestore/docs/manage-databases#delete_protection
- Render. *Deploy for Free*. https://render.com/docs/free
