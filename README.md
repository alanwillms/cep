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

## Benchmarking

Fiz uma análise superficial e não encontrei nenhuma diferença significativa. As duas levaram em torno de 320s em todas as primeiras requisições e 2 a 5ms nas requisições cacheadas.

## Contributors

- [[alanwillms]](https://github.com/[alanwillms]) Alan Willms - creator, maintainer
