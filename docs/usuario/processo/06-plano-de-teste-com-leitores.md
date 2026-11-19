# Plano de teste com leitores

> **Tipo:** plano · **Estado:** [Proposto], ainda não executado · **Para:** a equipe · [Voltar ao início](../README.md)

## Pergunta

A documentação em `docs/usuario/` ajuda uma pessoa **sem experiência com o EcoColeta** a concluir as tarefas principais **sem pedir ajuda**?

## Participantes

| Item | Definição |
| --- | --- |
| Quantidade | 5 pessoas |
| Inclusão | Maior de 18 anos; usa celular Android no dia a dia; nunca usou o EcoColeta; não faz parte da equipe nem cursa a mesma disciplina |
| Diversidade desejada | Pelo menos 2 pessoas com mais de 50 anos e pelo menos 1 que represente empresa (CNPJ) |
| Recrutamento | Familiares e conhecidos da equipe; registrar isso como viés |

## Condições

- Celular da própria pessoa, com Android 7.0 ou mais novo.
- A pessoa recebe **apenas** o link do [README da documentação](../README.md), sem nenhuma explicação verbal.
- Usar **dados de teste**: um CPF de teste válido fornecido pelo moderador, um e-mail criado para o teste e o endereço da faculdade. Nunca usar o CPF real da pessoa.
- Antes de cada sessão, acordar o servidor com um acesso, para que a demora do primeiro acesso não domine o tempo. A tarefa T5 testa a demora de propósito.

## Tarefas

| # | Tarefa dada ao participante | Sucesso quando |
| --- | --- | --- |
| T1 | "Instale o EcoColeta no seu celular." | O app abre na tela de entrada. |
| T2 | "Crie uma conta e entre." | A tela inicial mostra "Bem-vindo, …". |
| T3 | "Peça a coleta de um computador velho que está em 2 sacos." | Antes de tocar em **Confirmar Solicitação**, o moderador observa no formulário o tipo **Eletrônico** e o acondicionamento **Sacos Plásticos**. Depois, a solicitação aparece em Minhas Coletas com o tipo **Eletrônico**. A lista não mostra o acondicionamento. |
| T4 | "Você errou o endereço. Corrija." | O endereço aparece corrigido na lista. |
| T5 | "O app mostrou 'Erro de conexão. Verifique sua internet e tente novamente.' O que você faz?" (mostrado em papel) | A resposta corresponde à página Mensagens e soluções. |
| T6 | "Cancele o pedido." | A lista não mostra mais o pedido. |

## Métricas, registradas separadamente

| Métrica | Como medir |
| --- | --- |
| Conclusão | Sim ou não, por tarefa |
| Erro crítico | Ação que leva a resultado errado ou irreversível sem querer, como excluir o pedido na T4 |
| Tempo | Cronômetro do início ao "terminei" |
| Ajuda | Quantas vezes pediu ajuda ao moderador |
| Localização | Qual página abriu primeiro e se era a certa |
| Comentário | Frases ditas em voz alta, anotadas **literalmente** como citação |

## Registro

Uma ficha por participante, com tarefa, métricas e citações. Não gravar áudio nem vídeo sem autorização por escrito.

## Consentimento e privacidade

- Termo simples, lido e assinado antes da sessão: objetivo, duração (até 30 min), direito de parar a qualquer momento, ausência de gravação sem autorização.
- Resultados registrados com códigos (P1 a P5), sem nomes.
- **Ao final, excluir as contas e solicitações de teste.** O participante exclui as solicitações no app (T6). As contas são apagadas por Rafael R. Lourenço no console do Firestore, na coleção `usuarios`, porque o app e a API não têm essa função (lacuna L4). **[Criado pela equipe]**

## Critérios de decisão

| Resultado | Decisão |
| --- | --- |
| Uma tarefa com conclusão menor que 4/5 | Reescrever a página da tarefa e testar de novo |
| Qualquer erro crítico | Corrigir a página antes de publicar e registrar na revisão |
| Página errada aberta primeiro por 2 ou mais participantes | Rever os títulos e a frase "Responde:" do README |
| Pedido de ajuda em 2 ou mais participantes na mesma tarefa | Ver se falta conteúdo (lacuna) ou se o texto é confuso |

## Limitações

- Com 5 pessoas recrutadas por conveniência, o teste **aponta problemas, mas não prova** que a documentação funciona para todos.
- O moderador conhece o projeto e pode influenciar sem querer. Por isso ele não deve responder a dúvidas durante as tarefas.
- Os resultados alimentam a [jornada](05-jornada-solicitar-coleta.md): o que for observado passa de **(Hipótese)** para **(Observação)** ou **(Citação)**.
