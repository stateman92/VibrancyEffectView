//
//  VibrancyEffectView.swift
//  
//
//  Created by Kristof Kalai on 2023. 03. 05..
//

import UIKit

public final class VibrancyEffectView: UIView {
    private let blurEffectView = UIVisualEffectView()
    private let vibrancyEffectView = UIVisualEffectView()
    private var viewDidSetup = false

    public var style: UIBlurEffect.Style? {
        didSet {
            refresh()
        }
    }

    public init(style: UIBlurEffect.Style? = nil, frame: CGRect = .zero) {
        self.style = style
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

extension VibrancyEffectView {
    private func setupView() {
        addSubview(blurEffectView)
        blurEffectView.translatesAutoresizingMaskIntoConstraints = false
        blurEffectView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        blurEffectView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        blurEffectView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        blurEffectView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true

        blurEffectView.contentView.addSubview(vibrancyEffectView)
        vibrancyEffectView.translatesAutoresizingMaskIntoConstraints = false
        vibrancyEffectView.topAnchor.constraint(equalTo: blurEffectView.contentView.topAnchor).isActive = true
        vibrancyEffectView.trailingAnchor.constraint(equalTo: blurEffectView.contentView.trailingAnchor).isActive = true
        vibrancyEffectView.bottomAnchor.constraint(equalTo: blurEffectView.contentView.bottomAnchor).isActive = true
        vibrancyEffectView.leadingAnchor.constraint(equalTo: blurEffectView.contentView.leadingAnchor).isActive = true

        refresh()

        viewDidSetup = true
    }
}

extension VibrancyEffectView {
    public func addVibrancySubview(block: (UIView) -> Void) {
        block(vibrancyEffectView.contentView)
    }

    public override func addSubview(_ view: UIView) {
        super.addSubview(view)
        guard viewDidSetup else { return }
        debugPrint("Warning: view may be placed on the view that is given in the addVibrancySubview(block:) method.")
    }
}

extension VibrancyEffectView {
    private func refresh() {
        let effect = style.map { UIBlurEffect(style: $0) }
        blurEffectView.effect = effect
        vibrancyEffectView.effect = effect.map { UIVibrancyEffect(blurEffect: $0) }
    }
}
