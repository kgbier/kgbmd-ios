import Foundation

struct MoviePoster {
    let ttid: String
    let title: String
    let rating: String?
    let thumbnailUrl: String
    let posterUrlSmall: String
    let posterUrlLarge: String
}

func transformHotListItem(_ item: HotListItem) -> MoviePoster {
    return MoviePoster(
        ttid: item.ttid,
        title: item.name,
        rating: item.rating,
        thumbnailUrl: item.imageUrl,
        posterUrlSmall: ImdbImageResizer.resize(imageUrl: item.imageUrl, size: ImdbImageResizer.SIZE_WIDTH_MEDIUM),
        posterUrlLarge: ImdbImageResizer.resize(imageUrl: item.imageUrl, size: ImdbImageResizer.SIZE_WIDTH_LARGE)
    )
}
