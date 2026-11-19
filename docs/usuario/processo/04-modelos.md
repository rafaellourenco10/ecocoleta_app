# Modelos de página

> **Tipo:** referência · **Para:** quem da equipe for criar uma página nova · [Voltar ao início](../README.md)

Copie o modelo do gênero certo e **apague as seções que não ajudarem o leitor**. Se não sabe qual gênero usar, veja a tabela de gêneros na [Estratégia](01-estrategia.md#gêneros-diátaxis-aplicados).

Regras que valem para todos os modelos:

- Título com o nome da tarefa ou do assunto, sem "Página sobre…".
- Linha de cabeçalho com tipo, leitor, versão e link de volta.
- Textos de tela **em negrito** e copiados exatamente do código.
- Marcações de estado por extenso: **[Verificado]**, **[Implementado]**, **[Criado pela equipe]**, **[Proposto]**, **[Lacuna]**.
- Avisos de ação irreversível **antes** do passo, começando com ⚠️ **Atenção** (o símbolo vem acompanhado da palavra, e não aparece sozinho).
- Imagem só com texto alternativo que descreva o que ela mostra.
- Rodapé de fontes.

## Tutorial

```markdown
# <Resultado que a pessoa vai alcançar>

> **Tipo:** tutorial · **Para:** <leitor iniciante> · **Versão:** <app X.Y.Z> · [Voltar ao início](../README.md)

<Uma frase: o que você vai fazer e quanto tempo leva.>

## Antes de começar
- <o que precisa ter em mãos>

## 1. <Etapa>
1. <ação concreta>
<O que você deve ver depois.>

## O que você aprendeu
## Próximos passos
---
*Fontes: <arquivos>. Estado: <marcação>.*
```

## Como fazer (how-to)

```markdown
# <Verbo + objeto: "Editar uma solicitação">

> **Tipo:** como fazer · **Para:** <quem já sabe o básico> · **Versão:** … · [Voltar ao início](../README.md)

<Quando usar esta página, em uma frase.>

## <Tarefa>
1. <passo>
<Resultado esperado.>

## Se der erro
<link para a página canônica de mensagens>
---
*Fontes: …*
```

## Referência

```markdown
# <Nome do assunto>

> **Tipo:** referência · **Para:** consulta · **Versão:** … · [Voltar ao início](../README.md)

<O que esta página cobre e o que fica em outra página.>

## <Grupo>
| <Item> | <Regra/valor> | <Mensagem/efeito> |
| --- | --- | --- |
---
*Fonte canônica: <arquivo>. Verificação: <teste/data>.*
```

## Explicação

```markdown
# <Como/por que X funciona>

> **Tipo:** explicação · **Para:** … · [Voltar ao início](../README.md)

## Em uma frase
## <Conceito>
<texto + figura opcional com descrição textual equivalente logo abaixo>
## O que <X> ainda não faz
---
*Fontes: …*
```

## POP

```markdown
# POP-<nº>: <atividade>

| Código / versão | Owner | Ambiente | Última revisão | Próxima revisão | Estado |
| --- | --- | --- | --- | --- | --- |

## 1. Finalidade e escopo (quando aplicar / quando NÃO aplicar)
## 2. Responsáveis e permissões
## 3. Pré-condições (checklist)
## 4. Riscos e precauções   ← avisos irreversíveis AQUI, antes dos passos
## 5. Passos
| # | Ação | Resultado esperado |
## 6. Exceções, interrupção, recuperação e escalonamento
## 7. Verificação final
## 8. Registros
---
*Fontes autorizadas. Passos não testados marcados com "(não testado)".*
```

## Jornada

```markdown
# Jornada: <público> para <objetivo>

| Público | Objetivo | Canal | Evidência | Período e método |
| --- | --- | --- | --- | --- |

## Etapas
| Etapa | Objetivo | Ações | Ponto de contato | Perguntas/necessidades | Fricções | Resultado | Evidência |

Cada célula traz o tipo: (Observação), (Citação), (Interpretação) ou (Hipótese).

## Lacunas de pesquisa
## Oportunidades a validar (não são soluções aprovadas)
```

## Registro de lacuna

```markdown
| ID | O que não sabemos | Onde afeta | Situação provisória | Decide quem | Estado |
| L<nº> | … | <páginas> | <texto usado enquanto isso, marcado [Criado pela equipe]> | … | Aberta/Decidida |
```
