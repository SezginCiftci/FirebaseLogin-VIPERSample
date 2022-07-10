//
//  DetailViewController.swift
//  FirebaseLogin
//
//  Created by Sezgin on 9.05.2022.
//

import UIKit
import WebKit

protocol DetailViewProtocol: AnyObject {
    func updateDetail(urlString: String)
    var isLoading: Bool? { get set }
}

class DetailViewController: UIViewController, DetailViewProtocol {
    
    weak var presenter: DetailPresenterProtocol?
    
    var webView = WKWebView()
    var loadingAnimation = UIActivityIndicatorView()
    
    var isLoading: Bool? {
        didSet {
            if isLoading! {
                loadingAnimation.startAnimating()
                loadingAnimation.isHidden = false
            } else {
                loadingAnimation.stopAnimating()
                loadingAnimation.isHidden = true
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.tintColor = .black
    }
    
    func configureUI() {
        view.backgroundColor = UIColor(red: 0/255, green: 128/255, blue: 128/255, alpha: 1)
        view.addSubview(webView)
        webView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            webView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            webView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        view.addSubview(loadingAnimation)
        loadingAnimation.translatesAutoresizingMaskIntoConstraints = false
        loadingAnimation.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loadingAnimation.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        loadingAnimation.heightAnchor.constraint(equalToConstant: 100).isActive = true
        loadingAnimation.widthAnchor.constraint(equalToConstant: 100).isActive = true
        loadingAnimation.transform = CGAffineTransform(scaleX: 2.5, y: 2.5)
        loadingAnimation.contentMode = .scaleAspectFill
        loadingAnimation.color = .black
        loadingAnimation.backgroundColor = .clear
    }
    
    func updateDetail(urlString: String) {
        DispatchQueue.main.asyncAfter(deadline: .now()) { [weak self] in
            guard let self = self else { return }
            guard let url = URL(string: urlString) else { return }
            self.webView.load(URLRequest(url: url))
            self.isLoading = false
        }
    }
}
