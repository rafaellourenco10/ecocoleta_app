# Estudo de caso: o papel do Maven em um projeto Spring

**Atividade:** BIM04, Estudo de caso · **Aluno:** Rafael R. Lourenço · **Data:** 08/11/2026

**Caso estudado:** a API REST de biblioteca (`biblioteca-api`) feita em Spring Boot 3.3.5 no trabalho bimestral do BIM04

## 1. Resumo

O Maven é a ferramenta que **monta** um projeto Spring. Ele baixa as bibliotecas de que o projeto precisa, compila o código, roda os testes e gera o arquivo final executável. Tudo isso é descrito em um único arquivo XML, o `pom.xml`.

No caso estudado, um `pom.xml` de **50 linhas** declarou apenas **4 dependências**. A partir delas, o Maven resolveu **66 bibliotecas**, escolheu a versão de cada uma e gerou um único `.jar` de **47 MB** que sobe a API com um comando. Sem o Maven, o desenvolvedor teria que baixar, combinar as versões e montar essas 66 bibliotecas à mão.

## 2. O caso

A `biblioteca-api` é uma API REST de cadastro, empréstimo e devolução de livros. Ela tem 9 classes Java organizadas em camadas (controller, service, repository, model, exception e config) e usa:

- **Spring Web** para os endpoints REST;
- **Spring Data JPA** com Hibernate para acessar o banco;
- **Bean Validation** para validar os dados recebidos;
- **H2**, um banco de dados em memória.

O projeto foi compilado e testado com o **Maven 3.9.9** e o **JDK 21**. Os números deste estudo saíram dos comandos `mvn dependency:tree`, `mvn help:effective-pom` e `mvn package`, executados nesse projeto.

## 3. Qual é o papel do Maven no Spring

O Spring não compila nem empacota nada sozinho: ele é um conjunto de bibliotecas. Quem junta essas bibliotecas ao código do projeto é uma ferramenta de build, e o Maven é a mais usada para isso, ao lado do Gradle. No Spring, o Maven cumpre cinco papéis.

### 3.1 Gerenciar as dependências

O desenvolvedor declara **o que** quer usar e o Maven descobre **tudo o que isso exige**. Ao declarar `spring-boot-starter-web`, o projeto recebe também o Tomcat embutido, o Jackson (conversão de JSON), o Spring MVC e o Logback, porque cada biblioteca declara as próprias dependências. Essas são as **dependências transitivas**.

As bibliotecas são baixadas do **Maven Central**, o repositório público, e guardadas no **repositório local** (`~/.m2/repository`). Assim cada versão é baixada uma vez só e reaproveitada por todos os projetos da máquina.

### 3.2 Padronizar a estrutura do projeto

O Maven adota a ideia de **convenção em vez de configuração**: se o projeto seguir a estrutura padrão, não é preciso dizer onde está nada.

```text
biblioteca-api/
├── pom.xml                      configuração do projeto
└── src/
    ├── main/
    │   ├── java/                código-fonte (as 9 classes da API)
    │   └── resources/           application.properties, arquivos estáticos
    └── test/
        └── java/                testes automatizados
```

O resultado do build vai para a pasta `target/`, que nunca é versionada no Git.

### 3.3 Executar o ciclo de vida do build

O Maven organiza o build em **fases** que rodam sempre na mesma ordem. Pedir uma fase executa também todas as anteriores.

| Fase | O que faz |
| --- | --- |
| `validate` | Confere se o projeto e o `pom.xml` estão corretos |
| `compile` | Compila o código de `src/main/java` |
| `test` | Compila e roda os testes de `src/test/java` |
| `package` | Empacota o projeto (no Spring Boot, gera o `.jar` executável) |
| `verify` | Roda as verificações de qualidade e de integração |
| `install` | Copia o pacote para o repositório local, para outros projetos usarem |
| `deploy` | Publica o pacote em um repositório remoto |

Existem ainda o ciclo `clean`, que apaga a pasta `target/`, e o ciclo `site`, que gera a documentação do projeto. Por isso o comando mais comum é `mvn clean package`.

### 3.4 Garantir versões compatíveis entre si

Este é o papel mais importante do Maven **especificamente no Spring Boot**. O Spring Boot publica uma lista de versões testadas juntas, chamada de **BOM** (*Bill of Materials*). O projeto herda essa lista pelo `parent` do `pom.xml`. Por isso, no caso estudado, as dependências foram declaradas **sem versão**: o Maven pegou do BOM a versão certa de cada uma.

| Biblioteca | Versão escolhida pelo BOM do Spring Boot 3.3.5 |
| --- | --- |
| Spring Framework | 6.1.14 |
| Tomcat embutido | 10.1.31 |
| Hibernate | 6.5.3.Final |
| Jackson | 2.17.2 |
| H2 | 2.2.224 |

