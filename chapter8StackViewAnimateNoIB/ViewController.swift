//
//  ViewController.swift
//  chapter8StackViewAnimateNoIB
//
//  Created by Herve Desrosiers on 2020-03-10.
//  Copyright © 2020 Herve Desrosiers. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Animating StackView"
        setupView()
        axisSwitch.addTarget(self, action: #selector(axisChanged), for: .valueChanged)
    }
    
    private func setupView() {
        view.addSubview(rootStackView)
        rootStackView.addBackground(color: .purple, radius: 12)
        let margin = view.layoutMarginsGuide
        view.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 20, leading: 0, bottom: 0, trailing: 0)
        NSLayoutConstraint.activate([
            rootStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            rootStackView.topAnchor.constraint(equalTo: margin.topAnchor),
//            stackBackgroundView.leadingAnchor.constraint(equalTo: rootStackView.leadingAnchor),
//            stackBackgroundView.topAnchor.constraint(equalTo: rootStackView.topAnchor),
//            stackBackgroundView.trailingAnchor.constraint(equalTo: rootStackView.trailingAnchor),
//            stackBackgroundView.bottomAnchor.constraint(equalTo: rootStackView.bottomAnchor),
        ])
    }
    
    private func configureAxis() {
        imageStackView.axis = axisSwitch.isOn ? .vertical : .horizontal
        // hide last image view if switch is off (horizontal)
        if let lastImageView = imageStackView.arrangedSubviews.last {
            lastImageView.isHidden = !axisSwitch.isOn
        }
    }
    
    @objc private func axisChanged(_ sender: UISwitch) {
        let animator = UIViewPropertyAnimator(
            duration: 1.0, dampingRatio: 0.5,
            animations: {
                self.configureAxis()
        })
        animator.startAnimation()
    }
    
    private let heartImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "Heart")
        return iv
    }()
    
    private let starImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "Star")
        return iv
    }()

    private let diamondImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "DIamond")
        return iv
    }()
    
    private let stackBackgroundView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .purple
        view.layer.cornerRadius = 12
        return view
    }()
    
    private lazy var imageStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [heartImageView, starImageView, diamondImageView])
        stackView.spacing = UIStackView.spacingUseSystem
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.contentMode = .scaleToFill
        return stackView
    }()
    
    private let axisSwitch: UISwitch = {
        let sw = UISwitch()
        sw.onTintColor = .white
        sw.thumbTintColor = .magenta
        sw.isOn = true
        return sw
    }()
    
    private lazy var rootStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [axisSwitch, imageStackView, ])
        stackView.translatesAutoresizingMaskIntoConstraints = false
//        stackView.insertSubview(stackBackgroundView, at: 0)
        stackView.spacing = 16
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.contentMode = .scaleToFill
        // 8 point padding
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 20.0, leading: 12, bottom: 12, trailing: 12)
        return stackView
    }()

}
