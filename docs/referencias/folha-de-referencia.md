# Folha de referência: estudo das referências técnicas da documentação do EcoColeta

**Atividade:** BIM04, Folha de referência · **Base:** referências citadas no B04-01 e a entrega da prova B04 ([documentação de usuário](../usuario/README.md))
**Equipe:** Rafael R. Lourenço, Guilherme, Geovanni, João Wilson · **Fontes consultadas em:** 08/11/2026

## Objetivo e método

O B04-01 termina com uma lista de referências "para aprofundar". Nesta folha estudamos cada uma delas e respondemos a três perguntas:

1. **O que a fonte diz?** Lemos a página oficial e registramos os conceitos e uma citação literal.
2. **Onde ela aparece na nossa prova?** Ligamos a fonte às páginas que entregamos.
3. **O que ela mostra que ainda falta?** Registramos o que a prova não cumpre ou cumpre só em parte.

Seguimos a regra do próprio B04-01 para referências: informar o **tipo de fonte**, o que ela **sustenta**, os seus **limites** e a **data de consulta**. Quando não lemos uma parte da fonte, isso está dito.

## Quadro-resumo

| Referência | Tipo de fonte | Pergunta que responde | Onde usamos na prova |
| --- | --- | --- | --- |
| Diátaxis | Framework metodológico (não normativo) | Que **tipo** de página o leitor precisa? | Divisão do guia em tutorial, como fazer, referência e explicação |
| OASIS DITA 1.3 | Norma técnica (OASIS Standard) | Como montar a documentação em **tópicos tipados e reutilizáveis**? | Uma tarefa por página; o README funciona como mapa |
| Google Technical Writing | Curso oficial | Como escrever para um **público** específico? | Linguagem do guia; textos de tela em negrito; frases curtas |
| WCAG 2.2 e WAI | Norma W3C (Recommendation) | O conteúdo é **acessível**? | Marcações por extenso, texto alternativo, descrição dos diagramas |
| GOV.UK Service Manual | Guia oficial de governo (não é norma universal) | Como conhecer as **necessidades reais** e mapear a experiência? | Jornada declarada como hipótese; plano de teste com leitores |
| GitHub Docs | Documentação oficial da plataforma | Como o GitHub **mostra** README, Markdown e diagramas? | README de entrada, links relativos, âncoras, Mermaid |
| Write the Docs, *Docs as code* | Guia da comunidade | Como **manter** a documentação junto com o código? | Markdown no Git, conferência automática de links, revisão |

---

## 1. Diátaxis

**Fonte:** diataxis.fr, páginas inicial e *The compass*. Framework metodológico, sem valor de norma; a página não mostra data.

**O que diz.** A documentação atende a **quatro necessidades** diferentes: *tutorials*, *how-to guides*, *reference* e *explanation*. A "bússola" (*compass*) separa essas necessidades por dois eixos:

| | Adquirir conhecimento (*acquisition*, estudo) | Aplicar conhecimento (*application*, trabalho) |
| --- | --- | --- |
| **Ação** (*action*) | Tutorial | Como fazer (*how-to*) |
| **Compreensão** (*cognition*) | Explicação | Referência |

> "A map is most powerful in unfamiliar territory when we also have a compass to guide us." (Diátaxis, *The compass*)

**Como aplicamos.** Cada página do guia tem um único tipo, declarado no cabeçalho:
- [Sua primeira coleta](../usuario/guia/01-primeira-coleta.md) é o tutorial;
- [Editar ou excluir](../usuario/guia/04-editar-ou-excluir-solicitacao.md) é um como fazer;
- [Campos e regras](../usuario/guia/07-campos-e-regras.md) é referência;
- [Como funciona](../usuario/guia/06-como-funciona.md) é explicação.

O README da documentação organiza a entrada pelas mesmas quatro necessidades ("quero começar", "quero fazer", "quero consultar", "quero entender").

**Limites e o que falta.**
- O Diátaxis não trata de POP nem de jornada. Por isso esses dois gêneros ficaram **fora** dos quatro quadrantes, como pede o B04-01.
- A página [Mensagens e soluções](../usuario/guia/09-mensagens-e-solucoes.md) mistura referência ("o que significa") com como fazer ("o que fazer"). Pela bússola, ela fica entre dois quadrantes. Mantivemos assim porque o leitor chega a ela com uma mensagem na tela e quer as duas respostas juntas. É uma escolha consciente, e não um descuido.

## 2. OASIS DITA 1.3

**Fonte:** *Darwin Information Typing Architecture (DITA) Version 1.3*, OASIS Standard com Errata 02, de 19/06/2018. Lemos a Parte 0 (visão geral) e, da Parte 3, as seções 2.2.1.4 (*Information typing*) e 2.7.1 (*Technical content: Document types*). É uma norma técnica baseada em XML.

