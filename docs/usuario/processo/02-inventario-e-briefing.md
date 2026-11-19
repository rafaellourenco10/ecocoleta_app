# Inventário e briefing

> **Tipo:** relatório · **Prompts do B04-01 usados:** 1 (Descoberta e inventário) e 2 (Briefing) · **Versão analisada:** commit `72d03da`, app 2.0.0, 08/11/2026 · [Voltar ao início](../README.md)

## 1. Inventário de fontes

| Fonte | Caminho | Leitor original | Autoridade sobre | Público ou interno |
| --- | --- | --- | --- | --- |
| Telas do app | `lib/screens/*.dart` (6 telas) | Desenvolvedor | Textos da tela, campos, fluxo, mensagens | Interno (fonte) |
| Validações | `lib/core/validators.dart` | Desenvolvedor | Regras e mensagens dos campos | Interno |
| Serviços | `lib/core/usuario_service.dart`, `coleta_service.dart`, `api_exception.dart` | Desenvolvedor | Mensagens de conexão, tempo limite de 70 s | Interno |
| Testes | `test/validators_test.dart` | Desenvolvedor | Prova de CPF/CNPJ, telefone, e-mail e senha | Interno |
| Configuração Android | `android/app/build.gradle.kts`, `AndroidManifest.xml` | Desenvolvedor | ID do app, versão mínima do Android, permissões | Interno |
| API | repositório `ecocoleta_api`, `src/index.js`, `src/routes/*.js` | Desenvolvedor | Regras do servidor, mensagens de erro, e-mail único | Interno |
| README | `README.md` | Desenvolvedor e visitante do GitHub | Arquitetura, como rodar, como gerar o APK | Público |
| Site | `site/index.html`, no ar em ecocoleta-app.netlify.app | Cidadão | Textos públicos, passos de instalação, exemplos de resíduos | Público |
| Trabalho de DevOps | `docs/devops/` | Professor | Infraestrutura alternativa na Oracle Cloud | Interno (acadêmico) |
| Registros da equipe | histórico do projeto (29/09/2026) | Equipe | Banco zerado, chave de assinatura, release v2.0.0 | Interno |

**Não inferimos autoridade pelo nome do arquivo.** Exemplo: o README diz que o app permite "acompanhar o pedido", mas o código mostra que existe só uma lista, sem situação do pedido. Prevaleceu o código.

## 2. Leitores e tarefas

| Leitor | Tarefas principais | Frequência |
| --- | --- | --- |
| L1, cidadão ou empresa | Instalar; criar conta; pedir coleta; corrigir ou cancelar o pedido; atualizar dados; entender uma mensagem | Única (instalar) a eventual |
| L2, equipe | Publicar versão; responder dúvidas | A cada versão |
| L3, avaliador | Avaliar estratégia, processo e qualidade | Única |

## 3. Relações entre os assuntos

Separamos **hierarquia** (pai e filho), **pré-requisito**, **sequência** e **tema**, como pede o prompt 1.

| Tipo de relação | Exemplos |
| --- | --- |
| Hierarquia | README → Guia → cada página |
| Pré-requisito | Instalar → Entrar → Pedir coleta → Editar ou excluir |
| Sequência de execução | Os 9 passos do POP-01 |
| Tema (sem ordem) | Campos e regras ↔ Mensagens e soluções ↔ Perguntas frequentes |

## 4. Conflitos encontrados nas fontes

| # | Conflito | Fontes | Tratamento |
| --- | --- | --- | --- |
| C1 | "Acompanhe o pedido" e "acompanha o pedido" sugerem acompanhar a situação, mas não existe situação no app | Site e README × `tela_inicial.dart` | A documentação diz o que existe: uma lista. |
| C2 | "O site não precisa ser alterado" a cada versão, mas o site tem "Versão 2.0.0" fixo no texto | README × `site/index.html` | Incluído como passo 6 do POP-01. |
| C3 | O contador em Minhas Coletas soma todos os pedidos, mas a variável interna se chama "pendentes" | `tela_inicial.dart` | A documentação diz "total de solicitações". |
| C4 | A API aceita editar volume e acondicionamento; o app não oferece | `coletas.routes.js` × `tela_inicial.dart` | A documentação descreve o app (3 campos). |

## 5. Briefing

| Campo | Valor |
| --- | --- |
| Assunto | Uso do app EcoColeta 2.0.0 para pedir coletas de resíduos |
| Leitor primário | L1, cidadão ou empresa com celular Android, sem conhecimento técnico |
| Tarefa primária | Registrar uma solicitação de coleta |
| Contexto e versão | App 2.0.0+2, Android 7.0+, API em produção no Render |
| Fonte autoritativa | Código do app e da API (commit `72d03da`) |
| Estado | Funções **implementadas**; regras de campo **verificadas** por testes; site, APK e API **verificados** no ar; uso real **não verificado** com leitores |
| Escopo | Instalação, conta, solicitação, edição, exclusão, perfil, dicas, mensagens, publicação de versão |
| Fora do escopo | Rodar o projeto como desenvolvedor (fica no README), infraestrutura (fica em `docs/devops/`), API para terceiros |
| Riscos | Excluir uma solicitação é irreversível; perder a chave de assinatura impede atualizações; a API não tem autenticação (risco interno, não exposto ao leitor L1) |
| Gênero provável | Tutorial + how-to + referência + explicação + POP |
| Pendências (não preenchidas por suposição) | Prazo e operação da coleta; custo da coleta; canal oficial de suporte; política de privacidade e exclusão de conta; recuperação de senha. Veja as [lacunas](08-lacunas-e-decisoes.md). |
| Critério de aceite | Veja a [estratégia](01-estrategia.md#critérios-de-aceite) |

## 6. Perguntas que exigem decisão humana

1. Quem faz a coleta física e em quanto tempo? (L1)
2. A coleta é gratuita para o cidadão? E para empresas?
3. Qual é o canal oficial de suporte: e-mail, WhatsApp ou issue no GitHub?
4. A equipe aceita registrar uma política de privacidade e um processo de exclusão de conta (LGPD)?
5. O tipo "Infectante" deve continuar aberto a qualquer cidadão?
