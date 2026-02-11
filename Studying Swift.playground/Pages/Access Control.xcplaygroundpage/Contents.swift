// =====================================================
// Seção 1: Access Control (Controle de acesso) Internal
// =====================================================
// Declarações com "internal" são acessíveis em todo o módulo (target).
// É o nível padrão quando nada é especificado explicitamente.
// Não são acessíveis fora do módulo.

class Pessoa {
    // Quando o controle de acesso é omitido, "internal" é atribuído automaticamente.
    var nome = "João"
    // Ele pode ser explicitamente informado
    internal var identificador = "João"
}

Pessoa().nome
Pessoa().identificador

// =====================================================
// Seção 2: Access Control (Controle de acesso) Private
// =====================================================
// Declarações com "private" são acessíveis apenas dentro do mesmo escopo léxico
// (por exemplo, dentro da mesma classe/struct/enum/extensão onde foram declaradas).

class Usuario {
    var nome = "Maria"
    private var senha = "123456"
}

Usuario().nome
// Usuario().senha // ❌ Não é acessível fora de Usuario por ser "private".


// =====================================================
// Seção 3: Access Control (Controle de acesso) Fileprivate
// =====================================================
// Declarações com "fileprivate" são acessíveis apenas dentro do mesmo arquivo-fonte.
// Útil para expor algo para outras declarações no arquivo sem torná-lo visível ao módulo inteiro.

class Veiculo {
    var nome = "Carro"
    fileprivate var numero = "ABC123"
}

Veiculo().nome
Veiculo().numero // ✅ É acessível aqui por estarmos no mesmo arquivo ("fileprivate").


// =====================================================
// Seção 4: Access Control (Controle de acesso) Public
// =====================================================
// Declarações "public" são acessíveis fora do módulo, mas
// tipos "public" não podem ser subclassificados nem estendidos fora do módulo
// a menos que sejam marcados como "open". Dentro do módulo, funcionam como "internal".

// ✅ Dentro do mesmo módulo, herança a partir de um tipo "public" é permitida.
// ❌ Fora do módulo, apenas tipos "open" permitem herança/extensão.

public class MotoristaDeCaminhao {
    public var nome: String
    
    public init(nome: String) {
        self.nome = nome
    }
}

// =====================================================
// Seção 5: Access Control (Controle de acesso) Open
// =====================================================
// Declarações "open" são como "public" quanto à visibilidade,
// mas também permitem herança e extensão fora do módulo.
// Esse modificador é o menos restritivo de todos

// Obs.: ❌ "open" não pode ser combinado com "final", pois "final" impede herança.
open class Aluno {
    // "open" no tipo permite subclassificação fora do módulo;
    // as propriedades aqui não precisam ser "open".
    var matricula: String
    
    public init(matricula: String) {
        self.matricula = matricula
    }
}

// =====================================================
// Seção 6: Final
// =====================================================
// "final" não é um controle de acesso; ele impede herança/subclassificação.
// Pode ser usado em conjunto com a maioria dos modificadores de acesso


fileprivate final class Estudante {
    var nome: String = "Rafael"
    let identificador: Int = 1312312
}

// ❌ Não é permitido herdar de um tipo "final".
//class Estudante: Aluno {
//}

// ✅ Permite extensão: "final" não impede extensões, apenas herança.
extension Aluno {
    func estudar() {
        print("Estudando")
    }
}
