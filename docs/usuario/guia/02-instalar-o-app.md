# Instalar o app no Android

> **Tipo:** como fazer · **Para:** quem vai instalar ou atualizar o EcoColeta · **Versão:** 2.0.0 · [Voltar ao início](../README.md)

O EcoColeta **não está na Play Store**. Ele é instalado por um arquivo APK baixado do site oficial.

## Requisitos

- Android **7.0 ou mais novo**. **[Verificado]**: o APK publicado declara `minSdkVersion 24` (Android 7.0).
- Espaço livre: o arquivo baixado tem cerca de **52 MB** (**[Verificado]**: 51.795.088 bytes em 08/11/2026). Depois de instalado, o app ocupa mais espaço que isso.
- Internet para baixar o arquivo e para usar o app.

O EcoColeta **não funciona em iPhone (iOS)**. Ao abrir o site em um iPhone, aparece o aviso de que o app existe só para Android.

## Instalar

1. No celular, abra **[ecocoleta-app.netlify.app](https://ecocoleta-app.netlify.app)**.
2. Toque em **Baixar APK** e espere o download terminar. O arquivo se chama `app-release.apk`.
3. Abra o arquivo, pela notificação do download ou pelo app **Arquivos**, na pasta **Downloads**.
4. Se o Android avisar que, **por segurança, o celular não tem permissão para instalar apps desta fonte**:
   1. Toque em **Configurações**.
   2. Ative **Permitir desta fonte**.
   3. Volte com o botão de voltar do Android.

   *O texto do aviso e o nome da opção mudam de acordo com a marca e a versão do Android. **[Lacuna]**: não testamos em cada marca.*
5. Toque em **Instalar**.
6. Toque em **Abrir**. Deve aparecer a tela verde com o título **EcoColeta**.

**Por que aparece o aviso de "fonte desconhecida"?** O Android mostra esse aviso para qualquer app que não venha da Play Store. O APK do EcoColeta é **assinado digitalmente** pela equipe do projeto. Baixe-o **somente** pelo site oficial ou pelo [link de download no GitHub](https://github.com/rafaellourenco10/ecocoleta_app/releases/latest/download/app-release.apk), nunca por outra origem.

## Atualizar para uma versão nova

Baixe o APK novo pelo mesmo botão e instale por cima do app atual. **Não é preciso desinstalar**, e a sua conta continua a mesma, porque os dados ficam no servidor e não no celular.

Se você tinha uma **versão 1.x** de testes, ela aparece como outro app: desinstale a antiga.

Se o Android disser que **o app não foi instalado** ou que **o pacote conflita com um existente**, você provavelmente tem uma cópia que não veio do site oficial. Nesse caso, desinstale o EcoColeta e instale de novo pelo site. Sua conta não é apagada.

## Desinstalar

Pressione e segure o ícone do EcoColeta e toque em **Desinstalar**, ou vá em **Configurações > Apps > EcoColeta > Desinstalar**.

Desinstalar **não apaga a sua conta nem as suas solicitações**. Para apagar a conta, veja [Perguntas frequentes](10-perguntas-frequentes.md#como-apago-minha-conta).

---

*Fontes: site oficial (seção Instalar, verificado no ar em 08/11/2026); `android/app/build.gradle.kts` (applicationId `com.ecocoleta.app`, `minSdk = flutter.minSdkVersion` = 24); APK publicado conferido com `aapt2` e `apksigner` em 08/11/2026: pacote `com.ecocoleta.app`, versão 2.0.0 (2), `minSdkVersion` 24, assinatura "CN=EcoColeta". As mensagens do Android vêm da documentação geral do sistema e variam por fabricante.*
