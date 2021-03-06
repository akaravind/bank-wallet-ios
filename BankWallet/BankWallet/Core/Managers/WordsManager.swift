import HSHDWalletKit
import RxSwift

class WordsManager {
    private let localStorage: ILocalStorage

    let backedUpSignal = Signal()

    init(localStorage: ILocalStorage) {
        self.localStorage = localStorage
    }

}

extension WordsManager: IWordsManager {

    var isBackedUp: Bool {
        get {
            return localStorage.isBackedUp
        }
        set {
            localStorage.isBackedUp = newValue
            backedUpSignal.notify()
        }
    }

    func generateWords() throws -> [String] {
        return try Mnemonic.generate()
    }

    func validate(words: [String]) throws {
        try Mnemonic.validate(words: words)
    }

}
