# POP-01: publicar uma nova versão do app

> **Tipo:** procedimento operacional padrão · **Para:** quem da equipe publica o APK · [Voltar ao início](../README.md)

| Campo | Valor |
| --- | --- |
| Código / versão do POP | POP-01 · v1.0 |
| Responsável pela operação (owner) | Rafael R. Lourenço, guarda a chave de assinatura |
| Ambiente | Windows com Flutter SDK, repositório `ecocoleta_app`, GitHub Releases |
| Última revisão | 08/11/2026 |
| Próxima revisão | A cada nova versão publicada, ou em até 6 meses |
| Estado | **Rascunho para validação.** Os passos 1 a 5 seguem o README e o histórico da v2.0.0. Os passos marcados como *(não testado)* precisam ser executados pelo responsável antes de este POP ser considerado aprovado. |
| Impressão digital da chave (SHA-256) | `DE:D8:65:30:FE:83:4C:D2:57:FB:E5:6C:DB:4B:2B:EF:B7:26:F2:08:25:26:95:37:96:95:04:42:DC:FD:6D:88` (CN=EcoColeta). **[Verificado]** no APK publicado da v2.0.0 em 08/11/2026. |

## 1. Finalidade e escopo

Gerar o APK de release assinado e publicá-lo para que o botão **Baixar APK** do site entregue a versão nova, **sem impedir** que quem já tem o app atualize por cima.

**Quando aplicar:** toda vez que uma mudança no app (`lib/`, `android/`, `pubspec.yaml`) for liberada para os usuários.

**Quando NÃO aplicar:**
- Mudança só no site (`site/`): a Netlify publica sozinha.
- Mudança só na API: ela é publicada pelo próprio repositório da API.
- Teste interno: use `flutter run` ou um APK de debug, e nunca publique uma release para testar.

## 2. Responsáveis e permissões

- **Executa:** quem tiver os arquivos de assinatura (`android/app/ecocoleta-release.jks` e `android/key.properties`) e permissão de escrita no repositório do GitHub.
- **Aprova:** outro membro da equipe confere a release **em rascunho** (passo 8) antes que ela seja publicada (passo 9).

## 3. Pré-condições

- [ ] O código da nova versão está no ramo `main` e o `git status` não mostra alterações pendentes.
- [ ] O Flutter SDK está instalado (`flutter --version` responde).
- [ ] Os arquivos de assinatura estão presentes **e têm cópia de segurança fora deste computador**.
- [ ] A API em produção é compatível com a nova versão do app.
- [ ] Há um **celular de teste com a versão publicada atual** instalada, para testar a atualização por cima.
- [ ] O `apksigner` está disponível (vem no Android SDK, em `build-tools/<versão>/`).

## 4. Riscos e precauções

> ⚠️ **RISCO CRÍTICO E IRREVERSÍVEL: chave de assinatura**
> O APK precisa ser assinado **sempre com a mesma chave** (`ecocoleta-release.jks`, alias `ecocoleta`) e manter o identificador **`com.ecocoleta.app`**. Se a chave for perdida ou trocada, ou se o identificador mudar, **nenhum usuário consegue atualizar**: todos terão de desinstalar e instalar de novo. **Nunca** gere uma chave nova e **nunca** envie a chave ou o `key.properties` ao Git.

> ⚠️ **ATENÇÃO: o build não avisa quando a chave está errada.** Se o `android/key.properties` não existir, o `flutter build apk --release` **termina sem erro** e assina com a chave de *debug* (`android/app/build.gradle.kts`). Por isso o passo 5 confere a impressão digital.

> ⚠️ **Release pública é visível na hora.** O link `releases/latest/download/app-release.apk` passa a entregar o arquivo novo assim que a release for publicada. Um APK com defeito chega imediatamente a quem baixar.

## 5. Passos

