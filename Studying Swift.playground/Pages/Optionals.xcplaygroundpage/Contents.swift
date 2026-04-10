import Foundation

// =====================================================
// Seção 1: O que são Opcionais (Optionals)
// =====================================================
// Um Optional representa um valor que pode existir (algum valor) ou não existir (nil).
// Sintaxe: Tipo? (por exemplo, Int?, String?)
var idade: Int? = nil
idade = 30

// Você pode verificar se é nil
idade == nil

// optional let permite que ser inicializada após a declaracao uma única vez
let nome: String?
nome = "Rafael"
//nome = "Pedro" ERRO

// =====================================================
// Seção 2: Desembrulhando (Unwrapping) com force unwrap (!)
// =====================================================
// Caso seja nil, o app vai crashar.

var texto: String? = "Swift"
// A linha abaixo é segura porque `texto` tem valor
let comprimentoForcado = texto!.count

// texto = nil
// A linha abaixo causaria crash se descomentada, porque `texto` é nil
// let crash = texto!.count

// =====================================================
// Seção 3: Optional Binding (if let / if var)
// =====================================================
// Forma segura de acessar o valor dentro de um optional.

if let idadeDesembrulhada = idade {
    print("Idade: ", idadeDesembrulhada)
} else {
    print("Idade não informada")
}

if var idadeDesembrulhada = idade {
    idadeDesembrulhada = 10
    print("Idade: ", idadeDesembrulhada)
} else {
    print("Idade não informada")
}


//Curiosidade: É possível usar (if let / if var) para
// atribuir optional, nesse caso nenhuma verificação é feita

if var idadeDesembrulhada: Int? = idade {
    print(idadeDesembrulhada)
}

// =====================================================
// Seção 4: guard let (saída antecipada)
// =====================================================
// Usado para validar e sair cedo caso o optional esteja nil.

func saudar(_ possivelNome: String?) {
    guard let nome = possivelNome else {
        print("Nome ausente")
        return
    }
    print("Olá, \(nome)!")
}

saudar("Maria")
saudar(nil)

// =====================================================
// Seção 5: Operador Nil-Coalescing (??)
// =====================================================
// Fornece um valor padrão quando o optional é nil.

let apelido: String? = nil
let exibicao = apelido ?? "Sem apelido"
print(exibicao)

// =====================================================
// Seção 6: Encadeamento Opcional (Optional Chaining)
// =====================================================
// Acessa propriedades/métodos de um optional de forma segura.

struct Endereco { var cidade: String }
struct Usuario { var endereco: Endereco? }

let u1 = Usuario(endereco: Endereco(cidade: "Porto"))
let u2 = Usuario(endereco: nil)

let cidade1 = u1.endereco?.cidade // "Porto"
let cidade2 = u2.endereco?.cidade // nil

print(cidade1)
print(cidade2)

// =====================================================
// Seção 7: Optional vs Implicitly Unwrapped Optional (IUO)
// =====================================================
// IUO (Tipo!) é como um optional que se comporta como não-optional na maior parte do tempo,
// mas ainda pode ser nil e causar crash ao acessar.

var tituloNormal: String? = "Curso"
var tituloIUO: String! = "Curso"

let a = tituloNormal ?? "Sem título"
let b = tituloIUO // tratado como String, mas pode ser nil em runtime
print(a, b)

// tituloIUO = nil
// print(tituloIUO.count) // Crash se descomentado

// =====================================================
// Seção 8: Map/CompactMap em opcionais
// =====================================================
// `map` transforma o valor se existir; `flatMap`/`compactMap` evita opcionais aninhados.

let textos = ["10", "20", "abc", "30"]

// Usando map
let usandoMap = textos.map { Int($0) }
print(usandoMap)
// Resultado: [Optional(10), Optional(20), nil, Optional(30)]

// Usando compactMap
let usandoCompactMap = textos.compactMap { Int($0) }
print(usandoCompactMap)
// Resultado: [10, 20, 30]

// =====================================================
// Seção 9: Pattern Matching com opcionais (switch)
// =====================================================
// Você pode usar switch para tratar casos .some e .none.

let talvezLetra: Character? = "A"

switch talvezLetra {
case .some(let letra):
    print("Tem valor: \(letra)")
case .none:
    print("É nil")
}

// =====================================================
// Seção 10: Boas práticas
// =====================================================
// - Prefira optional binding (if let / guard let) em vez de force unwrap.
// - Use ?? para valores padrão simples.
// - Evite IUO (Tipo!) quando possível; prefira Tipo? + binding seguro.
// - Use optional chaining para encadear acessos de forma segura.
// - Use map/flatMap para transformar opcionais sem ifs aninhados.
