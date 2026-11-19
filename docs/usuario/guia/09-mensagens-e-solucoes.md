# Mensagens e soluções

> **Tipo:** referência · **Para:** quem viu um aviso no app e quer saber o que fazer · **Versão:** app 2.0.0 · [Voltar ao início](../README.md)

As mensagens **em vermelho embaixo de um campo** estão em [Campos e regras](07-campos-e-regras.md). Esta página traz as mensagens que aparecem **na faixa da parte de baixo da tela**: verde quando a ação deu certo e vermelha quando deu errado. Os textos estão exatamente como no app. **[Implementado]**

## Avisos de sucesso (faixa verde)

| Mensagem | Onde | Significa |
| --- | --- | --- |
| Conta criada com sucesso! | Cadastro | A conta existe. Agora entre com o e-mail e a senha. |
| Solicitação enviada com sucesso! | Nova Solicitação | O pedido foi registrado e já aparece em **Minhas Coletas**. |
| Perfil atualizado com sucesso! | Meu Perfil | Os dados novos foram salvos. |

Editar e excluir uma solicitação **não mostram aviso**. A confirmação é a própria lista atualizada.

## Erros (faixa vermelha)

### Conexão

| Mensagem | O que fazer |
| --- | --- |
| Erro de conexão. Verifique sua internet e tente novamente. | Confira se o celular está com internet. Se estiver, espere 1 minuto (o servidor pode estar ligando) e tente de novo. |
| Erro de conexão ao carregar o perfil. | Volte e abra **Meu Perfil** de novo. |
| Erro de conexão ao atualizar o perfil. | Seus dados **não** foram salvos. Tente de novo. |
| Erro de conexão ao editar a coleta. | A edição **não** foi salva. Tente de novo. |
| Erro de conexão ao excluir a coleta. | A solicitação **não** foi excluída. Tente de novo. |

### Conta

| Mensagem | O que fazer |
| --- | --- |
| Email ou senha inválidos | Confira os dados digitados. Veja [Entrar, sair e problemas de acesso](03-entrar-e-sair.md#quando-o-login-não-funciona). |
| Este e-mail já está cadastrado | Já existe uma conta com esse e-mail. Entre com ele ou use outro e-mail. |
| Nome, e-mail e senha são obrigatórios | Preencha os três campos. Esse aviso só aparece se um campo chegar vazio ao servidor. |
| Usuário não encontrado | A conta não existe mais. Saia e crie uma conta nova. |
| Preencha todos os campos. | Na janela **Editar Coleta**, nenhum campo pode ficar vazio. |
| Registro não encontrado no banco de dados. | Você tentou editar uma solicitação que já foi excluída, talvez em outro celular. Feche e abra a lista de novo. |

### Problemas no servidor

Estas mensagens indicam problema **do lado do EcoColeta**, e não do seu celular. Espere alguns minutos e tente de novo. Se continuar, avise a equipe (veja [Perguntas frequentes](10-perguntas-frequentes.md#como-falo-com-a-equipe)).

| Mensagem | Significado técnico |
| --- | --- |
| Serviço do Firebase temporariamente indisponível. Tente novamente em alguns segundos. | O banco de dados não respondeu. |
| Database não conectado. Verifique as credenciais do Firebase no servidor. | O servidor perdeu o acesso ao banco. |
| Credenciais do Firebase inválidas ou expiradas. Verifique a Service Account. | Configuração do servidor. |
| A API do Cloud Firestore está desabilitada ou sem permissão. … | Configuração do servidor. |
| Erro no servidor: *número* | Erro sem mensagem própria. Anote o número para a equipe. |

## Sem mensagem nenhuma

| O que acontece | O que fazer |
| --- | --- |
| O botão fica girando | O servidor está ligando. Espere até cerca de 1 minuto. |
| A lista **Minhas Solicitações** mostra **Erro de conexão ao buscar coletas.** com o botão **Tentar novamente** | Confira a internet e toque em **Tentar novamente**. |
| A câmera não abre ao tocar na área da foto | **[Lacuna]** Este caso não foi testado e o app não mostra aviso. O EcoColeta usa o app de câmera do próprio celular; confira se ele abre normalmente fora do EcoColeta. A foto é opcional, então você pode enviar sem ela. |

---

*Fontes: todas as mensagens foram extraídas de `lib/core/*_service.dart`, `lib/core/api_exception.dart`, `lib/screens/*.dart` e das rotas da API (`tratarErroFirebase` e respostas 400, 401, 404 e 409). Mensagens do servidor que o usuário comum não deveria ver estão registradas como problema de texto na [revisão](../processo/07-revisao-adversarial.md).*
