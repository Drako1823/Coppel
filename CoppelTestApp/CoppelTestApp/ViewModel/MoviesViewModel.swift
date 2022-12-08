//
//  MoviesViewModel.swift
//  coppelTestApp
//
//  Created by El Reymon . on 06/12/22.
//

import Foundation

final class MoviesViewModel : Decodable{
    typealias CompletionBlock = (NSError) -> Void
    private var serviceManager : Webservice?
    
    init(_ serviceManager : Webservice = Webservice()){
        self.serviceManager = serviceManager
    }
    
    private var allMovies: allMovies?
    
    required init(from decoder: Decoder) throws {}

    func loadAllMovies(option: typeMovies,bShowLoader: Bool = false, withCompletionHandler handler: @escaping CompletionBlock){
        
        var resource = Resource<allMovies>("\(option.rawValue)", .pageNormal, .moreLanguage, .baseCore )
        
        resource.httpMethod = .get
        resource.showProgress = bShowLoader
        serviceManager?.load(resource: resource){ [weak self] result in
            guard let self = self else { return }
            switch result{
            case .success(let allMovies, let error):
                self.allMovies = allMovies
                handler(error ?? NSError(domain: "Movies", code: error?.code ?? 500, userInfo: error?.userInfo))
            case .failure(let error):
                handler(error ?? NSError(domain: "Movies", code: error?.code ?? 500, userInfo: error?.userInfo))
            }
        }
    }

}

extension MoviesViewModel {
    func getNumberRowsMovies() -> Int {
        return allMovies?.arrMovies?.count ?? 0
    }
    
    func getSelectedMovie(movieSelected: Int) -> movieSection? {
        return allMovies?.arrMovies?[movieSelected]
    }
    
}
