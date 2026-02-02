import Foundation

// =====================================================
// Seção 1: Propriedades Armazenadas (Stored Properties)
// =====================================================

let fruta: String = "Maçã"
let quantidade: Int = 10
var estaNaValidade: Bool = true
var preco: Double = 10.0

// =====================================================
// Seção 2: Propriedades Computadas (Computed Properties)
// =====================================================

var number = 10

var greetingComputedProperty: String {
    var aux = "Hello, playground"
    aux = "Hello, playground" + " Computed property" + " Número: \(number)"
    return aux
}

greetingComputedProperty

number = number + 1

// o valor é recalculado
greetingComputedProperty

// =====================================================
// Seção 3: Computed Properties com get e set
// =====================================================

struct Pessoa {
    private var _cpf: String = ""

    var cpf: String {
        get {
            _cpf
        }
        set {
            _cpf = String(newValue.filter { $0.isNumber }.prefix(11))
        }
    }
}

var p = Pessoa()
p.cpf = "j4n234j23423kj4"
print(p.cpf) // 👉 "42342341123"

// =====================================================
// Seção 4: Property Observers
// =====================================================

var text: String = "A" {
    willSet {
        print("O valor vai mudar de \(text) para \(newValue)")
    }

    didSet {
        print("O valor mudou de \(oldValue) para \(text)")
    }
}

text = "B"

// exemplo de uso
func salvarDataNascimento(_ dataNascimento: String?) {
    guard let dataNascimento else { return }
    print(dataNascimento + " data salva")
}
var dataNascimento: String? {
    didSet {
        salvarDataNascimento(dataNascimento)
    }
}

dataNascimento = "01/01/2026"


// =====================================================
// Seção 5: Propriedades Armazenadas Lazy (Lazy Stored)
// =====================================================

class Properties {
    var number = 20
    // lazy é necessário porque esta propriedade depende de `self`.
    // Propriedades não-lazy são inicializadas antes do fim do init,
    // momento em que o uso de `self` ainda não é permitido.
    //
    // Como propriedades lazy só são inicializadas na primeira vez
    // que são acessadas, isso garante que `self` já esteja totalmente
    // inicializado, tornando seguro acessar `self.number`.
    lazy var lazyNumber: Int = 10 + self.number
}

let properties = Properties()
properties.number
properties.lazyNumber
