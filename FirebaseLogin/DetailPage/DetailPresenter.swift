//
//  DetailPresenter.swift
//  FirebaseLogin
//
//  Created by Sezgin on 9.05.2022.
//

import Foundation

protocol DetailPresenterProtocol: AnyObject {
    func displayDetail(urlString: String)
}

class DetailPresenter: DetailPresenterProtocol {
    
    weak var view: DetailViewProtocol?
    var interactor: DetailInteractorProtocol? {
        didSet {
            self.displayDetail(urlString: urlString)
        }
    }
    var router: DetailRouterProtocol?
    
    var urlString: String
    init(urlString: String) {
        self.urlString = urlString
    }
    
    func displayDetail(urlString: String) {
        self.urlString = urlString
        view?.updateDetail(urlString: urlString)
        view?.isLoading = true
    }
}
