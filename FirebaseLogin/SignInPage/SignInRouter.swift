//
//  SignInRouter.swift
//  FirebaseLogin
//
//  Created by Sezgin on 1.05.2022.
//

import UIKit

protocol SignInRouterProtocol {
    func routeToMain()
}

class SignInRouter: SignInRouterProtocol {
        
    weak var view: UIViewController?
    
    static func createModule() -> SignInViewController {
        let view = SignInViewController()
        let interactor = SignInInteractor()
        let presenter = SignInPresenter()
        let router = SignInRouter()
        
        view.presenter = presenter
        interactor.presenter = presenter
        router.view = view
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        
        return view
    }
    
    func routeToMain() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            let main = MainRouter.createModule()
            guard let view = self.view else { return }
            view.navigationController?.pushViewController(main, animated: true)
        }
    }
}
