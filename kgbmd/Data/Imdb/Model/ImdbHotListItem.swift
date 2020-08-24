import Foundation

struct ImdbHotListItem {
    let ttid: String
    let name: String
    let rating: String?
    let imageUrl: String
}

extension ImdbHotListItem {
    static func transform(_ item: ImdbHotListItem) -> MoviePoster {
        let validatedRating: String?
        if item.rating == "0.0" {
            validatedRating = nil
        } else {
            validatedRating = item.rating
        }

        return MoviePoster(
            ttid: item.ttid,
            title: item.name,
            rating: validatedRating,
            thumbnailUrl: item.imageUrl,
            posterUrlSmall: ImdbImageResizer.resize(imageUrl: item.imageUrl, size: ImdbImageResizer.SIZE_WIDTH_MEDIUM),
            posterUrlLarge: ImdbImageResizer.resize(imageUrl: item.imageUrl, size: ImdbImageResizer.SIZE_WIDTH_LARGE)
        )
    }
}
