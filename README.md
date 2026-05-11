# ♻️ EcoColeta App

![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white)
![PHP](https://img.shields.io/badge/PHP-777BB4?style=for-the-badge&logo=php&logoColor=white)
![MySQL](https://img.shields.io/badge/MySQL-4479A1?style=for-the-badge&logo=mysql&logoColor=white)

O **EcoColeta** é uma aplicação mobile focada em zeladoria urbana e gestão ambiental. O objetivo do sistema é conectar cidadãos e empresas ao serviço de coleta de descartes específicos (eletrônicos, recicláveis, etc.), facilitando a logística e promovendo o descarte consciente.

## 🚀 Funcionalidades

- **Autenticação de Usuário:** Tela de login responsiva.
- **Cadastro Completo:** Registro de pessoas físicas e jurídicas (Nome/Razão Social, CPF/CNPJ, Endereço, Telefone, E-mail).
- **Solicitação de Coleta:** Formulário dinâmico para registrar o tipo de material a ser descartado e o endereço de coleta.
- **Integração REST:** Comunicação em tempo real com API própria construída em PHP.

## 🏗️ Arquitetura e Tecnologias

O projeto adota uma arquitetura client-server (Mobile + API), garantindo desacoplamento entre a interface do usuário e as regras de negócio.

* **Frontend (Mobile):** Desenvolvido em **Flutter** (Dart), utilizando o padrão `StatefulWidget`/`StatelessWidget` para gerência de estado local e navegação via `Navigator`.
* **Backend (API):** Scripts em **PHP** puro processando requisições HTTP (POST) e retornando status codes adequados.
* **Banco de Dados:** **MySQL** relacional gerenciando as entidades de `usuarios` e `coletas`.
* **Comunicação:** Pacote `http` do Flutter consumindo endpoints da API.

## 📂 Estrutura de Diretórios (Frontend)

```text
lib/
 ┣ screens/
 ┃ ┣ tela_cadastro.dart     # Formulário de registro de novos usuários
 ┃ ┣ tela_formulario.dart   # Formulário de solicitação de coletas
 ┃ ┣ tela_inicial.dart      # Dashboard / Tela principal pós-login
 ┃ ┗ tela_login.dart        # Autenticação e entrada
 ┗ main.dart                # Ponto de entrada da aplicação (MaterialApp)

⚙️ Como Executar o Projeto Localmente
Para rodar este projeto na sua máquina, você precisará do Flutter SDK e do XAMPP (ou servidor web equivalente com PHP e MySQL).

1. Configurando o Backend (Banco de Dados e API)
Inicie o Apache e o MySQL no XAMPP Control Panel.

Acesse o phpMyAdmin (http://localhost/phpmyadmin) e crie um banco de dados chamado ecocoleta.

Execute as seguintes queries SQL para criar as tabelas necessárias:
CREATE TABLE usuarios (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    cpf_cnpj VARCHAR(20) NOT NULL,
    endereco VARCHAR(255) NOT NULL,
    telefone VARCHAR(20) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    senha VARCHAR(255) NOT NULL,
    criado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE coletas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    usuario_id INT NOT NULL,
    descricao_item VARCHAR(255) NOT NULL,
    endereco VARCHAR(255) NOT NULL,
    url_foto VARCHAR(255),
    status ENUM('Pendente', 'Agendada', 'Concluida') DEFAULT 'Pendente',
    data_solicitacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

Copie os arquivos PHP da API (conexao.php, cadastrar_usuario.php, cadastrar_coleta.php) para a pasta htdocs/ecocoleta do seu XAMPP.

2. Configurando o Frontend (Flutter)
Clone o repositório:

git clone [https://github.com/SEU_USUARIO/ecocoleta-app.git](https://github.com/SEU_USUARIO/ecocoleta-app.git)

Acesse a pasta do projeto e baixe as dependências:
cd ecocoleta-app
flutter pub get

3. Variáveis de Ambiente (Atenção!)
Como o emulador/celular físico não reconhece localhost como sendo o seu computador, é necessário apontar o IP da sua máquina local nos arquivos do Flutter.

Abra os arquivos abaixo e substitua o IP 192.168.X.X pelo IP local da sua rede (IPv4):

lib/screens/tela_cadastro.dart

lib/screens/tela_formulario.dart

4. Rodando o App
Conecte seu dispositivo físico via Depuração USB ou inicie um emulador e execute:
flutter run

👨‍💻 Autor
Rafael R. Lourenço

Desenvolvido como projeto Full Stack de zeladoria urbana.
