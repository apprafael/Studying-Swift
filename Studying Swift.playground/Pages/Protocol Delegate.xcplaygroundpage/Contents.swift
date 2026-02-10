import Foundation

// =====================================================
// Seção 1: Protocols
// =====================================================

protocol Cadastro {
    var nome: String { get set }
    func salvar()
}

class Pessoa: Cadastro {
    var nome: String = "Rafael"
    
    func salvar() {
        print("Pessoa salva: " + nome)
    }
}

struct Pet {
    var nome: String = "Billy"
}

// Protocols podem ser aplicados a extensions
extension Pet: Cadastro {
    func salvar() {
        print("Pet salvo: " + nome)
    }
}

var pessoa: Cadastro = Pessoa()
var pet: Cadastro = Pet()

// O item é do tipo do protocol Cadastro
// isso permite que a função aceite
// elementos de tipos diferentes
// mas que conformem com o protocol Cadastro
func salvar(item: Cadastro) {
    item.salvar()
}

salvar(item: pessoa)
salvar(item: pet)


// =====================================================
// Seção 2: Padrão de projeto Protocol Delegate
// =====================================================
// Protocol Delegate é um padrão de projeto usado para
// passar informações entre diferentes objetos
// (instâncias de classes) utilizando protocols

protocol CadastroDeAluno: AnyObject {
    var nome: String? { get set }
    func alertarQueFoiSalvo()
}

class Aluno: CadastroDeAluno {
    var bancoDeDados: BancoDeDados? = BancoDeDados()
    var nome: String? {
        didSet {
            bancoDeDados?.salvar()
        }
    }
    
    init() {
        bancoDeDados?.delegatePessoa = self
    }
    
    func alertarQueFoiSalvo() {
        print("ALERTA: Cadastro Salvo")
    }
}

class BancoDeDados {
    // Precisa ser weak para evitar retain cycle
    weak var delegatePessoa: CadastroDeAluno?
    
    func salvar() {
        // Simulação do salvamento dos dados do aluno
        print("Aluno salvo: " + (delegatePessoa?.nome ?? ""))
        delegatePessoa?.alertarQueFoiSalvo()
    }
}

var aluno: Aluno = Aluno()
aluno.nome = "Rafael" // aluno Rafael salvo
aluno.nome = "Pedro" // aluno Pedro salvo
