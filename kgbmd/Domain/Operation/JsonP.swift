import Foundation

enum JsonP {
    static func toJson(_ input: String) -> String? {
        guard let keepLower = input.firstIndex(of: "{"),
              let keepUpper = input.firstIndex(of: "}") else {
            return nil
        }

        return String(input[keepLower...keepUpper])
    }
}
