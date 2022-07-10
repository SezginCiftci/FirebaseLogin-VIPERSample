//
//  SignInInteractor.swift
//  FirebaseLogin
//
//  Created by Sezgin on 1.05.2022.
//

import Foundation
import Firebase

protocol SignInInteractorProtocol {
    func didFetchUser(username: String, password: String)
}

class SignInInteractor: SignInInteractorProtocol {
    
    weak var presenter: SignInPresenterProtocol?
    
    func didFetchUser(username: String, password: String) {
        DispatchQueue.main.async {
            FirebaseAuth.Auth.auth().signIn(withEmail: username,
                                            password: password)
            { [weak self] result, error in
                guard let self = self else { return }
                if error != nil {
                    self.presenter?.signInNotSuccess()
                } else {
                    self.presenter?.signInSuccess()
                }
            }
        }
    }
}