| # | Ação | Resultado esperado |
| --- | --- | --- |
| 1 | Em `pubspec.yaml`, aumente `version`. Exemplo: de `2.0.0+2` para `2.0.1+3`. **O número depois do `+` sempre aumenta.** | O arquivo mostra a versão nova. |
| 2 | Rode `flutter test`. | `All tests passed!` |
| 3 | Rode `flutter analyze`. | `No issues found!` |
| 4 | Rode `flutter build apk --release`. | O arquivo `build/app/outputs/flutter-apk/app-release.apk` é gerado sem erro. |
| 5 | Confira a assinatura: `apksigner verify --print-certs build/app/outputs/flutter-apk/app-release.apk`. | A linha `certificate SHA-256 digest` é igual à impressão digital do cabeçalho, sem os `:` e em minúsculas. **Diferente: pare** (seção 6). |
| 5b | Instale esse APK **por cima** da versão publicada, no celular de teste. Entre e crie uma solicitação. | Instala sem pedir para desinstalar; login e solicitação funcionam. |
| 6 | Atualize o texto **"Versão X.Y.Z"** em `site/index.html` e o selo de versão no `README.md`. *(não testado neste POP)* | Site e README mostram a versão nova. |
| 7 | Faça commit e push das mudanças dos passos 1 e 6. | O push termina sem erro. |
| 8 | No GitHub, crie a release com a tag `vX.Y.Z` **como rascunho (Draft)** e anexe o arquivo com o nome **exatamente** `app-release.apk`. Nas notas, liste o que mudou. O aprovador confere os itens 1 a 4 da seção 7. *(não testado)* | Rascunho criado, ainda invisível ao público. |
| 9 | ⚠️ *Passo que torna a versão pública.* Com o aprovador de acordo, clique em **Publish release**. | A release aparece como **Latest**. |
| 10 | Verificação: em outro aparelho ou em aba anônima, abra o site e toque em **Baixar APK**. | O download traz o APK da versão nova, com o mesmo tamanho do arquivo gerado no passo 4. |

## 6. Exceções, interrupção e recuperação

| Situação | O que fazer |
| --- | --- |
| Os passos 2, 3 ou 4 falham | **Pare.** Não publique. Corrija e recomece pelo passo 2. |
| No passo 5 a impressão digital é diferente, ou no passo 5b o Android diz que **o app não foi instalado** ou que **o pacote conflita** | A assinatura está errada, provavelmente com a chave de debug. **Pare imediatamente.** Confira se `android/key.properties` existe e aponta para `ecocoleta-release.jks`, e refaça a partir do passo 4. Não publique. |
| A chave de assinatura sumiu | **Não gere outra.** Restaure a cópia de segurança. Sem cópia, avise a equipe toda: será preciso uma nova identidade do app, e todos os usuários terão de reinstalar. |
| A release publicada tem defeito | 1) Marque a release defeituosa como *pre-release*, para que a anterior volte a ser **Latest** e novos downloads recebam a versão boa. 2) **Isso não ajuda quem já instalou:** o Android não instala uma versão com número menor por cima. Por isso é **obrigatório** publicar logo uma versão de correção com o número depois do `+` maior. **[Criado pela equipe]** *(não testado)* |
| Qualquer dúvida sobre a assinatura | Escale para o owner deste POP antes de seguir. |

## 7. Verificação final (checklist do aprovador)

Itens 1 a 4: antes do passo 9, com a release em rascunho. Item 5: depois.

1. [ ] Versão nova no `pubspec.yaml`, no site e no README.
2. [ ] Testes e análise sem erros.
3. [ ] Impressão digital conferida (passo 5) e atualização por cima testada em celular (passo 5b).
4. [ ] Os arquivos de assinatura **não** estão no commit (`git status` limpo; `*.jks` e `key.properties` no `.gitignore`, **[Verificado]** em 08/11/2026).
5. [ ] Depois de publicar, o link do site baixa o arquivo novo (passo 10).

## 8. Registros

Registre nas notas da release: versão, data, quem executou, quem aprovou e o resumo das mudanças.

---

*Fontes: README do repositório (seção "Gerar o APK de release"); registro da publicação da v2.0.0 (29/09/2026); `android/app/build.gradle.kts` (recurso para a chave de debug); impressão digital obtida com `apksigner` 37.0.0. Os passos 2 e 3 foram executados em 08/11/2026 (`All tests passed!`, `No issues found!`). **Divergência encontrada:** o README diz que "o site não precisa ser alterado" a cada versão, mas `site/index.html` contém o texto fixo "Versão 2.0.0". O passo 6 resolve isso; veja a [revisão](../processo/07-revisao-adversarial.md).*
