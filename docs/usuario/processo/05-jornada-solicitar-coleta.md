# Jornada: cidadão solicita a primeira coleta

> **Tipo:** jornada de pessoa usuária, **HIPÓTESE** · **Para:** a equipe decidir o que pesquisar e melhorar · [Voltar ao início](../README.md)

> ⚠️ **Atenção: esta jornada não vem de pesquisa com usuários.** Nenhuma pessoa real foi entrevistada ou observada. As etapas foram montadas a partir do código do app e do site, e as fricções são **suposições** da equipe. O B04-01 proíbe apresentar uma jornada assim como "real". Ela serve para **decidir o que perguntar** no [teste com leitores](06-plano-de-teste-com-leitores.md).

| Campo | Valor |
| --- | --- |
| Público | Cidadão com celular Android que tem um resíduo fora do padrão da coleta comum, como um eletrônico velho |
| Objetivo | Ter um pedido de coleta registrado |
| Canal | Site oficial → APK → app EcoColeta 2.0.0 |
| Evidência | Leitura do código v2.0.0 e do site (Interpretação). **Nenhuma observação nem citação.** |
| Período e método | Novembro de 2026, análise da equipe |

## Etapas

Legenda do tipo de cada afirmação: **(Fato do app)** está confirmado no código; **(Hipótese)** é suposição da equipe, a validar.

| Etapa | Objetivo | Ações e ponto de contato | Perguntas e necessidades prováveis (Hipótese) | Fricções prováveis | Resultado |
| --- | --- | --- | --- | --- | --- |
| 1. Descobrir | Saber que dá para pedir a coleta | Chega ao **site** | "Isso é da prefeitura?" "É de graça?" | (Hipótese) O site não diz quem coleta nem em quanto tempo. **(Fato do app)** Essa informação não existe. | Decide baixar ou desiste |
| 2. Instalar | Ter o app no celular | **Site** → download → **Android** | "É seguro? Por que não está na Play Store?" | (Hipótese) O aviso de "fonte desconhecida" assusta. **(Fato do app)** Não roda no iPhone. | App instalado |
| 3. Criar conta | Conseguir entrar | Tela **Criar Conta** | "Por que pedem meu CPF?" | (Hipótese) Errar o dígito do CPF ou esquecer o DDD do telefone. **(Fato do app)** O cadastro não faz o login automático. | Conta criada |
| 4. Entrar | Chegar à tela inicial | Tela de **login** | "Travou?" | **(Fato do app)** O primeiro acesso pode levar de 20 a 50 s. (Hipótese) A pessoa toca de novo ou fecha o app. | Tela inicial |
| 5. Descrever o descarte | Explicar o que vai ser coletado | Tela **Nova Solicitação** | "Qual tipo é o meu?" "Quanto é 0,5 m³?" "O que é enfardado?" | (Hipótese) Não sabe estimar o volume. **(Fato do app)** Não há opção "Outro" nem foto da galeria, e o endereço não vem preenchido. | Formulário preenchido |
| 6. Confirmar | Enviar o pedido | Botão **Confirmar Solicitação** | "E agora, quando vem?" | **(Fato do app)** Não há data, situação nem contato depois do envio. (Hipótese) Sensação de "enviei para o nada". | Pedido registrado |
| 7. Acompanhar | Saber se vão buscar | **Minhas Coletas** | "Já foi visto? Já coletaram?" | **(Fato do app)** A lista mostra só tipo e endereço. O número no botão é o total de solicitações, e não o de coletas pendentes. (Hipótese) A pessoa espera que o número diminua quando a coleta for feita. | Sem informação nova |

## Onde a documentação entra

| Etapa | Página que responde |
| --- | --- |
| 2 | [Instalar o app](../guia/02-instalar-o-app.md) |
| 3–6 | [Sua primeira coleta](../guia/01-primeira-coleta.md), [Campos e regras](../guia/07-campos-e-regras.md) |
| 4 | [Como funciona: por que demora](../guia/06-como-funciona.md#por-que-o-primeiro-acesso-demora) |
| 5 | [Tipos de resíduo e dicas](../guia/08-residuos-e-dicas.md) |
| 1, 6, 7 | Sem resposta possível ainda: [lacunas L1–L3](08-lacunas-e-decisoes.md) |

## Lacunas de pesquisa

- Não sabemos **quem** é o usuário real: idade, familiaridade com apps, pessoa física ou empresa.
- Não sabemos **quais resíduos** as pessoas mais querem descartar.
- Não sabemos se a falta de acompanhamento (etapas 6 e 7) **realmente** incomoda.

## Oportunidades a validar

Estas são ideias e **não soluções aprovadas**. Cada uma precisa de evidência antes de virar tarefa.

1. Mostrar no site e no app quem coleta e o prazo (depende da lacuna L1).
2. Situação do pedido em Minhas Coletas.
3. Opção "Outro" no tipo de resíduo e foto da galeria.
4. Preencher o endereço da coleta com o endereço do cadastro.
5. Exemplos visuais de volume (sacos, caixas).
