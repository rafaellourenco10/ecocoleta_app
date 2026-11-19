# Lacunas e decisões

> **Tipo:** registro · **Fonte canônica** de tudo o que está marcado como **[Lacuna]** ou **[Criado pela equipe]** · Atualizado em 08/11/2026 · [Voltar ao início](../README.md)

## Lacunas: o que não sabemos

Nenhuma delas foi preenchida por suposição nas páginas do guia. Onde foi preciso dar uma orientação provisória, ela aparece na tabela "Criado pela equipe" mais abaixo.

| ID | O que não sabemos | Onde afeta | Decide quem | Estado |
| --- | --- | --- | --- | --- |
| L1 | Quem faz a coleta física, em quanto tempo e como a equipe de coleta recebe os pedidos | FAQ "Quando a coleta vai acontecer?", Como funciona, Jornada etapas 1, 6 e 7 | Equipe / cliente do projeto | Aberta |
| L2 | Custo da coleta para pessoa física e para empresa | FAQ "Quanto custa?" | Equipe / cliente | Aberta |
| L3 | Canal oficial de suporte ao usuário | FAQ "Como falo com a equipe?", Mensagens | Equipe | Provisório (C4) |
| L4 | Política de privacidade e exclusão de conta (LGPD) | Como funciona, FAQ "Como apago minha conta?" | Equipe | Provisório (C5) |
| L5 | Recuperação e troca de senha | Entrar e sair, Perfil | Equipe de desenvolvimento | Aberta, [Proposto] |
| L6 | Resíduo que não se encaixa em nenhum dos 5 tipos (não há opção "Outro") | Resíduos e dicas | Equipe | Provisório: escolher o tipo mais próximo e explicar na descrição |
| L7 | O perfil aceita um e-mail que já pertence a outra conta | Perfil | Equipe de desenvolvimento | Aberta |
| L8 | Comportamento quando a câmera não abre: não testado | Mensagens e soluções | Equipe (teste em aparelho) | Aberta |
| L9 | Os dados ambientais das dicas (por exemplo, "25 mil litros") não foram conferidos em fonte científica | Resíduos e dicas | Equipe | Aberta |
| L10 | Teste com leitores ainda não executado | Todas as páginas do guia | Equipe | Planejado |
| L11 | **Defeito:** a validação de e-mail do app recusa e-mails válidos com mais de um ponto depois do @ (`.com.br`, `.edu.br`) ou com `+`. **Bloqueia o cadastro de parte do público.** | Tutorial, Entrar e sair, Campos | Equipe de desenvolvimento | Aberta: corrigir `lib/core/validators.dart` |
| L12 | **Defeito:** o login diferencia maiúsculas e minúsculas no e-mail, e o perfil grava o e-mail sem remover espaços. Uma troca de e-mail mal digitada tranca a conta. | Perfil, Entrar e sair | Equipe de desenvolvimento | Aberta |
| L13 | A versão 1.x (identificador `com.example.ecocoleta_app`) chegou a ser distribuída? Se sim, quem a tem fica com dois apps instalados. | Instalar | Equipe | Aberta |

## Itens criados pela equipe

Informações que **não existiam** em nenhuma fonte e que a equipe definiu seguindo a lógica do projeto. **Todas precisam ser validadas** antes de serem tratadas como oficiais.

| ID | O que foi criado | Onde | Lógica usada |
| --- | --- | --- | --- |
| C1 | Cuidados com resíduo **Orgânico** (sacos fechados) e **Infectante** (não misturar, embalagem resistente, avisar na descrição) | Resíduos e dicas | Boas práticas gerais de manuseio. O site só dizia "precisa de coleta separada". |
| C2 | Descrição de cada opção de **Acondicionamento** e o exemplo de volume (saco de 100 L) | Resíduos e dicas | Significado comum dos termos e conta de volume (5 × 100 L = 500 L = 0,5 m³). |
| C3 | Recuperar o app após uma release defeituosa (marcar como *pre-release*) | POP-01, seção 6 | Comportamento do GitHub: o link `latest` aponta para a release mais recente que não é *pre-release*. Não testado. |
| C4 | Canal de suporte provisório: **issues do GitHub** | FAQ | É o único canal público que já existe no projeto. **Risco:** as issues são públicas, por isso o FAQ proíbe escrever dados pessoais nelas. |
| C5 | Exclusão de conta **a pedido**, feita pela equipe | FAQ, Plano de teste | Enquanto não houver botão no app, é a forma de atender a um pedido de exclusão (LGPD). **Só é possível manualmente, no console do Firestore, por quem tem acesso ao projeto** (a API não tem rota para isso). Falta um POP-02 para essa tarefa. |
| C6 | Marcações de estado e modelos de página | Estratégia, Modelos | Evolução do B04-01. |
| C7 | Situações propostas para o pedido: Recebida, Agendada, Coletada, Cancelada | FAQ, [Proposto] | Ciclo mínimo de um pedido de serviço. |

## Riscos de segurança conhecidos

**Decisão:** o guia do cidadão diz apenas, em linguagem neutra, que "a proteção de acesso aos dados no servidor está em revisão" ([Como funciona](../guia/06-como-funciona.md#seus-dados)). O detalhe fica aqui. Esta página é pública, como todo o repositório, então **não** há nada aqui que não se descubra lendo o código-fonte, que também é público.

- A API **não tem autenticação**: quem souber o identificador de um usuário ou de uma solicitação consegue ler (inclusive o CPF/CNPJ), alterar ou apagar esses dados. Isso afeta diretamente a privacidade (L4). Prioridade alta para a equipe de desenvolvimento.
- O servidor gratuito desliga quando fica sem uso, o que causa a demora de 20 a 50 s.

## Decisões tomadas

| Data | Decisão | Motivo |
| --- | --- | --- |
| 08/11/2026 | A documentação descreve o **app**, e não a API, quando os dois diferem (exemplo: os campos editáveis) | O leitor usa o app. |
| 08/11/2026 | O PDF é sempre gerado a partir dos `.md` | Uma única fonte canônica. |
| 08/11/2026 | A jornada é publicada como hipótese | Não houve pesquisa com usuários (regra do B04-01). |
