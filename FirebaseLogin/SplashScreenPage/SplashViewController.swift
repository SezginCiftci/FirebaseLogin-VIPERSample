//
//  SplashViewController.swift
//  FirebaseLogin
//
//  Created by Sezgin on 24.04.2022.
//

import UIKit
import AVFoundation
import Combine

protocol SplashViewProtocol: AnyObject {
    
}

class SplashViewController: UIViewController, SplashViewProtocol {

    var presenter: SplashPresenterProtocol?
    
    private var player: AVPlayer?
    private var playerLayer: AVPlayerLayer?
    private let notificationCenter = NotificationCenter.default
    private var appEventSubscribers = [AnyCancellable]()
    
    private var backgroundView: UIView = {
        let bv = UIView()
        bv.translatesAutoresizingMaskIntoConstraints = false
        bv.backgroundColor = UIColor(white: 0.1, alpha: 0.4)
        return bv
    }()
    
    private var invisibleView: UIView = {
        let invisible = UIView()
        invisible.translatesAutoresizingMaskIntoConstraints = false
        invisible.backgroundColor = .clear
        return invisible
    }()
    
    private var signInButton: UIButton = {
        let button = MakeProperty.makeSplashButton("Sign In")
        button.addTarget(self, action: #selector(handleSignInButton), for: .touchUpInside)
        return button
    }()
    
    private var signUpButton: UIButton = {
        let button = MakeProperty.makeSplashButton("Sign Up")
        button.addTarget(self, action: #selector(handleSignUpButton), for: .touchUpInside)
        return button
    }()
    
    //MARK: - View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        observeAppEvents()
        setupPlayerIfNeeded()
        restartVideo()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeAppEventsSubscribers()
        removePlayer()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        playerLayer?.frame = view.bounds
    }
    
    //MARK: - View Configurations
    private func configureUI() {
        view.backgroundColor = .clear
        view.addSubview(backgroundView)
        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        backgroundView.addSubview(invisibleView)
        NSLayoutConstraint.activate([
            invisibleView.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor),
            invisibleView.centerYAnchor.constraint(equalTo: backgroundView.centerYAnchor),
            invisibleView.heightAnchor.constraint(equalToConstant: 30),
            invisibleView.widthAnchor.constraint(equalToConstant: 100)
        ])
        
        backgroundView.addSubview(signInButton)
        NSLayoutConstraint.activate([
            signInButton.bottomAnchor.constraint(equalTo: invisibleView.topAnchor),
            signInButton.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor),
            signInButton.heightAnchor.constraint(equalToConstant: 50),
            signInButton.widthAnchor.constraint(equalToConstant: 300)
        ])

        backgroundView.addSubview(signUpButton)
        NSLayoutConstraint.activate([
            signUpButton.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor),
            signUpButton.topAnchor.constraint(equalTo: invisibleView.bottomAnchor),
            signUpButton.heightAnchor.constraint(equalToConstant: 50),
            signUpButton.widthAnchor.constraint(equalToConstant: 300)
        ])
    }
    
    @objc private func handleSignInButton() {
        presenter?.notifySignInTapped()
    }
    
    @objc private func handleSignUpButton() {
        presenter?.notifySignUpTapped()
    }
    
    //MARK: - Video Settings
    private func buildPlayer() -> AVPlayer? {
        guard let filePath = Bundle.main.path(forResource: "news", ofType: "mp4") else { return nil }
        let url = URL(fileURLWithPath: filePath)
        let player = AVPlayer(url: url)
        player.actionAtItemEnd = .none
        player.isMuted = true
        return player
    }
    
    private func buildPlayerLayer() -> AVPlayerLayer? {
        let layer = AVPlayerLayer(player: player)
        layer.videoGravity = .resizeAspectFill
        return layer
    }
    
    private func playVideo() {
        player?.play()
    }
    
    private func restartVideo() {
        player?.seek(to: .zero)
        playVideo()
    }
    
    private func pauseVideo() {
        player?.pause()
    }
    
    private func removePlayer() {
        player?.pause()
        player = nil
        playerLayer?.removeFromSuperlayer()
        playerLayer = nil
    }
    
    private func setupPlayerIfNeeded() {
        player = buildPlayer()
        playerLayer = buildPlayerLayer()
        
        if let layer = self.playerLayer, view.layer.sublayers?.contains(layer) == false {
                view.layer.insertSublayer(layer, at: 0)
        }
    }
    
    private func observeAppEvents() {
        
        notificationCenter.publisher(for: .AVPlayerItemDidPlayToEndTime).sink { [weak self] _ in
            self?.restartVideo()
        }.store(in: &appEventSubscribers)
        
        notificationCenter.publisher(for: UIApplication.willResignActiveNotification).sink { [weak self] _ in
            self?.pauseVideo()
        }.store(in: &appEventSubscribers)
        
        notificationCenter.publisher(for: UIApplication.didBecomeActiveNotification).sink { [weak self] _ in
            self?.playVideo()
        }.store(in: &appEventSubscribers)
    }
    
    private func removeAppEventsSubscribers() {
        appEventSubscribers.forEach { subscriber in
            subscriber.cancel()
        }
    }
}

