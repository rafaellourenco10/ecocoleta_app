package br.com.biblioteca.controller;

import br.com.biblioteca.model.Livro;
import br.com.biblioteca.service.LivroService;
import jakarta.validation.Valid;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.support.ServletUriComponentsBuilder;

import java.net.URI;
import java.util.List;

/**
 * Endpoints REST da API de livros.
 *
 * GET    /livros                  lista todos (filtros opcionais: ?autor=  ou  ?disponivel=)
 * GET    /livros/{id}             busca um livro
 * POST   /livros                  cadastra
 * PUT    /livros/{id}             atualiza
 * DELETE /livros/{id}             exclui
 * PATCH  /livros/{id}/emprestar   marca como emprestado
 * PATCH  /livros/{id}/devolver    marca como disponível
 */
@RestController
@RequestMapping("/livros")
public class LivroController {

    private final LivroService service;

    public LivroController(LivroService service) {
        this.service = service;
    }

    @GetMapping
    public List<Livro> listar(@RequestParam(required = false) String autor,
                              @RequestParam(required = false) Boolean disponivel) {
        return service.listar(autor, disponivel);
    }

    @GetMapping("/{id}")
    public Livro buscar(@PathVariable Long id) {
        return service.buscarPorId(id);
    }

    @PostMapping
    public ResponseEntity<Livro> cadastrar(@RequestBody @Valid Livro livro) {
        Livro salvo = service.cadastrar(livro);
        URI local = ServletUriComponentsBuilder.fromCurrentRequest()
                .path("/{id}").buildAndExpand(salvo.getId()).toUri();
        return ResponseEntity.created(local).body(salvo);
    }

    @PutMapping("/{id}")
    public Livro atualizar(@PathVariable Long id, @RequestBody @Valid Livro livro) {
        return service.atualizar(id, livro);
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> excluir(@PathVariable Long id) {
        service.excluir(id);
        return ResponseEntity.noContent().build();
    }

    @PatchMapping("/{id}/emprestar")
    public Livro emprestar(@PathVariable Long id) {
        return service.emprestar(id);
    }

    @PatchMapping("/{id}/devolver")
    public Livro devolver(@PathVariable Long id) {
        return service.devolver(id);
    }
}
