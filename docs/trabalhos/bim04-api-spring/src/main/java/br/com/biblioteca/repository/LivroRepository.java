package br.com.biblioteca.repository;

import br.com.biblioteca.model.Livro;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Acesso ao banco. O Spring Data JPA gera a implementação sozinho
 * (save, findById, findAll, deleteById...) e as consultas pelo nome do método.
 */
@Repository
public interface LivroRepository extends JpaRepository<Livro, Long> {

    List<Livro> findByAutorContainingIgnoreCase(String autor);

    List<Livro> findByDisponivel(boolean disponivel);

    boolean existsByIsbn(String isbn);

    boolean existsByIsbnAndIdNot(String isbn, Long id);
}
