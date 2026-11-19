package br.com.biblioteca.service;

import br.com.biblioteca.exception.RecursoNaoEncontradoException;
import br.com.biblioteca.exception.RegraDeNegocioException;
import br.com.biblioteca.model.Livro;
import br.com.biblioteca.repository.LivroRepository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * Regras de negócio dos livros. O controller chama o service e o service chama o repository.
 */
@Service
public class LivroService {

    private final LivroRepository repository;

    public LivroService(LivroRepository repository) {
        this.repository = repository;
    }

    public List<Livro> listar(String autor, Boolean disponivel) {
        if (autor != null && !autor.isBlank()) {
            return repository.findByAutorContainingIgnoreCase(autor);
        }
        if (disponivel != null) {
            return repository.findByDisponivel(disponivel);
        }
        return repository.findAll();
    }

    public Livro buscarPorId(Long id) {
        return repository.findById(id)
                .orElseThrow(() -> new RecursoNaoEncontradoException("Livro com id " + id + " não encontrado"));
    }

    @Transactional
    public Livro cadastrar(Livro livro) {
        if (repository.existsByIsbn(livro.getIsbn())) {
            throw new RegraDeNegocioException("Já existe um livro com o ISBN " + livro.getIsbn());
        }
        livro.setId(null);
        livro.setDisponivel(true);
        return repository.save(livro);
    }

    @Transactional
    public Livro atualizar(Long id, Livro dados) {
        Livro livro = buscarPorId(id);
        if (repository.existsByIsbnAndIdNot(dados.getIsbn(), id)) {
            throw new RegraDeNegocioException("Já existe outro livro com o ISBN " + dados.getIsbn());
        }
        livro.setTitulo(dados.getTitulo());
        livro.setAutor(dados.getAutor());
        livro.setAnoPublicacao(dados.getAnoPublicacao());
        livro.setIsbn(dados.getIsbn());
        return repository.save(livro);
    }

    @Transactional
    public void excluir(Long id) {
        Livro livro = buscarPorId(id);
        repository.delete(livro);
    }

    @Transactional
    public Livro emprestar(Long id) {
        Livro livro = buscarPorId(id);
        if (!livro.isDisponivel()) {
            throw new RegraDeNegocioException("O livro \"" + livro.getTitulo() + "\" já está emprestado");
        }
        livro.setDisponivel(false);
        return repository.save(livro);
    }

    @Transactional
    public Livro devolver(Long id) {
        Livro livro = buscarPorId(id);
        if (livro.isDisponivel()) {
            throw new RegraDeNegocioException("O livro \"" + livro.getTitulo() + "\" não está emprestado");
        }
        livro.setDisponivel(true);
        return repository.save(livro);
    }
}
