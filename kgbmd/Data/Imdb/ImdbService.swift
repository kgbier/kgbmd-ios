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

    static func search(for query: String) -> AnyPublisher<[String], Never> {
        let query = query
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .lowercased()

        guard var url = URL(string: "https://v2.sg.media-imdb.com/suggestion") else { return Just.init([]).eraseToAnyPublisher() }
        url.appendPathComponent(query.first.map(String.init)!, isDirectory: true)
        url.appendPathComponent(query, isDirectory: false)
        url.appendPathExtension(".json")

        return URLSession.shared.dataTaskPublisher(for: url)
            .receive(on: DispatchQueue.main)
            .map { $0.data }
            .decode(type: ImdbSuggestionResponse.self, decoder: JSONDecoder())
            .map { $0.d?.map { $0.l } ?? [] }
            .replaceError(with: [])
            .eraseToAnyPublisher()
    }
}
