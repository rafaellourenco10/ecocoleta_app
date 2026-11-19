# Campos e regras de preenchimento

> **Tipo:** referência · **Para:** consulta rápida enquanto preenche um formulário · **Versão:** app 2.0.0 · [Voltar ao início](../README.md)

As mensagens abaixo aparecem **em vermelho, embaixo do campo**, enquanto você preenche. No login, elas só aparecem ao tocar em **Entrar**. Os textos são copiados exatamente como estão no app. As regras são **[Implementado]**; as que têm teste automatizado estão indicadas no rodapé.

## Cadastro

Tela **Criar Conta**.

| Campo | Obrigatório | Regra | Mensagem quando está errado |
| --- | --- | --- | --- |
| Nome Completo ou Razão Social | Sim | Não pode ficar vazio. | Nome é obrigatório |
| CPF ou CNPJ | Sim | 11 dígitos (CPF) ou 14 (CNPJ). Pontos, traços e barras são ignorados. Os dígitos verificadores precisam estar corretos, e números com todos os dígitos iguais são recusados. | CPF ou CNPJ é obrigatório · CPF deve ter 11 dígitos ou CNPJ 14 dígitos · CPF inválido · CNPJ inválido |
| Endereço Completo | Sim | Não pode ficar vazio. | Endereço é obrigatório |
| Telefone / WhatsApp | Sim | 10 ou 11 dígitos contando o DDD. Parênteses, espaços e traços são ignorados. | Telefone é obrigatório · Telefone inválido (informe DDD + número) |
| E-mail | Sim | Formato `nome@dominio.com`. **[Lacuna]** E-mails com mais de um ponto depois do @ (`joao@uol.com.br`, `a@aluno.escola.edu.br`) ou com `+` (`x+y@gmail.com`) são **recusados por engano** na versão 2.0.0. Use outro e-mail. | E-mail é obrigatório · Digite um e-mail válido |
| Senha | Sim | No mínimo 6 caracteres. | Senha é obrigatória · A senha deve ter ao menos 6 caracteres |

Regra do servidor: **cada e-mail só pode ter uma conta**. Mensagem: **Este e-mail já está cadastrado**.

## Login

| Campo | Regra | Mensagem |
| --- | --- | --- |
| E-mail | Formato de e-mail (mesma limitação do cadastro). Espaços nas pontas são ignorados, mas **maiúsculas e minúsculas contam**. | E-mail é obrigatório · Digite um e-mail válido |
| Senha | Não pode ficar vazia. | Senha é obrigatório *(assim mesmo no app; no cadastro a frase é "obrigatória")* |

Regra do servidor: e-mail ou senha errados geram **Email ou senha inválidos**. Na senha, espaços contam.

## Nova Solicitação

| Campo | Obrigatório | Opções ou regra | Mensagem |
| --- | --- | --- | --- |
| Foto do resíduo | Não | Só pela câmera. Não dá para escolher uma foto da galeria. | — |
| Tipo de Resíduo | Sim | Orgânico · Reciclável · Construção Civil · Infectante · Eletrônico | Selecione o tipo de resíduo |
| Volume Estimado | Sim | Até 0,5m³ · Entre 0,5m³ e 1m³ · Acima de 1m³ | Selecione o volume estimado |
| Acondicionamento | Sim | Contêiner · Sacos Plásticos · Enfardado · Solto | Selecione o acondicionamento |
| Descrição detalhada dos itens | Sim | Texto livre, até 3 linhas visíveis. | Descrição é obrigatório |
| Endereço da Coleta | Sim | Texto livre. Não é preenchido a partir do cadastro. | Endereço é obrigatório |

O significado de cada tipo, volume e acondicionamento está em [Tipos de resíduo e dicas](08-residuos-e-dicas.md).

## Editar Coleta

| Campo | Regra |
| --- | --- |
| Tipo | Mesmas 5 opções da nova solicitação. |
| Descrição | Não pode ficar vazia. |
| Endereço | Não pode ficar vazio. |

Se algum estiver vazio: **Preencha todos os campos.**

## Perfil

| Campo | Regra | Mensagem |
| --- | --- | --- |
| Nome Completo | Não pode ficar vazio. | Nome é obrigatório |
| E-mail | Formato de e-mail (mesma limitação do cadastro). É gravado **exatamente como digitado**; veja o [aviso do perfil](05-atualizar-perfil.md#cuidados). | E-mail é obrigatório · Digite um e-mail válido |
| Telefone | 10 ou 11 dígitos com DDD. | Telefone é obrigatório · Telefone inválido (informe DDD + número) |
| Endereço Principal | Não pode ficar vazio. | Endereço é obrigatório |

---

*Fonte canônica: `lib/core/validators.dart` e os formulários em `lib/screens/`. **[Verificado]**: CPF/CNPJ, telefone e senha mínima são cobertos por `test/validators_test.dart`, que passou em 08/11/2026 (5 testes). A regra de e-mail foi testada só com `nome@email.com`; a recusa de `.com.br` foi conferida executando a mesma expressão regular. A frase "Descrição é obrigatório" está assim no app; o erro de concordância está registrado na [revisão](../processo/07-revisao-adversarial.md).*
