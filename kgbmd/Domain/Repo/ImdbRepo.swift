import Foundation
import Combine

struct ImdbRepo {
    static func getMovieHotListPosters() -> AnyPublisher<[MoviePoster], Never> {
        return ImdbService.getHotMovies().map { it in
            it.map(ImdbHotListItem.transform)
        }.eraseToAnyPublisher()
    }

    static func getSearchResults(for query: String) -> AnyPublisher<[String], Never> {
        return ImdbService.search(for: query)
            .eraseToAnyPublisher()
    }
}
