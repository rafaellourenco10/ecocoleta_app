# Banco de prompts do EcoColeta

> **Tipo:** referência · **Para:** a equipe, ao criar ou revisar páginas com ajuda de um assistente de IA · **Base:** banco de prompts do B04-01 · [Voltar ao início](../README.md)

Estes são os prompts do B04-01 **com os campos preenchidos** para o EcoColeta. Usamos um prompt por vez. Quando algum dado não era conhecido, escrevemos "não definido", como orienta o B04-01, para que o assistente não precisasse adivinhar.

## Prompt-base do EcoColeta

O prompt-base do B04-01, mais **quatro regras próprias** do projeto, marcadas com ➕. Ele vai junto de todos os outros prompts.

```text
Trabalhe somente com as fontes e o contexto fornecidos. Antes de escrever,
identifique leitor, tarefa, gênero, escopo, versão e critério de aceite.
Não invente fatos, requisitos, passos, autoridades ou evidências.
Separe comportamento pretendido, comportamento implementado e o que foi
verificado. Aponte contradições e lacunas; não as resolva silenciosamente.
Mantenha uma fonte canônica por assunto e prefira links a cópias.
Escolha a estrutura adequada ao gênero e remova seções que não ajudem.
Ao concluir, informe arquivos produzidos, fontes usadas, verificações
executadas e o que permanece incerto ou não verificado.

➕ Contexto fixo: app EcoColeta 2.0.0 (Flutter, Android 7.0+), API Node/Express
   no Render, banco Firestore. Commit de referência: 72d03da.
➕ Copie textos de botões, campos e mensagens EXATAMENTE como estão no código
   (lib/screens, lib/core, rotas da API), inclusive erros de digitação.
➕ Use só estas marcações de estado, por extenso: [Verificado], [Implementado],
   [Criado pela equipe], [Proposto], [Lacuna].
➕ Escreva em português do Brasil, frases curtas, segunda pessoa ("você"),
   sem termos técnicos nas páginas do guia; se um termo for inevitável, explique-o.
```

## Prompts usados, por fase

### P1, Descoberta e inventário → [Inventário](02-inventario-e-briefing.md)

```text
Mapeie os materiais fornecidos para o app EcoColeta na versão 2.0.0, commit
72d03da. Fontes: lib/, test/, android/app/, README.md, site/index.html, e o
repositório ecocoleta_api (src/). Liste arquivos, leitores prováveis
(cidadão, equipe, avaliador), tarefas, gêneros, fontes de autoridade,
conflitos, lacunas e limites público/interno.
Não edite arquivos e não infira autoridade pelo nome ou localização.
Separe hierarquia pai/filho de pré-requisitos, sequência de execução e
relações temáticas. Cite evidências por caminho e título/seção.
Saída: inventário conciso e perguntas que exigem decisão humana.
```

### P2, Briefing → [Briefing](02-inventario-e-briefing.md#5-briefing)

```text
Com base no inventário P1, prepare um briefing para documentar o uso do
EcoColeta 2.0.0 por cidadãos e empresas. Leitor: pessoa sem conhecimento
técnico com Android. Tarefa primária: registrar uma solicitação de coleta.
Prazo de atendimento: não definido. Custo da coleta: não definido.
Canal de suporte: não definido. Marque cada campo desconhecido como pendente.
```

### P4, Mapa e arquitetura de conteúdo → [Estratégia](01-estrategia.md#arquitetura-de-conteúdo)

```text
Proponha uma estrutura de documentação para os leitores L1 (cidadão), L2
(equipe) e L3 (avaliador), usando somente os tópicos do inventário P1.
Uma única entrada (README da documentação). Gêneros Diátaxis. Para cada
página: propósito, pergunta respondida, gênero, pai e relações não
hierárquicas. Regras de campo e mensagens devem ter UMA página canônica cada.
Apresente a proposta antes de escrever qualquer página.
```

### P6, Página consolidadora → [README da documentação](../README.md)

