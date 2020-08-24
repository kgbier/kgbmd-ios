import Foundation
import Combine

enum ImdbService {
    private static let METER_MOVIE = "https://www.imdb.com/chart/moviemeter"
    private static let METER_TV = "https://www.imdb.com/chart/tvmeter"

    private static func getHotList(listUrl: String) -> AnyPublisher<[ImdbHotListItem], Never> {
        guard let url = URL(string: listUrl) else { return Just.init([]).eraseToAnyPublisher() }

        return URLSession.shared.dataTaskPublisher(for: url)
            .receive(on: DispatchQueue.main)
            .map { data, response in ImdbHotListParser(source: data).getList() }
            .replaceError(with: [])
            .eraseToAnyPublisher()
    }
    
    static func getHotMovies() -> AnyPublisher<[ImdbHotListItem], Never> {
        return getHotList(listUrl: METER_MOVIE)
    }

    static func getHotShows() -> AnyPublisher<[ImdbHotListItem], Never> {
        return getHotList(listUrl: METER_TV)
    }
}
