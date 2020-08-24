import Foundation
import Combine

struct ImdbRepo {
    static func getMovieHotListPosters() -> AnyPublisher<[MoviePoster], Never> {
        return ImdbService.getHotMovies().map { it in
            it.map(ImdbHotListItem.transform)
        }.eraseToAnyPublisher()
    }
}
