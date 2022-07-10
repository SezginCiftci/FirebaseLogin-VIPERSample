//
//  Constants.swift
//  FirebaseLogin
//
//  Created by Sezgin on 24.04.2022.
//

import UIKit

class MakeProperty {
    
    static func makeTextField(_ placeholder: String) -> UITextField {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.placeholder = placeholder
        tf.backgroundColor = .white
        tf.layer.cornerRadius = 20
        tf.clipsToBounds = true
        tf.textAlignment = .center
        tf.font = UIFont.systemFont(ofSize: 15)
        tf.adjustsFontSizeToFitWidth = true
        return tf
    }
    
    static func makeSplashButton(_ buttonTitle: String) -> UIButton {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor(white: 0.3, alpha: 0.4)
        button.layer.cornerRadius = 20
        button.setTitle(buttonTitle, for: .normal)
        button.setTitleColor(.secondarySystemBackground, for: .normal)
        button.setTitleColor(.systemBlue, for: .highlighted)
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.black.cgColor
        button.clipsToBounds = true
        button.sizeToFit()
        button.contentMode = .scaleAspectFit
        return button
    }
    
    static func makeLoginButton(_ buttonTitle: String) -> UIButton {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 20
        button.setTitle(buttonTitle, for: .normal)
        button.setTitleColor(.secondarySystemBackground, for: .normal)
        button.setTitleColor(.black, for: .highlighted)
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.white.cgColor
        button.clipsToBounds = true
        button.sizeToFit()
        button.contentMode = .scaleAspectFit
        return button
    }
    
    static func makeLabel() -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontSizeToFitWidth = true
        label.textColor = .secondarySystemBackground
        label.backgroundColor = .clear
        return label
    }
}
