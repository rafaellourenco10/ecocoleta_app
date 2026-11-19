# Entrar, sair e problemas de acesso

> **Tipo:** como fazer · **Para:** quem já tem conta · **Versão:** app 2.0.0 · [Voltar ao início](../README.md)

## Entrar

1. Abra o EcoColeta.
2. Digite o **E-mail** e a **Senha** do cadastro.
3. Toque em **Entrar** e espere. Depois de um tempo sem uso, a primeira resposta pode levar até cerca de 50 segundos ([por quê](06-como-funciona.md#por-que-o-primeiro-acesso-demora)).

Você verá **Bem-vindo, seu nome!**.

**O app não lembra o login.** Sempre que você fecha o app de vez, precisa entrar de novo. **[Implementado]**

## Sair

Na tela inicial, toque no **ícone de saída**, a porta com uma seta no canto superior direito. O app volta para a tela de entrada na hora, **sem pedir confirmação**.

## Quando o login não funciona

| O que aparece | Causa provável | O que fazer |
| --- | --- | --- |
| **Email ou senha inválidos** | E-mail ou senha digitados errado, ou uma conta que não existe mais. O e-mail diferencia **maiúsculas de minúsculas**. | Digite o e-mail exatamente como no cadastro e confira maiúsculas e espaços na senha. Se continuar, veja o aviso abaixo. |
| **Erro de conexão. Verifique sua internet e tente novamente.** | Sem internet, ou o servidor demorou mais de 70 segundos para responder. | Abra um site qualquer para testar a internet e tente de novo. Se a internet estiver normal, espere 1 minuto e tente outra vez. |
| O botão fica girando por muito tempo | O servidor está "acordando". | Espere até cerca de 1 minuto. Não feche o app. |
| **Digite um e-mail válido** embaixo do campo | O e-mail está sem `@` ou sem domínio, **ou** termina em `.com.br` ou tem `+`, que o app recusa por engano ([Lacuna](07-campos-e-regras.md#cadastro)). | Confira o e-mail. Se ele for `.com.br`, não há como entrar com ele nesta versão. |

> **Contas criadas antes de 29/09/2026 não existem mais.** Nessa data, na troca para a versão 2.0.0, a equipe apagou todos os cadastros de teste. Quem se cadastrou antes precisa **criar uma conta nova**. *(Fonte: registro da equipe de 29/09/2026.)*

### Esqueci minha senha

**[Lacuna]** O app **ainda não permite recuperar ou trocar a senha**. Não existe a opção "Esqueci minha senha" e o perfil não tem campo de senha.

Até essa função existir, o caminho possível é criar uma conta nova com **outro e-mail**, porque o mesmo e-mail é recusado com **Este e-mail já está cadastrado**. As solicitações da conta antiga não passam para a nova.

**[Proposto]** Recuperação de senha por e-mail está registrada em [Lacunas e decisões](../processo/08-lacunas-e-decisoes.md).

---

*Fontes: `lib/screens/tela_login.dart`, `tela_inicial.dart`, `lib/core/usuario_service.dart` (tempo limite de 70 s no login); API `usuarios.routes.js` (mensagens 401 e 409). A data em que o banco foi zerado vem do registro da equipe.*