Para atualizar todas elas de uma vez, basta trocar a versão do `parent`.

### 3.5 Gerar o jar executável

O plugin `spring-boot-maven-plugin` transforma o `.jar` comum em um **jar executável** (*fat jar*): o código do projeto, as 58 bibliotecas de execução e o servidor Tomcat ficam dentro de um único arquivo. A API sobe sem instalar servidor nenhum:

```bash
java -jar target/biblioteca-api-1.0.0.jar
```

O mesmo plugin oferece o comando `mvn spring-boot:run`, que roda a aplicação direto do código, sem gerar o jar.

## 4. Como configurar

### 4.1 Pré-requisitos

1. Instalar um **JDK 17 ou mais novo**, que é o mínimo do Spring Boot 3.
2. Criar a variável de ambiente `JAVA_HOME` apontando para a pasta do JDK.

### 4.2 Instalar o Maven (ou usar o Maven Wrapper)

Existem dois caminhos.

**Caminho 1: instalar o Maven na máquina**

1. Baixar o arquivo binário em [maven.apache.org/download.cgi](https://maven.apache.org/download.cgi).
2. Descompactar em uma pasta, por exemplo `C:\apache-maven-3.9.9`.
3. Acrescentar a pasta `bin` do Maven à variável `PATH`.
4. Conferir a instalação:

```bash
mvn -v
```

O comando mostra a versão do Maven, a do Java e o `JAVA_HOME` em uso.

**Caminho 2: usar o Maven Wrapper (recomendado)**

Projetos gerados pelo Spring Initializr já trazem os arquivos `mvnw` (Linux e macOS), `mvnw.cmd` (Windows) e a pasta `.mvn/wrapper/`. O wrapper baixa sozinho a versão certa do Maven na primeira execução. Assim, todo mundo da equipe e o servidor de CI usam a mesma versão, sem instalar nada:

```bash
./mvnw clean package        # Linux e macOS
mvnw.cmd clean package      # Windows
```

> **No caso estudado**, o projeto foi montado à mão, sem o wrapper, e a máquina não tinha o Maven instalado. Foi preciso baixar o Maven 3.9.9 e apontar o `JAVA_HOME` para o JDK que vem com o Android Studio. O wrapper teria evitado esse passo.

### 4.3 Criar o projeto Spring com Maven

O jeito mais simples é o **Spring Initializr** ([start.spring.io](https://start.spring.io)), que também está embutido no IntelliJ e no VS Code:

1. Em **Project**, escolher **Maven**.
2. Escolher a linguagem (Java), a versão do Spring Boot e a do Java.
3. Preencher **Group** e **Artifact**, que viram o `groupId` e o `artifactId` do `pom.xml`.
4. Adicionar as dependências (no caso: Spring Web, Spring Data JPA, Validation e H2 Database).
5. Clicar em **Generate** e abrir o projeto na IDE. A IDE lê o `pom.xml` e baixa as dependências sozinha.

### 4.4 Configurações da máquina: o settings.xml

O `pom.xml` descreve o **projeto**. O que é da **máquina** fica no `settings.xml`, que não vai para o Git:

| Arquivo | Vale para |
| --- | --- |
| `~/.m2/settings.xml` | O usuário |
| `<pasta do Maven>/conf/settings.xml` | Todos os usuários da máquina |

Nele se configuram o proxy da rede, os *mirrors* (repositórios que substituem o Maven Central, comuns em empresas), as senhas dos repositórios privados (`<servers>`) e outro local para o repositório local (`<localRepository>`). Senha nunca deve ir no `pom.xml`, porque ele é compartilhado.

### 4.5 Comandos do dia a dia

| Comando | Para que serve |
| --- | --- |
| `mvn clean package` | Apaga o build anterior, compila, testa e gera o jar |
| `mvn clean package -DskipTests` | O mesmo, sem rodar os testes |
| `mvn spring-boot:run` | Sobe a aplicação a partir do código |
| `mvn test` | Roda só os testes |
| `mvn dependency:tree` | Mostra a árvore de dependências |
| `mvn help:effective-pom` | Mostra o POM completo, com tudo o que foi herdado |

## 5. Como funciona o arquivo de configuração (pom.xml)

### 5.1 O que é o POM

O `pom.xml` é o **POM** (*Project Object Model*): um arquivo XML na raiz do projeto que descreve o projeto como um objeto. Ele diz quem o projeto é, do que depende e como deve ser construído.

O POM é **declarativo**: ele descreve o resultado esperado e não os passos para chegar lá. Não há comandos como "baixe tal arquivo" ou "compile tal pasta". Os passos ficam a cargo do Maven e dos plugins.

### 5.2 Herança: o POM que o desenvolvedor não vê

Todo POM herda configurações de outro:

```text
Super POM (embutido no Maven: Maven Central, estrutura de pastas, plugins padrão)
  └── spring-boot-dependencies (o BOM: versões de mais de mil bibliotecas)
        └── spring-boot-starter-parent (Java, encoding UTF-8, configuração dos plugins)
              └── pom.xml do projeto (o que o desenvolvedor escreve)
```

O Maven junta tudo isso e trabalha com o resultado, chamado de **POM efetivo**. No caso estudado, o `pom.xml` tem **50 linhas** e o POM efetivo, gerado com `mvn help:effective-pom`, tem **8.524 linhas** e **1.515 declarações de dependência**. A maior parte são as versões do BOM, que só valem quando o projeto usa a biblioteca correspondente. É por isso que um `pom.xml` de Spring Boot é tão curto.

### 5.3 O caso: o pom.xml da biblioteca-api comentado

```xml
<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0" ...>

    <!-- Versão do formato do POM. É sempre 4.0.0 no Maven 2 e 3. -->
    <modelVersion>4.0.0</modelVersion>

    <!-- Herança: traz o BOM e as configurações padrão do Spring Boot. -->
    <parent>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-starter-parent</artifactId>
        <version>3.3.5</version>
        <relativePath/>   <!-- procura o pai no repositório, e não em uma pasta vizinha -->
    </parent>

    <!-- Coordenadas: a identidade única do projeto. -->
    <groupId>br.com.biblioteca</groupId>
    <artifactId>biblioteca-api</artifactId>
    <version>1.0.0</version>

    <!-- Variáveis. O parent usa java.version para configurar o compilador. -->
    <properties>
        <java.version>17</java.version>
    </properties>

    <!-- Dependências: o que o projeto usa. Sem <version>, ela vem do BOM. -->
    <dependencies>
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-web</artifactId>
        </dependency>
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-data-jpa</artifactId>
        </dependency>
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-validation</artifactId>
        </dependency>
        <dependency>
            <groupId>com.h2database</groupId>
            <artifactId>h2</artifactId>
            <scope>runtime</scope>   <!-- só é preciso na execução, não na compilação -->
        </dependency>
    </dependencies>

    <!-- Build: os plugins que executam as fases. -->
    <build>
        <plugins>
            <plugin>
                <groupId>org.springframework.boot</groupId>
                <artifactId>spring-boot-maven-plugin</artifactId>
            </plugin>
        </plugins>
    </build>
</project>
```

O que essas 4 dependências trouxeram, segundo o `mvn dependency:tree`:

| Dependência declarada | Principais bibliotecas trazidas junto |
| --- | --- |
| `spring-boot-starter-web` | Spring MVC, Tomcat embutido, Jackson, Logback |
| `spring-boot-starter-data-jpa` | Hibernate, Spring Data JPA, HikariCP (pool de conexões), Spring Transaction |
| `spring-boot-starter-validation` | Hibernate Validator (Bean Validation) |
| `h2` | O banco H2 em memória |
| **Total** | **66 bibliotecas resolvidas, 58 empacotadas no jar final** |

Os *starters* do Spring Boot são exatamente isso: dependências que só servem para agrupar outras. Um starter resolve uma necessidade inteira ("quero fazer uma API web") em vez de uma biblioteca de cada vez.

## 6. A estrutura de informações do POM

O POM é uma **árvore XML** com a raiz `<project>`. Os elementos se dividem em quatro grupos.

### 6.1 Identificação: as coordenadas

Todo artefato Maven, seja um projeto ou uma biblioteca, é identificado por três coordenadas, chamadas de **GAV**:

| Elemento | Significado | No caso |
| --- | --- | --- |
| `groupId` | Organização ou grupo, normalmente o domínio invertido | `br.com.biblioteca` |
| `artifactId` | Nome do projeto dentro do grupo | `biblioteca-api` |
| `version` | Versão. O sufixo `-SNAPSHOT` indica versão em desenvolvimento | `1.0.0` |
| `packaging` | Tipo de pacote: `jar` (padrão), `war` ou `pom` | `jar` (padrão, omitido) |

As coordenadas também definem onde o arquivo fica no repositório. O starter web do caso, por exemplo, fica em `org/springframework/boot/spring-boot-starter-web/3.3.5/`. O nome do jar gerado segue o padrão `artifactId-version.jar`, por isso o caso gerou `biblioteca-api-1.0.0.jar`.

Elementos como `name`, `description`, `url`, `licenses` e `developers` são opcionais e só servem para documentar o projeto.

### 6.2 Relações com outros projetos

| Elemento | Para que serve |
| --- | --- |
| `<parent>` | Herda a configuração de outro POM |
| `<dependencies>` | Lista as bibliotecas que o projeto usa |
| `<dependencyManagement>` | Fixa versões **sem** incluir a biblioteca. É assim que o BOM funciona |
| `<modules>` | Junta vários subprojetos em um projeto multimódulo |

Cada dependência pode ter um **escopo**, que diz em que momento ela é usada:

| Escopo | Quando a dependência está disponível | Exemplo |
| --- | --- | --- |
| `compile` (padrão) | Compilação, testes e execução | `spring-boot-starter-web` |
| `runtime` | Só testes e execução | Driver do banco, como o `h2` do caso |
| `test` | Só testes | `spring-boot-starter-test` (JUnit, Mockito) |
| `provided` | Compilação e testes; na execução, quem fornece é o servidor | `spring-boot-starter-tomcat` quando o app é um `war` instalado em um Tomcat externo |
| `import` | Só dentro de `<dependencyManagement>`, para importar um BOM | `spring-boot-dependencies` |

Dentro de uma dependência também é possível usar `<optional>` e `<exclusions>`. As exclusões servem, por exemplo, para trocar o Tomcat pelo Jetty: exclui-se `spring-boot-starter-tomcat` do starter web e se declara `spring-boot-starter-jetty`.

### 6.3 Configuração do build

| Elemento | Para que serve |
| --- | --- |
| `<properties>` | Variáveis reutilizáveis, lidas com `${nome}` |
| `<build>` | Configuração da construção do projeto |
| `<build><plugins>` | Plugins e seus *goals* (cada fase do ciclo de vida é executada por um plugin) |
| `<build><resources>` | Pastas de recursos e o filtro de variáveis dentro delas |
| `<build><finalName>` | Muda o nome do arquivo gerado |

### 6.4 Ambiente

| Elemento | Para que serve |
| --- | --- |
| `<repositories>` | Repositórios extras, além do Maven Central |
| `<pluginRepositories>` | Repositórios extras para os plugins |
| `<profiles>` | Configurações alternativas, ativadas com `-P` (por exemplo, `mvn package -Pproducao`) |
| `<distributionManagement>` | Para onde o `mvn deploy` publica o pacote |

### 6.5 Resumo da estrutura

```text
<project>
├── modelVersion                         formato do POM
├── parent                               herança
├── groupId · artifactId · version       identificação (GAV)
├── packaging · name · description       tipo e documentação
├── properties                           variáveis
├── dependencyManagement                 controle de versões
├── dependencies                         o que o projeto usa
│   └── dependency (GAV + scope + exclusions)
├── build                                como construir
│   └── plugins → plugin (GAV + configuration + executions)
├── repositories                         de onde baixar
├── profiles                             variações por ambiente
└── modules                              subprojetos
</project>
```

## 7. Conclusão

No Spring, o Maven não é um detalhe: é ele que transforma 4 linhas de intenção ("quero web, JPA, validação e H2") em 66 bibliotecas de versões compatíveis e em um único arquivo executável. O `pom.xml` funciona por **declaração** e **herança**. O projeto declara só o que é dele e herda do Spring Boot todas as decisões de versão e de build. Por isso o arquivo do caso tem 50 linhas, enquanto a configuração que o Maven realmente usa passa de 8.500.

A recomendação que sai do caso é sempre criar o projeto pelo Spring Initializr e usar o **Maven Wrapper**, para que todos os ambientes construam o projeto com a mesma versão do Maven.

## Referências

- APACHE MAVEN. *Introduction to the POM*. Disponível em: https://maven.apache.org/guides/introduction/introduction-to-the-pom.html. Acesso em: 8 nov. 2026.
- APACHE MAVEN. *POM Reference*. Disponível em: https://maven.apache.org/pom.html. Acesso em: 8 nov. 2026.
- APACHE MAVEN. *Introduction to the Build Lifecycle*. Disponível em: https://maven.apache.org/guides/introduction/introduction-to-the-lifecycle.html. Acesso em: 8 nov. 2026.
- APACHE MAVEN. *Introduction to the Dependency Mechanism*. Disponível em: https://maven.apache.org/guides/introduction/introduction-to-dependency-mechanism.html. Acesso em: 8 nov. 2026.
- SPRING. *Spring Boot Maven Plugin Documentation*. Disponível em: https://docs.spring.io/spring-boot/maven-plugin/index.html. Acesso em: 8 nov. 2026.
- SPRING. *Build Systems: Dependency Management and Starters*. Disponível em: https://docs.spring.io/spring-boot/reference/using/build-systems.html. Acesso em: 8 nov. 2026.
