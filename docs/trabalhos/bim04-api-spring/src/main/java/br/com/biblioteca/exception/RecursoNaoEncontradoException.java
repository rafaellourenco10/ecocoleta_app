package br.com.biblioteca.exception;

/**
 * Lançada quando um livro não existe. Vira resposta HTTP 404.
 */
public class RecursoNaoEncontradoException extends RuntimeException {

    public RecursoNaoEncontradoException(String mensagem) {
        super(mensagem);
    }
}
