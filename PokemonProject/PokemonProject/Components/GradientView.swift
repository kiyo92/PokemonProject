//
//  MainListViewComponent.swift
//  PokemonProject
//
//  Created by Joao Marcus Dionisio Araujo on 10/10/22.
//

import UIKit

class GradientView: UIView {

    private let topColor: UIColor
    private let bottomColor: UIColor
    private let radius: Int

    init(topColor: UIColor, bottomColor: UIColor, radius: Int = 0) {

        self.topColor = topColor
        self.bottomColor = bottomColor
        self.radius = radius
        super.init(frame: CGRect.zero)
    }

    required init?(coder: NSCoder) {

        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {

        self.createGradient(topColor: self.topColor, bottomColor: self.bottomColor, radius: self.radius)
        roundeViewCorners()

    }

    func roundeViewCorners() {

        self.layer.cornerRadius = 10
    }

    private func createGradient(topColor: UIColor, bottomColor: UIColor, radius: Int) {

        let colorTop =  topColor.cgColor
        let colorBottom = bottomColor.cgColor

        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = self.bounds
        gradientLayer.cornerRadius = CGFloat(radius)
        self.layer.insertSublayer(gradientLayer, at:0)
    }

}
