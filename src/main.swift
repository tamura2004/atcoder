import Foundation

let hiragana: [Character] = {
  [UnicodeScaler("あ").value...UnicodeScalar("ん").value].joined()
    .compactMap { value in
      UnicodeScalar(value).map(Character.init)
    }
}()

struct PC {
  var name: String = "名無しさん"

  init() {

  }
}
