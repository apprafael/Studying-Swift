import Foundation

// =====================================================
// Seção 1: O que são Closures
// =====================================================
// Uma closure é um bloco de código que pode ser passado como parâmetro
// e executado depois. Aqui o init recebe a closure `apertar` e a executa.

class Botao {
    init(apertar: () -> Void, texto: String) {

        apertar()
    }
}

Botao(apertar: { print("apertou") }, texto: "Botao")

// =====================================================
// Seção 2: Closures como Parâmetros de Init
// =====================================================
// Diferentes formas de declarar closures: opcionais, com parâmetros,
// com retorno e com argumentos nomeados.

class Interruptor {
    var voltagem: Int?
    var tipo: String?
    
    init(texto: String, ligar: () -> Void) {
        ligar()
    }
    
    init(texto: String, ligar: (() -> Void)?) {
        ligar?()
    }
    
    init(voltagem: (Int) -> Void) {
        voltagem(100)
    }
    
    init(using voltagem2: (Int) -> Void) {
        voltagem2(100)
    }
    
    init(voltagem: (Int) -> String) {
        var ligou = voltagem(100)
        print("retornou")
    }
    
    init(voltagem: (Int, String) -> Void) {
        voltagem(100, "watts")
    }
    
    init(voltagem: Int, tipo: String) {
        self.voltagem = voltagem
        self.tipo = tipo
    }
    
    func ligar(voltagem: (Int, String) -> Void) {
        voltagem(self.voltagem ?? 0, tipo ?? "")
    }
}

// =====================================================
// Seção 3: Chamando Closures (Trailing Closure)
// =====================================================
// Formas de passar a closure na chamada, incluindo a sintaxe de
// trailing closure (mais limpa quando é o último parâmetro).

Interruptor(texto: "Interruptor", ligar: { print("ligou") }) // Closure

Interruptor(texto: "Interruptor") { print("ligou") } // Trailing Closure (sintaxe mais bonita)
Interruptor(voltagem: { voltagem in
    print(voltagem)
})

Interruptor.init { voltagem in
    print(voltagem)
    return "ligou"
}

Interruptor(using: { _ in
    print("recebeu voltagem mas não usou")
})

Interruptor { voltagem, tipo in
    print(tipo)
}

Interruptor(voltagem: 100, tipo: "watts").ligar { voltagem, tipo in
    print(tipo)
}


// =====================================================
// Seção 4: Closures Armazenadas em Propriedades/Variáveis
// =====================================================
// Uma closure pode ser guardada numa variável e reutilizada,
// inclusive como opcional (que pode ser nil).

var ligar: () -> Void = { print("propriedade ligar") }

Interruptor(texto: "Interruptor", ligar: ligar)

var ligarOpcional: (() -> Void)?

Interruptor(texto: "Interruptor", ligar: ligarOpcional)

// =====================================================
// Seção 5: Sintaxe Abreviada (Shorthand)
// =====================================================
// Swift permite encurtar closures: inferência de tipo, argumentos
// implícitos ($0, $1) e return implícito quando há uma única expressão.

let numeros = [1, 2, 3, 4, 5]

// Forma completa
let dobrosCompleto = numeros.map({ (numero: Int) -> Int in
    return numero * 2
})

// Tipo inferido + return implícito
let dobrosMedio = numeros.map { numero in numero * 2 }

// Argumento implícito $0 (forma mais curta)
let dobrosCurto = numeros.map { $0 * 2 }

print(dobrosCompleto, dobrosMedio, dobrosCurto)

// =====================================================
// Seção 6: Higher-Order Functions
// =====================================================
// Funções que recebem closures. São o uso mais comum de closures
// no dia a dia: transformar, filtrar e reduzir coleções.

// map: transforma cada elemento
let aoQuadrado = numeros.map { $0 * $0 }

// filter: mantém só os que satisfazem a condição
let pares = numeros.filter { $0 % 2 == 0 }

// reduce: combina tudo em um único valor (0 é o valor inicial)
let soma = numeros.reduce(0) { acumulado, atual in acumulado + atual }

// compactMap: transforma e remove os nil
let textos = ["1", "dois", "3"]
let convertidos = textos.compactMap { Int($0) } // [1, 3]

// sorted: ordena usando a closure como critério
let ordenadoDesc = numeros.sorted { $0 > $1 }

print(aoQuadrado, pares, soma, convertidos, ordenadoDesc)

// =====================================================
// Seção 7: Escaping Closures (@escaping)
// =====================================================
// Por padrão closures são "non-escaping" (executadas dentro da função).
// @escaping indica que a closure será guardada e executada DEPOIS,
// por exemplo em callbacks assíncronos. Por isso precisa de self explícito.

class Servico {
    func buscarDados(completion: @escaping (String) -> Void) {
        // Simula uma chamada assíncrona
        DispatchQueue.global().async {
            let resultado = "dados carregados"
            completion(resultado) // executado depois que a função já retornou
        }
    }
}

Servico().buscarDados { dados in
    print(dados)
}

// =====================================================
// Seção 8: Capture List e [weak self] (Retain Cycle)
// =====================================================
// Closures capturam os valores que usam. Se um objeto guarda uma closure
// que captura o próprio objeto (self) fortemente, cria-se um retain cycle
// (vazamento de memória). [weak self] quebra esse ciclo.

class ViewModel {
    var nome = "Rafael"
    var aoCarregar: (() -> Void)?

    func configurar() {
        // [weak self] evita o retain cycle; self vira opcional
        aoCarregar = { [weak self] in
            guard let self = self else { return }
            print("Olá, \(self.nome)")
        }
    }

    deinit {
        print("ViewModel liberado da memória")
    }
}

var vm: ViewModel? = ViewModel()
vm?.configurar()
vm?.aoCarregar?()
vm = nil // graças ao [weak self], o deinit é chamado

// =====================================================
// Seção 9: @autoclosure
// =====================================================
// @autoclosure embrulha automaticamente uma expressão numa closure,
// permitindo "lazy evaluation": a expressão só é avaliada se for usada.

func logSeAtivo(_ ativo: Bool, _ mensagem: @autoclosure () -> String) {
    if ativo {
        print(mensagem()) // só avalia a mensagem aqui
    }
}

// Passa a expressão direto, sem precisar de chaves { }
logSeAtivo(true, "Mensagem cara de calcular")

// =====================================================
// Seção 10: Closure que Retorna Closure
// =====================================================
// Funções podem retornar closures, capturando valores do contexto.
// Aqui `multiplicadorPor` retorna uma closure que lembra do fator.

func multiplicadorPor(_ fator: Int) -> (Int) -> Int {
    return { numero in numero * fator }
}

let triplicar = multiplicadorPor(3)
print(triplicar(10)) // 30
