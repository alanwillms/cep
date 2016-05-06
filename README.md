# CEP

Essa é uma reescrita do microserviço [goCep](https://github.com/eminetto/goCep),
com o objetivo de demonstrar o uso da linguagem de programação
[Crystal](http://crystal-lang.org/).

## Desenvolvimento

Certifique-se de ter o compilador do Crystal e a LibSSL instalados
(`apt-get install libssl-dev`).

Para compilar, execute o comando:

```
crystal build ./src/cep.cr --release
```

(A flag `--release` cria um binário otimizado.)

## Utilização

* Ajuda e opções: `./cep --help`
* Execução: `./cep start`

## Contributing

1. Fork it ( https://github.com/[your-github-name]/cep/fork )
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create a new Pull Request

## Contributors

- [[alanwillms]](https://github.com/[alanwillms]) Alan Willms - creator, maintainer
