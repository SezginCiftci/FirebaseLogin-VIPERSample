//
//  SignUpRouter.swift
//  FirebaseLogin
//
//  Created by Sezgin on 2.05.2022.
//

import UIKit

protocol SignUpRouterProtocol {
    func routeToMain()
}

class SignUpRouter: SignUpRouterProtocol {
    
    weak var view: UIViewController?
    
    static func createModule() -> SignUpViewController {
        let view = SignUpViewController()
        let interactor = SignUpInteractor()
        let presenter = SignUpPresenter()
        let router = SignUpRouter()
        
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
