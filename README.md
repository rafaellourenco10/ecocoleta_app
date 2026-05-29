# ♻️ EcoColeta App

![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white)
![Node.js](https://img.shields.io/badge/Node.js-339933?style=for-the-badge&logo=nodedotjs&logoColor=white)
![Firebase](https://img.shields.io/badge/Firebase-FFCA28?style=for-the-badge&logo=firebase&logoColor=black)
![Render](https://img.shields.io/badge/Render-46E3B7?style=for-the-badge&logo=render&logoColor=white)

O **EcoColeta** é uma aplicação mobile focada em zeladoria urbana e gestão ambiental. O objetivo do sistema é conectar cidadãos e empresas ao serviço de coleta de descartes específicos (eletrônicos, recicláveis, entulhos, etc.), facilitando a logística e promovendo o descarte consciente.

Recentemente, o projeto passou por um **grande Refactoring de Arquitetura**, migrando de uma estrutura legada (PHP + MySQL) para uma stack moderna orientada a microsserviços na nuvem, utilizando **Node.js** e banco de dados NoSQL **Firebase Firestore**.

---

## 🚀 Funcionalidades Principais

- **Autenticação de Usuário:** Sistema de login seguro.
- **Cadastro Completo:** Registro de pessoas físicas e jurídicas (Nome/Razão Social, CPF/CNPJ, Endereço, Telefone, E-mail).
- **Gestão de Coletas (CRUD):** 
  - Solicitação de novas coletas com descrição de volume, tipo de resíduo e foto.
  - Listagem de histórico e coletas pendentes em tempo real.
  - Edição e cancelamento de solicitações de coleta.
- **Gestão de Perfil:** Visualização e atualização de dados do usuário.

---

## 🏗️ Arquitetura e Tecnologias (Atualizado)

O projeto adota uma arquitetura Client-Server na nuvem, garantindo escalabilidade, segurança e alta disponibilidade em conexões móveis (4G/Wi-Fi).

* **Frontend (Mobile):** Desenvolvido em **Flutter** (Dart). Utiliza o pacote `http` para comunicação RESTful padrão (GET, POST, PUT, DELETE) com abstração de rotas no módulo Core.
* **Backend (API REST):** Desenvolvida em **Node.js** utilizando o framework **Express**. A API centraliza as regras de negócio e a validação das rotas de usuários e coletas.
* **Banco de Dados:** **Firebase Firestore** (NoSQL). A API se comunica nativamente com o banco utilizando o *Firebase Admin SDK*.
* **Cloud Hosting:** A API Node.js está conteinerizada e hospedada na nuvem pelo serviço **Render**, garantindo que o aplicativo mobile funcione perfeitamente de qualquer rede.

---

## 📂 Estrutura do App (Frontend)

```text
lib/
 ┣ core/
 ┃ ┗ api_constants.dart       # Abstração da URL Base (Cloud) e endpoints REST
 ┣ screens/
 ┃ ┣ tela_cadastro.dart       # Formulário de registro de novos usuários
 ┃ ┣ tela_formulario.dart     # Cadastro e solicitação de novas coletas
 ┃ ┣ tela_inicial.dart        # Dashboard principal e listagem de histórico (CRUD)
 ┃ ┣ tela_login.dart          # Autenticação e entrada no sistema
 ┃ ┗ tela_perfil.dart         # Edição de perfil do usuário
 ┗ main.dart                  # Ponto de entrada da aplicação (MaterialApp)
```

---

## ⚙️ Como Executar o Projeto

Graças à nova infraestrutura na nuvem, rodar o projeto localmente se tornou extremamente simples, não sendo mais necessário configurar servidores Apache (XAMPP) ou bancos de dados na sua máquina.

### Pré-requisitos
- [Flutter SDK](https://flutter.dev/docs/get-started/install)
- Emulador Android/iOS ou um Smartphone físico.

### Passo a Passo

1. **Clone o repositório:**
   ```bash
   git clone https://github.com/rafaellourenco10/ecocoleta_app.git
   cd ecocoleta_app
   ```

2. **Baixe as dependências do Flutter:**
   ```bash
   flutter pub get
   ```

3. **Verifique as variáveis de conexão:**
   Abra o arquivo `lib/core/api_constants.dart` e garanta que a constante `baseUrl` esteja apontando para a sua API no Render (Ex: `https://ecocoleta-api-imd4.onrender.com/api`).

4. **Execute o Aplicativo:**
   Conecte seu celular físico ou abra seu emulador e digite:
   ```bash
   flutter run
   ```

> **Nota para Desenvolvedores Backend:** 
> Se desejar rodar a API Node.js localmente, mude a URL base no Flutter para `http://<seu-ip-local>:3000/api` e inicie o servidor com `node src/index.js` na pasta da API, contendo seu arquivo `.env` com as credenciais do Firebase.

---

## 👨‍💻 Autor

**Rafael R. Lourenço**

Desenvolvido como um ecossistema completo (Full Stack) de zeladoria urbana, com foco em arquiteturas escaláveis na nuvem.
