//
//  SplashRouter.swift
//  FirebaseLogin
//
//  Created by Sezgin on 2.05.2022.
//

import UIKit

typealias Entry = SplashViewProtocol & UIViewController

protocol SplashRouterProtocol {
    var entry: Entry? { get set }
    func routeToSignIn(_ view: SplashViewProtocol)
    func routeToSignUp(_ view: SplashViewProtocol)
}

class SplashRouter: SplashRouterProtocol {
    
    var entry: Entry?
    
    static func createModule() -> SplashRouterProtocol {
        let view = SplashViewController()
        let interactor = SplashInteractor()
        let presenter = SplashPresenter()
        let router = SplashRouter()
        
        view.presenter = presenter
        interactor.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        router.entry = view
        
        return router
    }
    
    func routeToSignIn(_ view: SplashViewProtocol) {
        let signInVC = SignInRouter.createModule()
        guard let view = view as? UIViewController else { return }
        view.navigationController?.pushViewController(signInVC, animated: true)
    }
    
    func routeToSignUp(_ view: SplashViewProtocol) {
        let signUpVC = SignUpRouter.createModule()
        guard let view = view as? UIViewController else { return }
        view.navigationController?.pushViewController(signUpVC, animated: true)
    }
}
