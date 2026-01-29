import Foundation

// Stored Properties

var greeting = "Hello, playground"

var greeting2: String = "Hello, playground"

let greeting3 = "Hello, playground"

// Computed Properties

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

// Computed Properties - Property Observers

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

// Lazy Stored Properties

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
