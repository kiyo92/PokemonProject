//
//  MainListViewComponent.swift
//  PokemonProject
//
//  Created by Joao Marcus Dionisio Araujo on 10/10/22.
//

import UIKit

class GradientView: UIView {

    private let topHex: String
    private let bottomHex: String

    init(topHex: String, bottomHex: String) {

        self.topHex = topHex
        self.bottomHex = bottomHex

        super.init(frame: CGRect.zero)
    }

    required init?(coder: NSCoder) {

        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {

        self.createGradient(topHex: self.topHex, bottomHex: self.bottomHex)

    }

    func createGradient(topHex: String, bottomHex: String) {

        let colorTop =  UIColor(hex: topHex).cgColor
        let colorBottom = UIColor(hex: bottomHex).cgColor

        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = self.bounds

        self.layer.insertSublayer(gradientLayer, at:0)
    }

}
