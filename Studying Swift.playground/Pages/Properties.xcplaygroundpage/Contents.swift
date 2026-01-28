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

func salvarDataNascimento(_ dataNascimento: String) {
    print(dataNascimento + " data salva")
}

// Computed Properties com Property Observers precisam ser inicializadas
var dataNascimento: String = "" {
    didSet {
        salvarDataNascimento(dataNascimento)
    }
}

dataNascimento = "01/01/2026"

// Lazy Stored Properties

class Properties {
    var number = 20
    
    lazy var greetingLazyStoredProperty = {
        var aux = "Hello, playground"
        aux = "Hello, playground" + " Lazy property" + " Number:\(number)"
        return aux
    }()
}

Properties().greetingLazyStoredProperty

Properties().number = 30

// o valor não é recalculado, ele é somente calculado quando é incicializado
Properties().greetingLazyStoredProperty
