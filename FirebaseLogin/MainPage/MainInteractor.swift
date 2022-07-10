//
//  MainInteractor.swift
//  FirebaseLogin
//
//  Created by Sezgin on 9.05.2022.
//

import Foundation

protocol MainInteractorProtocol {
    func fetchNewsData(url: URL)
}

class MainInteractor: MainInteractorProtocol {
    
    var presenter: MainPresenterProtocol?
    
    func fetchNewsData(url: URL) {
                        
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self else { return }
            guard let data = data, error == nil else {
                self.presenter?.displayAlert("Domain Error!")
                return
            }
            let result = try? JSONDecoder().decode(MainEntity.self, from: data)
            if let result = result {
                self.presenter?.getTopNewsDataUs(result.articles ?? [])
            } else {
                self.presenter?.displayAlert("Decoding Error!")
            }
        }.resume()
    }
}