**O que diz.**
- ***Information typing*** é a prática de identificar tipos de tópico. Os tipos-base citados são *concept*, *task* e *reference*.
- O pacote de conteúdo técnico acrescenta *troubleshooting*, *glossary entry*, o tipo *map* e o *bookmap*.
- Novos tipos são criados por ***specialization***, a partir dos tipos existentes.

> "Information typing is the practice of identifying types of topics" (DITA 1.3, Parte 3, seção 2.2.1.4)

**Como aplicamos.** Usamos a **ideia**, não o formato XML:
- cada página é um tópico tipado e responde a uma pergunta;
- o [README da documentação](../usuario/README.md) faz o papel de um *map*, porque organiza os tópicos sem repetir o conteúdo deles;
- os [modelos de página](../usuario/processo/04-modelos.md) funcionam como uma "especialização" informal, com um esqueleto fixo por tipo.

O *troubleshooting* do DITA corresponde à nossa página de mensagens e soluções.

**Limites e o que falta.**
- O DITA permite **reutilizar um trecho** em vários tópicos sem copiá-lo, pela referência de conteúdo (*conref*). O Markdown do GitHub não tem esse recurso, então algumas informações acabaram repetidas, como "de 20 a 50 segundos". A revisão adversarial marcou isso como item 16 (parcial). *Não lemos a seção normativa sobre conref; a afirmação vem do conhecimento geral do padrão.*
- Adotar o DITA de verdade exigiria ferramentas XML. Para 20 páginas, o custo seria maior que o benefício.

## 3. Google Technical Writing

**Fonte:** Google for Developers, *Overview of technical writing courses* e a unidade *Audience* do curso *Technical Writing One*. É um curso oficial; a página não mostra data. A oferta inclui *Technical Writing One* e *Two*, *Writing Helpful Error Messages* e *Tech Writing for Accessibility*.

**O que diz.**
- Escrever bem começa por definir o **público**: o papel (*role*) do leitor e a distância (*proximity*) dele em relação ao conhecimento.
- Quem conhece demais o assunto sofre da **"maldição do conhecimento"** (*curse of knowledge*) e pula passos que parecem óbvios.
- O curso recomenda palavras simples e evitar expressões idiomáticas.

> "Experts often suffer from the curse of knowledge" (Google, *Technical Writing One: Audience*)

**Como aplicamos.**
- Definimos três públicos (L1 cidadão, L2 equipe e L3 avaliador) no [inventário](../usuario/processo/02-inventario-e-briefing.md).
- O guia do cidadão não usa termos técnicos. "API" vira "servidor do EcoColeta", e "hash" aparece uma única vez, com a explicação "embaralhada".
- A revisão adversarial combateu a maldição do conhecimento. Por exemplo, nós sabíamos que o cadastro é a primeira chamada ao servidor, mas o tutorial avisava sobre a demora só no login (item 4).

**Limites e o que falta.**
- O curso *Writing Helpful Error Messages* trata justamente do problema que registramos: o app mostra mensagens técnicas ao cidadão, como "Verifique a Service Account". Esse curso é a referência para a **correção no app** e não só na documentação.
- As unidades sobre frases curtas, voz ativa e listas não foram lidas nesta consulta.

## 4. WCAG 2.2 e WAI

**Fonte:** W3C, *Web Content Accessibility Guidelines (WCAG) 2.2*, uma W3C Recommendation. Foi publicada em 05/10/2023, e a versão atual é de 12/12/2024. Lemos também *What's New in WCAG 2.2* e as páginas *Understanding* dos critérios citados abaixo. É uma norma internacional de acessibilidade web.

**O que diz.**
- O conteúdo precisa ser **perceptível, operável, compreensível e robusto** (os princípios POUR).
- São 13 diretrizes, com critérios nos níveis A, AA e AAA.
- A versão 2.2 trouxe 9 critérios novos e **removeu** o 4.1.1 (*Parsing*).

> "Color is not used as the only visual means of conveying information" (WCAG 2.2, critério 1.4.1)

**Critérios que se aplicam a uma documentação como a nossa:**

