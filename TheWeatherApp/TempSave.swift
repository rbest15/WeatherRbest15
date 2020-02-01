import Foundation

class Saver {
    static let shared = Saver()
    private let savedTemp = "Saver.savedTemp"
    var temp : String {
        set {
            UserDefaults.standard.set(newValue, forKey: "savedTemp")
        }
        get {
            return UserDefaults.standard.string(forKey: "savedTemp") ?? "0"
        }
    }
}
