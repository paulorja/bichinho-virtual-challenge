### Spec

```
Criar um "bichinho virtual" com as seguintes propriedades:
- toda interatividade com o jogador se dá por meio da linha de comando
- o bichinho virtual tem um nome dado pelo jogador.
- o bichinho virtual tem três necessidades: comida, higiene e diversão
- cada necessidade tem cinco estágios. No estágio 0 a necessidade está totalmente
satisfeita e no estágio 4 ela não está nada satisfeita.
- a cada 50 segundos a necessidade de higiene aumenta em um nível.
- a cada 30 segundos a necessidade de comida aumenta em um nível.
- a cada 10 segundos a necessidade de diversão aumenta em um nível.
- caso todas as necessidades cheguem ao estágio 4, o bichinho virtual morre :(
- em um prompt na linha de comando, o jogador pode escolher entre três atividades:
alimentar, brincar e dar banho.
- a atividade de alimentar reduz a necessidade de comida ao estágio 0, mas aumenta a
necessidade de higiene em um nível.
- a atividade de brincar reduz a necessidade de diversão ao estágio 0, mas aumenta a
necessidade de higiene em um nível.
- a atividade de dar banho reduz a necessidade de higiene ao estágio 0.
- caso uma das necessidades atinja o estágio 4, qualquer incremento nas outras
necessidades é dobrado até que a necessidade volte pelo menos ao estágio 3.
- a cada mudança nas necessidades, uma mensagem informativa é exibida ao usuário.
- quando o bichinho morre, é informado quanto tempo ele viveu.
```
