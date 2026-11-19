package br.com.biblioteca.exception;

/**
 * Lançada quando uma regra de negócio é violada (ex.: ISBN repetido,
 * emprestar livro já emprestado). Vira resposta HTTP 409.
 */
public class RegraDeNegocioException extends RuntimeException {

    public RegraDeNegocioException(String mensagem) {
        super(mensagem);
    }
}
