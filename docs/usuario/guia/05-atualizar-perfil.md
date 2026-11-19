# Atualizar o perfil

> **Tipo:** como fazer · **Para:** quem quer corrigir os próprios dados · **Versão:** app 2.0.0 · [Voltar ao início](../README.md)

## O que dá para mudar

| Campo no perfil | Pode editar? |
| --- | --- |
| Nome Completo | Sim |
| E-mail | Sim. Atenção: passa a ser o e-mail de login. |
| Telefone | Sim |
| Endereço Principal | Sim |
| CPF ou CNPJ | **Não.** Não aparece no perfil. |
| Senha | **Não.** Veja [Esqueci minha senha](03-entrar-e-sair.md#esqueci-minha-senha). |

## Passos

1. Na tela inicial, toque em **Meu Perfil**.
2. Toque no **ícone de lápis**, no canto superior direito. Aparece o aviso **Você está no modo de edição** e os campos são liberados.
3. Altere o que precisar.
4. Toque no **ícone de confirmar** (✓), no mesmo lugar onde estava o lápis.

Aparece **Perfil atualizado com sucesso!** e os campos voltam a ficar bloqueados.

Se um campo estiver inválido, a mensagem aparece embaixo dele e nada é salvo. As regras estão em [Campos e regras](07-campos-e-regras.md#perfil).

## Cuidados

> ⚠️ **Atenção ao trocar o e-mail: você pode perder o acesso à conta.** O e-mail novo passa a ser o de login **exatamente como foi digitado**, e o login diferencia maiúsculas de minúsculas. Um espaço no final, comum quando o teclado completa a palavra, também atrapalha. Como não há recuperação de senha, um e-mail digitado errado tranca a conta.
> Digite o e-mail novo **sem espaço no final** e **só com letras minúsculas**, e anote-o antes de sair do app. **[Implementado]**

- **[Lacuna]** A edição do perfil **não confere** se o e-mail novo já pertence a outra conta. O cadastro faz essa verificação, mas o perfil não. Use um e-mail que seja só seu.
- **Não existe botão de cancelar a edição.** Para desistir, volte para a tela anterior com o botão de voltar do Android: nada é salvo enquanto você não toca no ✓.
- Depois de mudar o **nome**, a saudação **Bem-vindo, …** da tela inicial continua com o nome antigo até você sair e entrar de novo.
- Mudar o **Endereço Principal** não altera o endereço das solicitações que já existem. Cada solicitação guarda o próprio endereço.

---

*Fontes: `lib/screens/tela_perfil.dart`; API `usuarios.routes.js` (o PUT aceita só nome, e-mail, telefone e endereço; não verifica e-mail duplicado). O comportamento do botão voltar durante a edição veio da leitura do código e é **[Implementado]**.*
