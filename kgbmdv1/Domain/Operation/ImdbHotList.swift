import Foundation

class ImdbHotList {

    // <span name="ir" data-value="8.8"></span>
    private static let RATING_LOWER = "data-value=\""
    private static let RATING_UPPER = "\""

    // <a href="/title/tt123456/?pf_r...
    private static let TTID_LOWER = "title/"
    private static let TTID_UPPER = "/"

    // <img src="https://m.media-amazon.com/images/M/M[...]L_.jpg" [...] alt="Joker">
    private static let POSTER_IMAGE_LOWER = "<img src=\""
    private static let POSTER_IMAGE_UPPER = "\""

    // ...er" >Terminator: Dark Fate</a>
    private static let NAME_LOWER = ">"
    private static let NAME_UPPER = "<"

    private let source: Data

    init(source: Data) {
        self.source = source
    }

    func getList() -> [HotListItem] {
        var list: [HotListItem] = []

        while(readPointer < source.endIndex) {
            getNextItem().map { list.append($0) }
        }

        return list
    }

    private func getNextItem() -> HotListItem? {
        guard findPosterSection() else { return nil }
        guard findPosterSectionRating() else { return nil }
        let rating = extractFromBounds(lower: Self.RATING_LOWER, upper: Self.RATING_UPPER)

        guard findImage() else { return nil }
        let imageUrl = extractFromBounds(lower: Self.POSTER_IMAGE_LOWER, upper: Self.POSTER_IMAGE_UPPER)

        guard findTitleSection() else { return nil }
        guard findAnchor() else { return nil }
        let ttid = extractFromBounds(lower: Self.TTID_LOWER, upper: Self.TTID_UPPER)
        let name = extractFromBounds(lower: Self.NAME_LOWER, upper: Self.NAME_UPPER)

        return HotListItem(ttid: ttid, name: name, rating: rating, imageUrl: imageUrl)
    }

    private var readPointer: Data.Index = 0
    private func seek(token: String) -> Bool {
        if let found = source.range(of: token.data(using: .utf8)!, in: readPointer..<source.endIndex) {
            readPointer = found.lowerBound
            return true
        } else {
            readPointer = source.endIndex
            return false
        }
    }

    private func findAnchor() -> Bool { seek(token: "<a ") }
    private func findAnchorEnd() -> Bool { seek(token: "</a") }
    private func findImage() -> Bool { seek(token: "<img ") }

    private func findPosterSection() -> Bool {
        seek(token: "<td class=\"posterColumn\"")
    }
    private func findPosterSectionRating() -> Bool {
        seek(token: "<span name=\"ir\"")
    }
    private func findTitleSection() -> Bool {
        seek(token: "<td class=\"titleColumn\">")
    }

    private func extractFromBounds(lower: String, upper: String) -> String {
        let lowerRange = source.range(of: lower.data(using: .utf8)!, in: readPointer..<source.endIndex)
        let upperRange = source.range(of: upper.data(using: .utf8)!, in: lowerRange!.upperBound..<source.endIndex)

        return String(bytes: source[lowerRange!.upperBound..<upperRange!.lowerBound], encoding: .utf8) ?? ""
    }
}