```text
Crie o consolidador docs/usuario/README.md. Intenção própria: levar cada
leitor à página que responde à sua tarefa. Filhos diretos: as 10 páginas de
guia/, o POP de equipe/ e as 8 de processo/. Agrupe por tarefa ("quero
começar", "quero fazer", "quero consultar", "quero entender"). Linke cada
filho com título exato e uma frase "Responde:". Não há garantia emergente:
declare que a página é navegacional. Inclua a legenda das marcações.
```

### P7, Página canônica (usado 10 vezes) → [Guia](../README.md#quero-fazer-uma-tarefa-específica)

Exemplo preenchido para a página de mensagens:

```text
Produza uma página canônica sobre as mensagens da faixa inferior do app
para o cidadão que viu um aviso e quer saber o que fazer.
Gênero: referência. Fontes e versões: lib/core/*_service.dart,
lib/core/api_exception.dart, lib/screens/*.dart, ecocoleta_api/src/routes/*.js
(v2.0.0). Responda: "o que esta mensagem significa e o que eu faço?".
Agrupe por situação (sucesso, conexão, conta, servidor). Não repita as
mensagens de campo: ligue à página Campos e regras.
```

### P8, POP → [POP-01](../equipe/pop-publicar-nova-versao.md)

```text
Redija um POP para publicar uma nova versão do APK do EcoColeta no ambiente
Windows + Flutter SDK + GitHub Releases. Fontes autorizadas: README (seção
"Gerar o APK de release"), registro da publicação v2.0.0, build.gradle.kts.
Operador responsável: Rafael R. Lourenço. Inclua todos os itens do modelo
POP. Destaque ANTES dos passos o risco irreversível da chave de assinatura.
Marque passos não testados e deixe o estado como "rascunho para validação".
```

### P9, Jornada → [Jornada](05-jornada-solicitar-coleta.md)

```text
Mapeie a jornada para cidadão com Android alcançar "ter um pedido de coleta
registrado" no app EcoColeta 2.0.0. Evidência disponível: NENHUMA pesquisa
com usuários; apenas leitura do código e do site (período: novembro/2026).
Portanto, todas as etapas devem ser marcadas como hipótese. Para cada etapa:
objetivo, ações, ponto de contato, perguntas, fricções prováveis, resultado
e fonte. Termine com oportunidades a validar e as perguntas de pesquisa.
```

### P10, Figura Mermaid → [Como funciona](../guia/06-como-funciona.md)

```text
Avalie se uma figura é necessária para responder "para onde vão meus dados?"
e "o que acontece com meu pedido?". Alvo: GitHub (Mermaid) e PDF gerado com
Mermaid 11. Se útil, produza o Mermaid mais simples, sem depender de cor,
com descrição textual equivalente logo abaixo. Não declare o render validado
sem gerar o PDF.
```

### P11, Revisão adversarial → [Revisão](07-revisao-adversarial.md)

```text
Revise docs/usuario/ (versão de 08/11/2026) para o leitor L1 e a tarefa
"pedir uma coleta", usando como autoridade o código v2.0.0 e o site.
Destino: GitHub e PDF. Procure afirmações sem fonte, status confuso,
lacunas, duplicação, links e âncoras quebrados, exemplos não verificados,
problemas de navegação, acessibilidade e sintaxe incompatível. Para cada
achado: arquivo/seção, evidência, consequência, confiança, correção mínima.
Separe defeitos comprovados de melhorias. Não edite.
```

### P12, Plano de teste com leitores → [Plano](06-plano-de-teste-com-leitores.md)

```text
Prepare um plano para avaliar se docs/usuario/ ajuda cidadãos com Android a
instalar o app, pedir uma coleta, corrigir um pedido e entender uma
mensagem de erro. Participantes: 5, recrutados pela equipe. Defina tarefas,
métricas separadas, registro, consentimento e critérios de decisão.
Não presuma que 5 pessoas provam efeito universal.
```

## Prompts não usados e por quê

| Prompt do B04-01 | Motivo |
| --- | --- |
| P3, Pesquisa de prior art | O projeto não precisava escolher entre padrões ou tecnologias para esta documentação. Usamos as referências do próprio B04-01 (Diátaxis, Google Technical Writing, WCAG). |
| P5, README de projeto | O README do repositório já existe e é voltado ao desenvolvedor. Esta documentação não o substitui; só aponta para ele. |
