//
//  MainRouter.swift
//  FirebaseLogin
//
//  Created by Sezgin on 9.05.2022.
//

import UIKit
    
protocol MainRouterProtocol {
    func routeToDetail(_ urlString: String, _ view: MainViewProtocol)
}

class MainRouter: MainRouterProtocol {
    
    weak var view: UIViewController?
    
    static func createModule() -> MainViewController {
        let view = MainViewController()
        let interactor = MainInteractor()
        let presenter = MainPresenter()
        let router = MainRouter()
        
        view.presenter = presenter
        interactor.presenter = presenter
        router.view = view
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        
        return view
    }

    func routeToDetail(_ urlString: String, _ view: MainViewProtocol) {
        DispatchQueue.main.async {
            let detailVC = DetailRouter.createModule(urlString: urlString)
            guard let sourceView = view as? UIViewController else { return }
            sourceView.navigationController?.pushViewController(detailVC, animated: true)
        }
    }
}
