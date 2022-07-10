//
//  SplashPresenter.swift
//  FirebaseLogin
//
//  Created by Sezgin on 2.05.2022.
//

import Foundation

protocol SplashPresenterProtocol: AnyObject {
    func notifySignInTapped()
    func notifySignUpTapped()
}

class SplashPresenter: SplashPresenterProtocol {
    weak var view: SplashViewProtocol?
    var router: SplashRouterProtocol?
    var interactor: SplashInteractorProtocol?
    
    func notifySignInTapped() {
        router?.routeToSignIn(view as! SplashViewController)
    }
    
    func notifySignUpTapped() {
        router?.routeToSignUp(view as! SplashViewController)
    }
}