| Critério | Nível | O que exige | Na nossa prova |
| --- | --- | --- | --- |
| 1.1.1 Conteúdo não textual | A | Alternativa em texto para imagens | ✅ Atendido: as imagens têm `alt` descritivo, e cada diagrama tem uma "Descrição em texto" logo abaixo |
| 1.4.1 Uso de cor | A | A cor não pode ser o único meio de informar | ✅ Atendido: as marcações são escritas por extenso ([Verificado], [Lacuna]…), e ⚠️ e ✅ vêm sempre com uma palavra |
| 2.4.4 Finalidade do link (em contexto) | A | Dá para entender o destino do link pelo texto ou pelo contexto | ⚠️ Parcial: quase todos os links usam o título da página, mas há links curtos, como "[por quê]" em *Entrar e sair*, que dependem do contexto da frase (o critério permite) |
| 2.4.6 Títulos e rótulos | AA | Títulos descrevem o assunto | ✅ Atendido: os títulos são tarefas ("Editar ou excluir uma solicitação") |
| 3.1.5 Nível de leitura | AAA | Texto mais avançado que o ensino fundamental II exige apoio | ⚠️ Não medido: escrevemos de forma simples, mas não aplicamos um índice de legibilidade |

**Limites.**
- A WCAG avalia **conteúdo web**. O PDF gerado não foi conferido com um leitor de tela, e um PDF sem marcação de estrutura (*tags*) pode perder os títulos.
- A tabela acima é uma **autoavaliação** e não uma auditoria. O B04-01 alerta para não declarar conformidade integral.

## 5. GOV.UK Service Manual

**Fonte:** Service Manual do governo britânico:
- *Learning about users and their needs*, publicada em 04/04/2016 e atualizada em 23/03/2017;
- *Creating an experience map*, publicada em 21/02/2017.

É um guia oficial de serviço público e **não uma norma universal**, como o próprio B04-01 adverte. A URL "understanding users who don't use digital services" que tentamos não existe no endereço testado (erro 404) e não foi lida.

**O que diz.**
- As **necessidades do usuário** (*user needs*) devem vir de pesquisa com usuários. O formato sugerido é "eu preciso/quero/espero… para que…".
- Opiniões que não vêm de usuários são **suposições**.
- O **mapa de experiência** mostra etapas (*stages*), passos, pontos de contato (*touchpoints*), dificuldades (*pain points*) e altos e baixos emocionais ao longo do tempo.

> "Treat any opinions or suggestions that do not come from users as assumptions" (GOV.UK, *Learning about users and their needs*)

**Como aplicamos.**
- A [jornada](../usuario/processo/05-jornada-solicitar-coleta.md) segue exatamente essa regra. Como não houve pesquisa, ela foi publicada **inteira como hipótese**, separando (Fato do app) de (Hipótese).
- As colunas da jornada (ações, ponto de contato, perguntas, fricções) correspondem aos elementos do mapa de experiência.
- O [plano de teste com leitores](../usuario/processo/06-plano-de-teste-com-leitores.md) é o caminho para transformar hipóteses em observações.

**Limites e o que falta.**
- A jornada não tem a dimensão **emocional** (altos e baixos) do mapa de experiência, porque ela só pode vir de observação real.
- Falta escrever as necessidades no formato "eu preciso… para que…". Exemplo, ainda como hipótese: *"Eu preciso saber quando a coleta vai acontecer, para que eu deixe o material na calçada no dia certo."*

## 6. GitHub Docs

**Fonte:** GitHub, *About the repository README file*, *Basic writing and formatting syntax* e *Creating diagrams*. É a documentação oficial da plataforma e não mostra data.

**O que diz.**
- O README pode ficar em `.github/`, na raiz ou em `docs/`, nessa ordem de prioridade.
- O GitHub monta um índice automático a partir dos títulos e corta o conteúdo acima de 500 KiB.
- Cada título vira uma **âncora** automática: o texto fica em minúsculas, os espaços viram hífen, e títulos repetidos ganham `-1`.
- **Links relativos** funcionam entre arquivos do repositório.
- Os **alertas** (`> [!NOTE]`, `> [!WARNING]`…) destacam informações críticas.
- Blocos ` ```mermaid ` são desenhados como diagramas.

> "Use alerts only when they are crucial for user success" (GitHub Docs, *Basic writing and formatting syntax*)

**Como aplicamos.**
- A documentação tem um `README.md` como entrada, links relativos entre as páginas e diagramas em Mermaid.
- O script de geração do PDF confere todas as âncoras com a mesma regra do GitHub, que **mantém os acentos**. Isso evitou links quebrados como `#quando-o-login-nao-funciona`, porque a âncora correta é `#quando-o-login-não-funciona`.

**Limites e o que falta.**
- Usamos citações comuns com ⚠️ **Atenção** em vez dos alertas nativos `> [!WARNING]`. Fizemos isso porque o conversor usado no PDF não reconhece a sintaxe de alerta. É uma troca consciente: no GitHub, o alerta nativo seria mais claro.
- O GitHub avisa que **editar um título quebra as âncoras**. Na nossa prova, só a conferência automática protege contra isso.

