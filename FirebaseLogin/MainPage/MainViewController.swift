//
//  MainViewController.swift
//  FirebaseLogin
//
//  Created by Sezgin on 27.04.2022.
//

import UIKit

protocol MainViewProtocol: AnyObject {
    func updateData(with: [Article])
    func updateData(with: String)
}

class MainViewController: UIViewController, MainViewProtocol {

    var presenter: MainPresenterProtocol?
    
    fileprivate var newsCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.backgroundColor = UIColor(red: 224/255, green: 255/255, blue: 255/255, alpha: 1)
        cv.register(MainNewsCell.self, forCellWithReuseIdentifier: "newsCell")
        return cv
    }()
    
    fileprivate var loadingAnimation = UIActivityIndicatorView()
    
    fileprivate var isLoading: Bool? {
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
    fileprivate var articles: [Article] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func configureUI() {
        view.backgroundColor = UIColor(red: 0/255, green: 128/255, blue: 128/255, alpha: 1)
        title = "Top Headlines"
        navigationController?.navigationBar.tintColor = .black
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "TR",
                                                  style: .done,
                                                  target: self,
                                                  action: #selector(changeRegionTr))
        newsCollection.delegate = self
        newsCollection.dataSource = self
        view.addSubview(newsCollection)
        NSLayoutConstraint.activate([
            newsCollection.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            newsCollection.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            newsCollection.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            newsCollection.bottomAnchor.constraint(equalTo: view.bottomAnchor)
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
        isLoading = true
    }
    
    @objc private func changeRegionTr() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "US",
                                                            style: .done,
                                                            target: self,
                                                            action: #selector(changeRegionUs))
        presenter?.notifyPresenterForTr()
    }
    
    @objc private func changeRegionUs() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "TR",
                                                            style: .done,
                                                            target: self,
                                                            action: #selector(changeRegionTr))
        presenter?.notifyPresenterForUs()
    }
    
    func updateData(with: [Article]) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.articles = with
            self.newsCollection.reloadData()
            self.isLoading = false
        }
    }
    
    func updateData(with: String) {
        let alert = UIAlertController(title: "Error!", message: with, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(ok)
        present(alert, animated: true, completion: nil)
    }
}

//MARK: - UICollectionView Delegate Methods
extension MainViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.width) - 3, height: collectionView.frame.height/3)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return articles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "newsCell", for: indexPath) as? MainNewsCell
        guard let cell = cell else { return UICollectionViewCell()}
        if let imageUrl = articles[indexPath.row].urlToImage {
            cell.setImage(imageUrl)
        }
        cell.titleLabel.text = articles[indexPath.row].title
        cell.publishedDate.text = articles[indexPath.row].publishedAt?.dateToString()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if articles[indexPath.row].url != nil {
            guard let url = articles[indexPath.row].url else {
                updateData(with: "Website could not be found!")
                return
            }
            presenter?.routeToDetail(url)
        } else {
            updateData(with: "Website could not be found!")
        }
    }
}
