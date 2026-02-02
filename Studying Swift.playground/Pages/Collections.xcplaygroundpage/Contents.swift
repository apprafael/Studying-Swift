import Foundation

// =====================================================
// Seção 1: Declaração de Arrays (Coleções) e Tipagem
// =====================================================

var frutas: [String] = ["Maçã", "Banana", "Laranja", "Uva", "Manga"]
var valores: [Double] = [1.10, 2.20, 3.30]

// Array usando Any (evite em produção, só para demonstração)
var arrayAny: [Any] = ["Carro", 10, 10.0, false]

// =====================================================
// Seção 2: Leitura, Acesso e Propriedades de Arrays
// =====================================================

// Itera e imprime cada fruta
for item in frutas {
    print(item)
}

// Quantidade de elementos
frutas.count

// Primeiro elemento (opcional) e acesso direto por índice
frutas.first
frutas[0]

// Último elemento (opcional) e acesso direto por índice
frutas.last
frutas[frutas.count - 1]

// Verifica se está vazio
frutas.isEmpty

// =====================================================
// Seção 3: Modificação de Arrays (Inserção, Remoção, Ordenação)
// =====================================================

// Troca posições (swap) entre índices 2 e 0
frutas.swapAt(2, 0)

// Adiciona elemento ao final
frutas.append("Abacate")
// Insere elemento em posição específica
frutas.insert("Figo", at: 3)

// Inverte a ordem atual (in-place)
frutas.reverse()

// Ordena alfabeticamente (in-place)
frutas.sort()
// Ordena valores numéricos (in-place)
valores.sort()

// Remove todos os elementos que satisfazem a condição
frutas.removeAll { item in
    item.count > 5
}

// Filtra (gera um novo array, não altera o original)
frutas.filter { item in
    item.count > 5
}

// =====================================================
// Seção 4: Operação com múltiplos Arrays
// =====================================================

let novasFrutas = ["Melão", "Morango"]
// Adiciona o conteúdo de outro array ao final
frutas.append(contentsOf: novasFrutas)

// =====================================================
// Seção 5: Iteração e Type Casting em Arrays
// =====================================================

// Itera e imprime cada item do array
for item in arrayAny {
    print(item)
    
    // Exemplo de casting seguro: se for Int, soma com ele mesmo
    if let numero = item as? Int {
        print(numero + numero)
    }
}

// forEach para iteração simples
arrayAny.forEach { print($0) }

// Acesso a par (índice, elemento) via enumerated
arrayAny.enumerated().last?.offset
arrayAny.enumerated().last?.element

// Acesso seguro por índice (importante para evitar crash)
let index = 3

if arrayAny.count - 1 >= index {
    arrayAny[index]
}

// =====================================================
// Seção 6: Arrays de Tipos Customizados e Map
// =====================================================

struct Pessoas {
    let name: String
    let date: Date
}

// Array de objetos Pessoas
var pessoas: [Pessoas] = [
    Pessoas(
        name: "Rafael",
        date: Date(timeInterval: 100000, since: Date())
    ),
    Pessoas(
        name: "Andre",
        date: Date(timeInterval: 0, since: Date())
    )
]

// Ordenação por propriedade (nome)
pessoas.sort { pessoas1, pessoas2 in
    pessoas1.name < pessoas2.name
}

// Map para extrair nomes
var nomeDePessoas = pessoas.map { pessoa in
    pessoa.name
}
nomeDePessoas

// Map para extrair datas
var dataDePessoas = pessoas.map { pessoa in
    pessoa.date
}

dataDePessoas
