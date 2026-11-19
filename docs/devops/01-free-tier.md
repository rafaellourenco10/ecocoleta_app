# 01 · Entender o plano gratuito da nuvem

**Objetivo:** descobrir o que é gratuito de fato nos serviços de nuvem do EcoColeta, o que expira e onde pode aparecer cobrança, antes de colocar o app no ar.

## A escolha: serviços gerenciados em vez de uma VM

Pesquisei o Oracle Cloud Free Tier, que dá uma máquina virtual gratuita, e comparei com serviços gerenciados. Escolhi os gerenciados porque o EcoColeta é pequeno, e manter um servidor (sistema, firewall, atualizações) daria mais trabalho do que o app precisa. A estrutura ficou assim:

| Parte do app | Serviço | Plano |
|---|---|---|
| Banco de dados | **Firebase Cloud Firestore** (Google) | Spark (gratuito) |
| API em Node.js | **Render** (Web Service) | Free |
| Site (landing page) | **Netlify** | gratuito |
| APK do Android | **GitHub Releases** | gratuito |

O centro de tudo é o Firebase: é onde ficam os usuários e as coletas.

## Resumo do plano gratuito do Firebase

O Firebase tem dois planos:

- **Spark:** gratuito e **sem conta de faturamento**, então não pede cartão. Se a cota de um produto acaba, aquele produto para de funcionar até a cota renovar. Não existe cobrança, porque não há como cobrar.
- **Blaze:** pago conforme o uso. Mantém as mesmas cotas gratuitas, mas cobra o que passar delas. Ligar uma conta de faturamento ao projeto já muda o plano para Blaze sozinho.

O EcoColeta está no **Spark**. O Firestore é o único produto do Firebase que o app usa (a API acessa o banco com o Firebase Admin SDK). A foto da coleta é guardada em base64 dentro do próprio documento, então o app não usa o Cloud Storage.

## Cota gratuita do Cloud Firestore

| Recurso | Limite gratuito |
|---|---|
| Dados armazenados | 1 GiB |
| Leituras de documentos | 50.000 por dia |
| Gravações de documentos | 20.000 por dia |
| Exclusões de documentos | 20.000 por dia |
| Tráfego de saída | 10 GiB por mês |
| Bancos gratuitos | 1 por projeto |

As cotas diárias renovam por volta da meia-noite no horário do Pacífico (EUA), que é o começo da manhã no Brasil.

Os outros serviços também são gratuitos, cada um com seu limite. O Render dá 750 horas de instância por mês e desliga o serviço depois de 15 minutos sem acesso; ele volta no próximo acesso, o que leva cerca de um minuto. A Netlify hospeda o site estático no plano gratuito.

## Riscos de cobrança e como evitar

| Risco | Como evito |
|---|---|
| Ligar uma conta de faturamento ao Firebase, o que muda o plano para Blaze e passa a cobrar o que exceder a cota | O projeto continua no Spark, sem faturamento ligado. No pior caso, o banco para até a cota renovar, mas não gera conta. |
| Achar que o alerta de orçamento limita o gasto no Blaze | A documentação avisa que alerta de orçamento **não** limita o uso nem a cobrança; ele só avisa. Por isso não fiz upgrade. |
| Leituras demais por código ineficiente (por exemplo, listar o banco inteiro) | A API sempre filtra as coletas pelo usuário (`where('usuario_id', '==', ...)`), então cada tela lê só os documentos daquela pessoa. |
| Fotos grandes enchendo o 1 GiB | A API aceita no máximo 2 MB por requisição (`express.json({ limit: '2mb' })`). |
| Passar do limite de banda ou de horas do Render | Sem forma de pagamento cadastrada, o Render suspende o serviço até o mês seguinte, em vez de cobrar. |

## Comparação com outro provedor

| | Firebase (Spark) + Render | Oracle Cloud Free Tier |
|---|---|---|
| O que é gratuito | banco gerenciado (1 GiB, 50 mil leituras/dia) e serviço web gerenciado | até 2 VMs AMD (1/8 de OCPU e 1 GB de RAM cada) ou VMs Arm até 2 OCPUs e 12 GB, 200 GB de disco e 10 TB de saída por mês |
| Prazo | sem prazo | sem prazo (Always Free), mais US$ 300 de crédito por 30 dias |
| Cartão | não pede | pede, para verificar a identidade |
| Quem cuida do servidor | o provedor | eu (sistema, firewall, atualizações) |
| Banco de dados | já incluso (Firestore) | eu instalaria na VM ou usaria o Autonomous Database |
| Ponto fraco | o serviço do Render "dorme" e o primeiro acesso demora | falta de capacidade para Arm e risco de a Oracle recuperar uma VM ociosa por 7 dias |

A Oracle oferece mais máquina, mas exige que eu administre tudo. Para o tamanho do EcoColeta, o Firebase com o Render entrega banco e API funcionando sem servidor para manter.

## O que deu errado e como corrigi

O EcoColeta começou com PHP e MySQL rodando no meu computador (XAMPP). Funcionava no emulador, mas o celular só acessava pela mesma rede Wi-Fi, e nada funcionava pelo 4G. Esse foi o motivo de migrar para a nuvem: o banco foi para o Firestore e a API para o Render, e o app passou a funcionar de qualquer rede.

## Evidência

![Plano Spark e cota de uso do Firestore no console do Firebase](img/01-plano-spark.png)

## Fontes

- Firebase. *Firebase pricing plans*. https://firebase.google.com/docs/projects/billing/firebase-pricing-plans
- Firebase. *Usage and limits* (Cloud Firestore). https://firebase.google.com/docs/firestore/quotas
- Firebase. *Pricing*. https://firebase.google.com/pricing
- Render. *Deploy for Free*. https://render.com/docs/free
- Oracle. *Always Free Resources*. https://docs.oracle.com/en-us/iaas/Content/FreeTier/freetier_topic-Always_Free_Resources.htm
