print("===== STRUCT (Value Type) =====")

// Structs são VALUE TYPES
// - Atribuição gera CÓPIA (sem compartilhar memória)

struct UserStruct {
    var name: String
    
//    deinit { // por padrão structs não tem deinit
//
//    }
}

var userStruct1 = UserStruct(name: "Rafael")
var userStruct2 = userStruct1 // CÓPIA independente

userStruct2.name = "Pedro"

print("userStruct1.name =", userStruct1.name) // Rafael
print("userStruct2.name =", userStruct2.name) // Pedro

// --------------------------------------------

print("===== CLASS (Reference Type) =====")

// Classes são REFERENCE TYPES
// - Atribuição compartilha referência (apontam para o mesmo objeto)

class UserClass {
    var name: String
    
    init(name: String) {
        self.name = name
    }
}

var userClass1 = UserClass(name: "Rafael")
weak var userClass2 = userClass1 // MESMA REFERÊNCIA

userClass2?.name = "Pedro"

print("userClass1.name =", userClass1.name) // Pedro
print("userClass2.name =", userClass2?.name) // Pedro

// --------------------------------------------


print("===== AUTOMATIC REFERENCE COUNTING - ARC =====")

var strongUserClass = UserClass(name: "Rafael")
print(strongUserClass.name) // Rafael

// weak reference deve ser sempre opcional
weak var weakUserClass = UserClass(name: "Pedro")
print(weakUserClass?.name) // nil


weak var weakUserClassWithReference = strongUserClass
print(strongUserClass.name) // Rafael

// --------------------------------------------

print("===== RETAIN CYCLE =====")

class Person {
    let name: String
    var pet: Pet?          // strong (default)

    init(name: String) {
        self.name = name
    }

    deinit {
        print("Person \(name) deinit")
    }
}

class Pet {
    let name: String
    var owner: Person?     // 🔴 strong → cria ciclo

    init(name: String) {
        self.name = name
    }

    deinit {
        print("Pet \(name) deinit")
    }
}

var person: Person? = Person(name: "Ana")
var pet: Pet? = Pet(name: "Bidu")

person?.pet = pet
pet?.owner = person    // ciclo forte

person = nil
pet = nil

// --------------------------------------------

print("===== IDENTIDADE (somente class) =====")

// Podemos verificar se são o MESMO OBJETO na memória com '==='
if userClass1 === userClass2 {
    print("userClass1 e userClass2 são o MESMO objeto na memória")
}

// --------------------------------------------

print("===== MUTABILIDADE STRUCT =====")

struct CounterStruct {
    var value = 0
    mutating func increment() {
        value += 1
    }
}

// Structs precisam ser 'var' para permitir mutação
// let counterStruct = CounterStruct()
// counterStruct.increment() // ❌ ERRO: não compila, struct imutável

var counterStruct = CounterStruct()
counterStruct.increment()
print("CounterStruct value =", counterStruct.value) // 1

// --------------------------------------------

print("===== MUTABILIDADE CLASS =====")

class CounterClass {
    var value = 0
    func increment() {
        value += 1
    }
}

// Mesmo com let, podemos mutar as propriedades (a referência é constante, não o objeto)
let counterClassLet = CounterClass()
counterClassLet.increment()
print("counterClassLet value =", counterClassLet.value) // 1

var counterClassVar = CounterClass()
counterClassVar.increment()
print("counterClassVar value =", counterClassVar.value) // 1

// --------------------------------------------

print("===== PASSAGEM POR FUNÇÃO =====")

// Parâmetros em funções Swift são 'let' por padrão
// Structs → valor copiado, imutável dentro da função
// Classes → mesma referência, pode ser alterada

func updateStruct(_ user: UserStruct) -> UserStruct {
    // user.name = "Pedro" // ❌ não compila
    var copy = user
    copy.name = "Pedro"
    return copy
}

func updateClass(_ user: UserClass) {
    user.name = "Pedro"
}

let updatedStruct = updateStruct(userStruct1)
print("Struct original =", userStruct1.name)           // Rafael
print("Struct retornado =", updatedStruct.name)        // Pedro

updateClass(userClass1)
print("Class após função =", userClass1.name)          // Pedro

// --------------------------------------------

print("===== PROTOCOLOS =====")

// Structs e classes podem conformar a protocolos

protocol Named {
    var name: String { get }
}

struct StructUser: Named {
    let name: String
}

class ClassUser: Named {
    let name: String
    init(name: String) {
        self.name = name
    }
}

// --------------------------------------------

print("===== HERANÇA =====")

// Herança existe SOMENTE entre classes

// ❌ Nenhum dos casos abaixo compila:
// struct ParentStruct {}
// class ParentClass {}
//
// struct ChildStruct: ParentStruct {}
// class ChildClassFromStruct: ParentStruct {}
// struct ChildStructFromClass: ParentClass {}

class ParentClass {
    let id = 0
}

class ChildClass: ParentClass {} // ✅ Válido

// --------------------------------------------

print("===== INITIALIZADOR DEFAULT DA STRUCT =====")

// Structs recebem um memberwise initializer automaticamente
// Somente se:
// - Não houver init customizado
// - Todas as propriedades forem inicializáveis

struct Product {
    let name: String
    let price: Double
    let inStock: Bool
}

let product1 = Product(name: "MacBook", price: 12000.0, inStock: true)
let product2 = Product(name: "iPhone", price: 8000.0, inStock: false)
print(product1.name, product1.price, product1.inStock)
print(product2.name, product2.price, product2.inStock)

// Se uma propriedade tiver valor default, ela é omitida do init

struct Settings {
    let darkMode: Bool
    let notificationsEnabled: Bool = true
}

let settings1 = Settings(darkMode: true)
print(settings1.darkMode, settings1.notificationsEnabled) // true true

// let settings2 = Settings(darkMode: false, notificationsEnabled: false) // ❌ Erro

// --------------------------------------------

print("===== INITS CUSTOMIZADOS REMOVEM O DEFAULT =====")

struct UserWithCustomInit {
    let name: String
    
    init(_ name: String = "Rafael") {
        self.name = name
    }
}

// ❌ O memberwise init sumiu:
// let user = UserWithCustomInit(name: "Rafael") // Erro

let user = UserWithCustomInit() // ✅ Funciona por causa do valor padrão
print(user.name) // Rafael
