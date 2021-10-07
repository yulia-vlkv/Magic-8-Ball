//
//  ViewController.swift
//  8Ball
//
//  Created by Iuliia Volkova on 04.10.2021.
//

import UIKit

class MagicBallViewController: UIViewController {
    
    private let locale = NSLocale.autoupdatingCurrent.languageCode
    
    private var mainView: UIView = {
        let view = UIView()
        view.toAutoLayout()
        view.backgroundColor = UIColor(named: "darkGray")
        return view
    }()
    
    private var ballView: UIImageView = {
        let image = UIImageView(image: UIImage(named: "magic_8_ball"))
        image.isUserInteractionEnabled = true
        image.toAutoLayout()
        return image
    }()
    
    private lazy var answerView: UIView = {
        let view = UIView()
        view.isUserInteractionEnabled = true
        view.backgroundColor = .black
        view.layer.masksToBounds = true
        view.layer.insertSublayer(gradient, at: 0)
        view.toAutoLayout()
        return view
    }()
    
    private var gradient: CAGradientLayer = {
        let gradient = CAGradientLayer()
        gradient.type = .radial
        gradient.colors = [
            UIColor(named: "darkBlue")?.cgColor ?? UIColor.blue.cgColor,
            UIColor.black.cgColor
            ]
        gradient.startPoint = CGPoint(x: 0.5, y: 0.5)
        gradient.endPoint = CGPoint(x: 1, y: 1)
        return gradient
    }()
    
    private var answerLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.layer.masksToBounds = true
        label.textColor = .white
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 3
        label.textAlignment = .center
        label.toAutoLayout()
        return label
    }()
    
    private func setTapGesture() -> UITapGestureRecognizer {
        let myRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.imageTapped))
        return myRecognizer
    }
    
    @objc func imageTapped(tap: UITapGestureRecognizer){
        if locale == "ru" {
            let answer = answersRu.randomElement()!
            answerLabel.text = answer
        } else {
            let answer = answersEn.randomElement()!
            answerLabel.text = answer
        }
    }
    
    private var inset: CGFloat { return 20 }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ballView.addGestureRecognizer(setTapGesture())
        answerView.addGestureRecognizer(setTapGesture())
        
        layoutSubviews()
    }
    
    private func layoutSubviews() {
        
        view.addSubview(mainView)
        mainView.addSubview(ballView)
        mainView.addSubview(answerView)
        answerView.addSubview(answerLabel)
        
        answerLabel.layer.cornerRadius = ballView.frame.size.width / 2
        answerView.layer.cornerRadius = ballView.frame.size.width / 2
        
        let constraints = [
            mainView.topAnchor.constraint(equalTo: view.topAnchor),
            mainView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mainView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            mainView.widthAnchor.constraint(equalTo: view.widthAnchor),
            mainView.heightAnchor.constraint(equalTo: view.heightAnchor),
            
            ballView.centerYAnchor.constraint(equalTo: mainView.centerYAnchor),
            ballView.centerXAnchor.constraint(equalTo: mainView.centerXAnchor),
            ballView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: inset),
            ballView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -inset),
            ballView.widthAnchor.constraint(equalToConstant: (mainView.frame.size.width - inset * 2)),
            ballView.heightAnchor.constraint(equalTo: ballView.widthAnchor),
            
            answerView.centerYAnchor.constraint(equalTo: ballView.centerYAnchor),
            answerView.centerXAnchor.constraint(equalTo: ballView.centerXAnchor),
            answerView.widthAnchor.constraint(equalToConstant: (ballView.frame.size.width)),
            answerView.heightAnchor.constraint(equalTo: answerLabel.widthAnchor),
            
            answerLabel.centerYAnchor.constraint(equalTo: answerView.centerYAnchor),
            answerLabel.centerXAnchor.constraint(equalTo: answerView.centerXAnchor),
            answerLabel.widthAnchor.constraint(equalTo: answerView.widthAnchor),
            answerLabel.heightAnchor.constraint(equalTo: answerView.widthAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        gradient.frame = answerView.bounds
    }
    
    override func motionBegan(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if locale == "ru" {
            let answer = answersRu.randomElement()!
            answerLabel.text = answer
        } else {
            let answer = answersEn.randomElement()!
            answerLabel.text = answer
        }
    }
}

extension UIView {
    func toAutoLayout() {
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
