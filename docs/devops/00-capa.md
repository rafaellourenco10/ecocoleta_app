# EcoColeta na nuvem: do repositório ao ar

**Trabalho de DevOps: Cloud + CI/CD** · Rafael R. Lourenço · outubro de 2026

| Item | Endereço |
|---|---|
| Repositório | https://github.com/rafaellourenco10/ecocoleta_app |
| Arquivos `.md` deste trabalho | pasta `docs/devops/` do repositório |
| Site do app | https://ecocoleta-app.netlify.app |
| API do app | https://ecocoleta-api-imd4.onrender.com |
| Download do app (APK) | https://github.com/rafaellourenco10/ecocoleta_app/releases/latest/download/app-release.apk |

## Resumo

Neste trabalho publiquei o **EcoColeta**, app de coleta de resíduos que desenvolvi com a minha equipe, usando serviços de nuvem gratuitos. Os dados ficam no **Firebase Cloud Firestore**, em São Paulo. A API em Node.js roda no **Render**, o site na **Netlify** e o APK no **GitHub Releases**. A cada `push` no GitHub, o **GitHub Actions** roda os testes e, se eles passarem, publica a nova versão sozinho.

Pesquisei também o Oracle Cloud Free Tier, que oferece uma máquina virtual gratuita, e comparo as duas opções no capítulo 01. Escolhi serviços gerenciados porque o EcoColeta é pequeno e não justifica administrar um servidor. Por isso, os capítulos sobre rede, instância e servidor tratam de como esses conceitos aparecem no Firebase e no Render.

## Sumário

| Nº | Capítulo | Nº | Capítulo |
|---|---|---|---|
| 01 | Entender o plano gratuito da nuvem | 06 | Escolher o app pronto |
| 02 | Criar a conta com segurança e controle de gastos | 07 | Publicar o app manualmente |
| 03 | Entender e montar a rede | 08 | Montar o CI/CD com GitHub |
| 04 | Criar o banco e a chave de acesso | 09 | Validar e refletir |
| 05 | Deixar o backend mínimo e seguro | | |

Cada capítulo segue a mesma ordem: objetivo, o que eu fiz, o que deu errado e como corrigi, evidências e fontes. Nos recortes de tela escondi senhas, chaves e dados pessoais.

## Uso de IA

Usei o assistente Claude (Anthropic) como apoio para revisar a redação e conferir a sintaxe de comandos e dos workflows. A execução, os testes e as decisões registradas aqui são meus. As fontes de cada assunto estão no fim de cada capítulo.
