protocol Num {
    var number: Int { get set }
}

struct Number: Num {
    var number: Int = 10
}

func num() -> Num {
    Number()
}

String(describing: type(of: num))

func numWithSome() -> some Num {
    Number()
}

String(describing: type(of: numWithSome))
