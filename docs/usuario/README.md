# Documentação de usuário do EcoColeta

<img src="img/icone.png" alt="Ícone do EcoColeta: símbolo de reciclagem branco sobre fundo verde" width="72">

**Cobre:** app EcoColeta **versão 2.0.0** (build 2), Android 7.0 ou superior · commit `72d03da` · revisada em 08/11/2026
**Responsável:** Equipe EcoColeta (Rafael R. Lourenço, Guilherme, Geovanni, João Wilson)

O EcoColeta é um app para Android onde cidadãos e empresas pedem a coleta de resíduos que não vão para o lixo comum, como eletrônicos, entulho, recicláveis, orgânicos em grande volume e material infectante. Esta página é a **entrada** da documentação: ela não ensina nada sozinha, apenas aponta para a página certa conforme o que você precisa fazer.

---

## Escolha pelo que você quer fazer

### Quero começar a usar

| Página | Tipo | Responde |
| --- | --- | --- |
| [Sua primeira coleta](guia/01-primeira-coleta.md) | Tutorial | Como sair do zero e ter uma solicitação registrada em cerca de 10 minutos. |
| [Instalar o app no Android](guia/02-instalar-o-app.md) | Como fazer | Como baixar o APK e liberar a instalação. |

### Quero fazer uma tarefa específica

| Página | Tipo | Responde |
| --- | --- | --- |
| [Entrar, sair e problemas de acesso](guia/03-entrar-e-sair.md) | Como fazer | Como entrar na conta, sair dela e o que fazer quando o login falha. |
| [Editar ou excluir uma solicitação](guia/04-editar-ou-excluir-solicitacao.md) | Como fazer | Como corrigir um pedido ou cancelá-lo. |
| [Atualizar o perfil](guia/05-atualizar-perfil.md) | Como fazer | Como mudar nome, e-mail, telefone ou endereço. |

### Quero consultar uma informação

| Página | Tipo | Responde |
| --- | --- | --- |
| [Campos e regras de preenchimento](guia/07-campos-e-regras.md) | Referência | O que cada campo aceita e qual mensagem aparece quando está errado. |
| [Tipos de resíduo e dicas de descarte](guia/08-residuos-e-dicas.md) | Referência | Em qual tipo o seu resíduo se encaixa e como guardá-lo. |
| [Mensagens e soluções](guia/09-mensagens-e-solucoes.md) | Referência | O que significa cada aviso do app e o que fazer. |
| [Perguntas frequentes](guia/10-perguntas-frequentes.md) | Referência | Dúvidas rápidas: iPhone, prazo, custo, senha esquecida. |

### Quero entender

| Página | Tipo | Responde |
| --- | --- | --- |
| [Como o EcoColeta funciona](guia/06-como-funciona.md) | Explicação | Para onde vão os seus dados, por que o primeiro acesso demora e o que o app ainda não faz. |

---

## Para a equipe do projeto

| Página | Tipo | Responde |
| --- | --- | --- |
| [POP: publicar uma nova versão do app](equipe/pop-publicar-nova-versao.md) | POP | Como gerar, assinar e publicar o APK sem quebrar a atualização de quem já instalou. |
| [Estratégia de documentação](processo/01-estrategia.md) | Explicação | Como e por que esta documentação foi organizada assim. |
| [Inventário e briefing](processo/02-inventario-e-briefing.md) | Relatório | Quais fontes existem, quem lê e o que cada página precisa cumprir. |
| [Banco de prompts](processo/03-prompts.md) | Referência | Os prompts que usamos, adaptados do B04-01. |
| [Modelos de página](processo/04-modelos.md) | Referência | Os esqueletos de tutorial, how-to, referência, POP e jornada. |
| [Jornada: solicitar uma coleta](processo/05-jornada-solicitar-coleta.md) | Jornada (hipótese) | Por onde a pessoa passa até registrar o pedido e onde ela pode travar. |
| [Plano de teste com leitores](processo/06-plano-de-teste-com-leitores.md) | Plano | Como vamos verificar se a documentação ajuda de verdade. |
| [Revisão adversarial](processo/07-revisao-adversarial.md) | Relatório | Os defeitos encontrados nesta documentação e o que foi corrigido. |
| [Lacunas e decisões](processo/08-lacunas-e-decisoes.md) | Registro | O que não sabemos, o que a equipe definiu e o que ainda falta decidir. |

---

## Como ler as marcações

Cada página indica de onde vem a informação. As marcações são escritas por extenso, sem depender de cor:

- **[Verificado]**: conferido na prática nesta revisão (teste automatizado, acesso ao site ou à API).
- **[Implementado]**: confirmado lendo o código da versão 2.0.0, mas não repetido em um celular nesta revisão.
- **[Criado pela equipe]**: não existia em nenhuma fonte; a equipe definiu seguindo a lógica do projeto. Precisa ser validado.
- **[Proposto]**: melhoria planejada que ainda não existe no app.
- **[Lacuna]**: algo que não sabemos e que não foi preenchido por suposição.

A lista completa de lacunas e itens criados está em [Lacunas e decisões](processo/08-lacunas-e-decisoes.md).

## Fontes canônicas

Quando esta documentação e o app discordarem, **vale o app**. As fontes, em ordem de autoridade:

1. Código do app em `lib/` (versão 2.0.0): telas, campos, mensagens e validações.
2. Código da API (repositório `ecocoleta_api`, `src/routes/`): regras do servidor e mensagens de erro.
3. Site oficial [ecocoleta-app.netlify.app](https://ecocoleta-app.netlify.app): textos públicos e passo a passo de instalação.
4. [README do repositório](https://github.com/rafaellourenco10/ecocoleta_app#readme): visão técnica para quem desenvolve.
