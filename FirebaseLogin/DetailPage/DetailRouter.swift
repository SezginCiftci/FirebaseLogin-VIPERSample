//
//  DetailRouter.swift
//  FirebaseLogin
//
//  Created by Sezgin on 9.05.2022.
//

import Foundation
import UIKit

protocol DetailRouterProtocol {
}

class DetailRouter: DetailRouterProtocol {
        
    class func createModule(urlString: String) -> UIViewController {
        let view = DetailViewController()
        let presenter = DetailPresenter(urlString: urlString)
        let interactor = DetailInteractor()
        let router = DetailRouter()
        
        view.presenter = presenter
        interactor.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        
        return view
    }
}
