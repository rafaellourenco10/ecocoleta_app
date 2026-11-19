# Revisão adversarial

> **Tipo:** relatório · **Prompt do B04-01:** 11 (Revisão adversarial) · **Revisado:** `docs/usuario/` em 08/11/2026, contra o código v2.0.0 (app e API) e o site · [Voltar ao início](../README.md)

## Como foi feita

- **Revisor independente:** a revisão foi feita por um revisor que **não escreveu** as páginas. Ele recebeu o prompt P11 do [banco de prompts](03-prompts.md#p11-revisão-adversarial--revisão) e acesso às mesmas fontes.
- **Método:** o revisor conferiu os textos de tela palavra por palavra contra o código. Também executou a expressão regular de e-mail do app com endereços reais e conferiu a configuração de assinatura do Android.
- **Correções:** quem escreveu aplicou as correções e conferiu de novo os pontos que dependiam de evidência nova. Por exemplo, baixou o APK publicado e leu a assinatura e o `minSdkVersion` dele.

**Veredito do revisor:** REVISAR, com 14 defeitos comprovados e 6 melhorias. Depois das correções abaixo, todos os defeitos comprovados foram **corrigidos na documentação** ou **registrados como lacuna**. Isso **não** equivale a conformidade integral: o [teste com leitores](06-plano-de-teste-com-leitores.md) ainda não foi feito.

## Defeitos comprovados

| # | Achado | Onde | Evidência | Consequência para o leitor | Tratamento |
| --- | --- | --- | --- | --- | --- |
| 1 | Contador de Minhas Coletas descrito como "não atualiza" | Guia 04, Guia 09, Jornada | `tela_inicial.dart:257` recalcula ao fechar a lista | Explicação falsa; "Fato do app" falso na jornada | **Corrigido** |
| 2 | E-mails `.com.br` e com `+` são recusados, e isso não estava documentado | Guia 01, 03, 07 | Expressão regular de `validators.dart:12`, executada: `joao@uol.com.br` → recusado | **Bloqueia o cadastro** de parte do público, e a página mandava "corrigir" um e-mail certo | **Documentado** como [Lacuna] nas 3 páginas e registrado como **L11** (defeito do app) |
| 3 | Trocar o e-mail no perfil pode trancar a conta | Guia 05, 03 | `tela_perfil.dart:60` não remove espaços; o login diferencia maiúsculas (`usuarios.routes.js:82`) | Perda de acesso sem recuperação | Aviso ⚠️ **Atenção** no perfil e na tabela de login; **L12** |
| 4 | Aviso de demora no passo errado do tutorial | Guia 01 | A primeira chamada ao servidor é o cadastro (`usuario_service.dart:17-31`) | A pessoa pode fechar o app no cadastro | **Corrigido**: aviso movido para o passo 2; "do dia" virou "depois de um tempo sem uso" |
| 5 | Critério da T3 impossível de observar | Plano de teste | A lista mostra só tipo e endereço (`tela_inicial.dart:526-530`) | Métrica inválida | **Corrigido** |
| 6 | Exclusão de conta prometida sem meio nem procedimento | FAQ, Plano, C5 | A API não tem rota para apagar usuário | Promessa ligada à LGPD sem caminho executável | **Corrigido** o texto, que agora diz "manual, pelo console"; o POP-02 ficou registrado como pendente em C5 |
| 7 | O build de release usa a chave de debug sem avisar, e o POP não detectava | POP-01 | `build.gradle.kts`: `findByName("release") ?: getByName("debug")` | Uma release que ninguém consegue instalar por cima | **Corrigido**: novo passo 5 com `apksigner` e a impressão digital SHA-256 conferida no APK publicado |
| 8 | Aprovação "antes de publicar" era impossível | POP-01 | O passo 8 já criava a release pública | Sem controle real de aprovação | **Corrigido**: release em **rascunho**, aprovação e só então publicação |
| 9 | Recuperação de release defeituosa incompleta | POP-01, C3 | O Android não instala uma versão menor por cima | Quem já baixou fica com o defeito | **Corrigido**: a versão de correção passou a ser obrigatória |
| 10 | Dicas atribuídas ao app, mas copiadas do site | Guia 08 | O texto difere de `tela_dicas.dart` | Viola a regra de cópia literal; "agende" contradiz o resto do guia | **Corrigido**: origem declarada e "agende" trocado por "peça" |
| 11 | Marcações de estado mal aplicadas | Guia 02, 03, 07, 08 | Sexta marcação inventada; [Verificado] sem teste; cuidados sem marcação | O leitor não sabe o que é confiável | **Corrigido** |
| 12 | A justificativa de "riscos internos não expostos" era falsa (o repositório é público) | Lacunas, Guia 06 | `gerar-pdf.mjs` inclui `processo/` | Falsa sensação de privacidade | **Corrigido**: decisão explícita, e o guia ganhou uma linha neutra |
| 13 | Mensagens no lugar errado | Guia 09 | "Erro … ao buscar coletas" aparece na lista (`tela_inicial.dart:472-486`); "Registro não encontrado" surge ao editar | O leitor procura no lugar errado | **Corrigido** |
| 14 | "Enquanto você digita" não vale para o login | Guia 07 | `tela_login.dart` não tem `autovalidateMode` | Pequena confusão | **Corrigido** |

## Melhorias

| # | Sugestão | Tratamento |
| --- | --- | --- |
| 15 | O canal de suporte (issues públicas) pode expor dados pessoais | **Feito**: aviso ⚠️ no FAQ e risco registrado em C4 |
| 16 | Fatos repetidos em várias páginas, como "20 a 50 s" | **Parcial**: o tutorial e o login passaram a apontar para [Como funciona](../guia/06-como-funciona.md#por-que-o-primeiro-acesso-demora). Repetições curtas ficaram onde o leitor precisa do número sem trocar de página. |
| 17 | O tutorial induzia dados falsos ("use Eletrônico") | **Feito** |
| 18 | Orientação sobre material infectante sem fonte | **Feito**: reduzida e com remissão à unidade de saúde ou à prefeitura; a dúvida ficou como lacuna |
| 19 | Quem tem a versão 1.x pode ficar com o app duplicado | **Feito**: uma linha no guia 02 e a dúvida registrada como **L13** |
| 20 | Pasta temporária `.omc` dentro de `guia/`; promessa de rodapé em todas as páginas | **Feito**: pasta removida e texto da estratégia ajustado |

## Problemas de texto no próprio app

Encontrados durante a documentação. Não são defeitos desta documentação, que reproduz o app com fidelidade, mas valem uma correção no app:

- "Descrição é obrigatório" e "Senha é obrigatório" (no login): erro de concordância, porque `Validators.obrigatorio` usa sempre "obrigatório".
- "Email ou senha inválidos" (servidor) e "E-mail" (app): grafia diferente.
- As mensagens técnicas do servidor ("Service Account", "Cloud Firestore", "console.developers.google.com") chegam ao cidadão sem tradução.
- O README e o site dizem "acompanhe o pedido", mas não existe acompanhamento (conflito C1 do [inventário](02-inventario-e-briefing.md#4-conflitos-encontrados-nas-fontes)).

## Checklist de saída do B04-01

| Item | Situação | Evidência |
| --- | --- | --- |
| Leitor, tarefa e gênero estão claros | ✅ Atendido | Cabeçalho de cada página; tabela de gêneros na [Estratégia](01-estrategia.md) |
| Afirmações importantes têm fonte ou estão marcadas como incertas | ✅ Atendido | Rodapé de fontes no guia e no POP; marcações de estado; achados 10 e 11 corrigidos |
| Intenção, implementação e verificação não foram misturadas | ✅ Atendido | Cinco marcações; [Proposto] separado de [Implementado] |
| Uma fonte canônica por assunto; links não duplicam contratos | ⚠️ Parcial | Tabela de fontes canônicas na Estratégia; ainda há repetições curtas (item 16) |
| POPs têm riscos, resultado verificável e caminho de exceção | ✅ Atendido | POP-01, seções 4 a 7 |
| Jornadas separam pesquisa observada de hipóteses | ✅ Atendido | A jornada é inteira declarada como hipótese, e as células dizem (Fato do app) ou (Hipótese) |
| Links, exemplos e imagens verificados; limitações registradas | ✅ Atendido | `gerar-pdf.mjs --externos` sem erros; APK, site e API conferidos no ar; limitações em [Lacunas](08-lacunas-e-decisoes.md) |
| A página continua útil sem depender de cor ou figura | ✅ Atendido | Marcações e avisos escritos por extenso; cada diagrama tem descrição em texto; imagens com texto alternativo |

*Os símbolos ✅ e ⚠️ vêm sempre acompanhados das palavras "Atendido" e "Parcial".*
