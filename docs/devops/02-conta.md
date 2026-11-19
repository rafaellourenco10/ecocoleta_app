# 02 · Criar a conta com segurança e controle de gastos

**Objetivo:** deixar o acesso protegido e o gasto sob controle antes de colocar qualquer dado do app na nuvem.

## Contas e projeto

| Serviço | O que criei |
|---|---|
| Google (Firebase) | Projeto `ecocoleta-27def` no console do Firebase, com a minha Conta Google |
| Render | Conta com login pelo GitHub e um Web Service para a API |
| Netlify | Conta com login pelo GitHub e um site para a pasta `site/` |
| GitHub | Repositórios do app (público) e da API (privado) |

![Projeto do EcoColeta no console do Firebase (dados pessoais ocultos)](img/02-conta.png)

## Região escolhida: São Paulo (`southamerica-east1`)

Criei o banco Cloud Firestore na região **`southamerica-east1`**, em São Paulo.

- **Ela não pode ser trocada depois.** A documentação diz que, depois de criado o banco, a localização não muda. Trocar significaria criar outro banco e migrar todos os dados.
- **Latência e dados no país.** Os usuários do EcoColeta estão no Brasil, e o banco guarda nome, CPF/CNPJ, endereço e telefone. Com o banco em São Paulo, os dados ficam no Brasil e perto dos usuários.
- **Contra:** uma região única custa menos e é mais rápida, mas é menos resistente a falhas que uma multirregião (como `nam5`, nos EUA). Para um app pequeno, a região única basta.

O Render não tem região na América do Sul, então a API roda nos EUA. Comento isso nas limitações do capítulo 09.

## Medidas de segurança

| Medida | Por quê |
|---|---|
| Verificação em duas etapas na Conta Google | A Conta Google é dona do projeto do Firebase. Com a senha vazada, ainda falta o meu celular. |
| Verificação em duas etapas no GitHub | O GitHub entra no Render e na Netlify, e guarda o código e os secrets do pipeline. |
| Códigos de recuperação guardados fora do computador | Para não perder o acesso se eu perder o celular. |
| Chave do Firebase fora do Git | O arquivo da *service account* está no `.gitignore` e só existe no meu PC e no Render (capítulo 04). |
| Regras do Firestore negando acesso direto | Ninguém lê nem grava no banco sem passar pela API (capítulo 03). |

![Verificação em duas etapas ativa na Conta Google](img/02-seguranca.png)

## Controle de gastos

O projeto está no plano **Spark**, que **não tem conta de faturamento**. Por isso não existe orçamento para configurar: o alerta de orçamento do Google Cloud só existe quando há faturamento ligado. Neste caso, o controle é o próprio plano. O limite é rígido: se a cota acabar, o Firestore para até a cota renovar, e nenhuma cobrança é gerada.

Para acompanhar o consumo, uso o painel **Uso e faturamento** do Firebase e a aba **Uso** do Firestore, que mostram leituras, gravações e exclusões do dia em relação à cota gratuita. No Render e na Netlify, também não cadastrei forma de pagamento: se um limite for ultrapassado, o serviço é suspenso em vez de cobrar.

Se um dia eu precisar do plano Blaze, o primeiro passo será criar no Cloud Billing um orçamento de US$ 1 com alertas em 50%, 90% e 100%. O alerta só **avisa** e não bloqueia o gasto, então eu precisaria agir ao receber o e-mail.

![Plano Spark e painel de uso, sem faturamento ligado](img/02-gastos.png)

## O que deu errado e como corrigi

Ao criar o banco, o console sugeria uma região dos EUA. Antes de confirmar, li que a localização é permanente e troquei para `southamerica-east1`. Se eu tivesse aceitado o padrão, a única forma de mudar seria criar um banco novo e migrar os dados.

## Fontes

- Firebase. *Cloud Firestore locations*. https://firebase.google.com/docs/firestore/locations
- Firebase. *Firebase pricing plans*. https://firebase.google.com/docs/projects/billing/firebase-pricing-plans
- Firebase. *Avoid surprise bills*. https://firebase.google.com/docs/projects/billing/avoid-surprise-bills
- Google. *Turn on 2-Step Verification*. https://support.google.com/accounts/answer/185839
- GitHub Docs. *Configuring two-factor authentication*. https://docs.github.com/en/authentication/securing-your-account-with-two-factor-authentication-2fa/configuring-two-factor-authentication
