import Foundation

enum ImdbImageResizer {
    private static let CLIPPER_DELIMITER = "._V1"

    static let SIZE_WIDTH_THUMBNAIL = 80
    static let SIZE_WIDTH_SMALL = 120
    static let SIZE_WIDTH_MEDIUM = 320
    static let SIZE_WIDTH_LARGE = 640

    static func resize(imageUrl: String, size: Int = SIZE_WIDTH_SMALL) -> String {

        guard let clipperDelimRange = imageUrl.range(of: CLIPPER_DELIMITER) else {
            return imageUrl
        }

        return imageUrl.replacingCharacters(in: clipperDelimRange.upperBound..., with: "_UX\(size).jpg")
    }
}