## 7. Write the Docs, *Docs as code*

**Fonte:** writethedocs.org, *Docs as code*, por Eric Holscher e a comunidade Write the Docs. É um guia da comunidade e não mostra data.

**O que diz.** É a filosofia de escrever a documentação **com as mesmas ferramentas do código**: rastreador de *issues*, controle de versão (Git), texto simples com marcação (Markdown), revisão e testes automatizados. O benefício é aproximar quem escreve de quem desenvolve e poder **barrar uma mudança que chega sem documentação**.

> "…you should be writing documentation with the same tools as code" (Write the Docs, *Docs as code*)

**Como aplicamos:**

| Prática | Na prova |
| --- | --- |
| Controle de versão | ✅ Atendido: a documentação está em `docs/usuario/`, no mesmo repositório Git do app |
| Texto simples com marcação | ✅ Atendido: Markdown |
| Revisão | ✅ Atendido: [revisão adversarial](../usuario/processo/07-revisao-adversarial.md) por um revisor independente |
| Testes automatizados | ⚠️ Parcial: o script confere links e âncoras, mas roda à mão e não a cada *push* |
| Rastreador de issues | ⚠️ Parcial: as issues do GitHub são o canal provisório de suporte (item C4 das lacunas) |

**Limites e o que falta.** Para ser *docs as code* completo, a conferência de links deveria rodar sozinha no CI (a pipeline do GitHub Actions do [trabalho de DevOps](../devops/08-cicd.md)). A regra "mudou um texto da tela, atualize a página no mesmo commit" ainda depende da disciplina da equipe.

---

## Como as referências se complementam

- **Diátaxis e DITA** respondem à mesma pergunta, "que tipo de tópico é este?", em níveis diferentes. O Diátaxis orienta a **escrita**; o DITA padroniza a **estrutura** para reutilização em escala.
- **Google Technical Writing e GOV.UK** colocam o **leitor** no centro. O primeiro mostra como escrever para ele; o segundo, como descobrir quem ele é de verdade.
- **WCAG** garante que o leitor **consiga** ler, inclusive com leitor de tela e sem depender de cor.
- **GitHub Docs e Write the Docs** cuidam de **onde** a documentação vive e de **como** ela continua correta ao longo do tempo.

## O que o estudo mudaria na prova

Estas são melhorias que identificamos e **não** aplicamos na entrega:

1. Trocar os avisos ⚠️ por alertas nativos `> [!WARNING]` na versão do GitHub (GitHub Docs).
2. Rodar a conferência de links no GitHub Actions a cada *push* (Write the Docs).
3. Escrever as necessidades no formato "eu preciso… para que…" e incluir a dimensão emocional depois do teste com leitores (GOV.UK).
4. Medir o nível de leitura do guia e conferir o PDF com um leitor de tela (WCAG 3.1.5 e limites da seção 4).
5. Reescrever as mensagens técnicas do app com base no curso *Writing Helpful Error Messages* (Google).

## Referências

Todas consultadas em 08/11/2026.

- PROCIDA, D. *Diátaxis*. Disponível em: https://diataxis.fr/ e https://diataxis.fr/compass/.
- OASIS. *Darwin Information Typing Architecture (DITA) Version 1.3*, Part 0 (Overview) e Part 3 (All-Inclusive), Plus Errata 02. OASIS Standard, 19 jun. 2018. Disponível em: https://docs.oasis-open.org/dita/dita/v1.3/dita-v1.3-part0-overview.html.
- GOOGLE. *Technical writing courses* e *Technical Writing One: Audience*. Disponível em: https://developers.google.com/tech-writing/overview.
- W3C. *Web Content Accessibility Guidelines (WCAG) 2.2*. W3C Recommendation, 5 out. 2023 (versão de 12 dez. 2024). Disponível em: https://www.w3.org/TR/WCAG22/. Também *What's New in WCAG 2.2* e *Understanding WCAG 2.2* (critérios 1.4.1, 2.4.4, 2.4.6 e 3.1.5).
- GOV.UK. *Service Manual: Learning about users and their needs* (2016, atualizado em 2017) e *Creating an experience map* (2017). Disponível em: https://www.gov.uk/service-manual/user-research/start-by-learning-user-needs e https://www.gov.uk/service-manual/user-research/creating-an-experience-map.
- GITHUB. *About the repository README file*, *Basic writing and formatting syntax* e *Creating diagrams*. Disponível em: https://docs.github.com/.
- HOLSCHER, E.; WRITE THE DOCS. *Docs as code*. Disponível em: https://www.writethedocs.org/guide/docs-as-code/.
