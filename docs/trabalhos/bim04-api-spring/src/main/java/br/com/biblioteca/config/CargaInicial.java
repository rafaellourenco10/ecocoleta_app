package br.com.biblioteca.config;

import br.com.biblioteca.model.Livro;
import br.com.biblioteca.repository.LivroRepository;
import org.springframework.boot.CommandLineRunner;
import org.springframework.stereotype.Component;

import java.util.List;

/**
 * Cadastra alguns livros quando a API sobe, para já ter dados para testar.
 */
@Component
public class CargaInicial implements CommandLineRunner {

    private final LivroRepository repository;

    public CargaInicial(LivroRepository repository) {
        this.repository = repository;
    }

    @Override
    public void run(String... args) {
        if (repository.count() > 0) {
            return;
        }
        repository.saveAll(List.of(
                new Livro("Dom Casmurro", "Machado de Assis", 1899, "978-8535910667"),
                new Livro("O Cortiço", "Aluísio Azevedo", 1890, "978-8508133024"),
                new Livro("Clean Code", "Robert C. Martin", 2008, "978-0132350884")
        ));
    }
}
