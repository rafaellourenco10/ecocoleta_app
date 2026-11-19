# Editar ou excluir uma solicitação

> **Tipo:** como fazer · **Para:** quem já registrou um pedido de coleta · **Versão:** app 2.0.0 · [Voltar ao início](../README.md)

## Abrir as opções de uma solicitação

1. Na tela inicial, toque em **Minhas Coletas**.
2. Na lista **Minhas Solicitações**, toque na solicitação desejada. Cada item mostra o tipo de resíduo e o endereço.
3. Escolha **Editar Solicitação** ou **Excluir Solicitação**.

Se a lista mostrar **Nenhuma solicitação encontrada.**, você ainda não tem pedidos nessa conta.

## Editar

Pela edição você pode mudar apenas **três campos**:

| Pode editar | Não pode editar no app |
| --- | --- |
| Tipo | Volume estimado |
| Descrição | Acondicionamento |
| Endereço | Foto |

1. Depois de tocar em **Editar Solicitação**, abre a janela **Editar Coleta**.
2. Altere o **Tipo**, a **Descrição** ou o **Endereço**.
3. Toque em **Salvar**.

A janela fecha e a lista é atualizada. **Não aparece mensagem de sucesso**: para confirmar, confira se o item mostra o novo tipo e endereço. **[Implementado]**

Se algum campo ficar vazio, a edição não é salva e o app avisa **Preencha todos os campos.**

**Para mudar o volume, o acondicionamento ou a foto**, exclua a solicitação e crie outra pelo botão **Solicitar Coleta**.

## Excluir

> ⚠️ **Atenção: a exclusão é definitiva.** A solicitação é apagada do servidor e não pode ser recuperada.

1. Toque em **Excluir Solicitação**.
2. Na pergunta **Excluir solicitação?** (*Essa ação não pode ser desfeita.*), toque em **Excluir** para confirmar ou em **Cancelar** para desistir.

A solicitação sai da lista e, quando você fecha a lista, o número no botão **Minhas Coletas** diminui.

## Se der erro

Se aparecer uma mensagem em vermelho, como **Erro de conexão ao editar a coleta.** ou **Erro de conexão ao excluir a coleta.**, verifique a internet e tente de novo. Mais mensagens em [Mensagens e soluções](09-mensagens-e-solucoes.md).

---

*Fontes: `lib/screens/tela_inicial.dart` (folha "Minhas Solicitações", janela "Editar Coleta", confirmação de exclusão); `lib/core/coleta_service.dart`; API `coletas.routes.js` (o PUT aceita tipo, volume, acondicionamento, descrição e endereço, mas o app envia só três desses campos).*
