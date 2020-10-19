//
//  GamePlayersView.swift
//  WoopPow
//
//  Created by Samuel Folledo on 10/17/20.
//  Copyright © 2020 SamuelFolledo. All rights reserved.
//

import SnapKit

class GamePlayersView: UIView {

    //MARK: Properties
    var player1: Player
    var player2: Player
    static let viewHeight: Int = 80
    
    //MARK: View Properties
    lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.clipsToBounds = false
        return view
    }()
    let stackView = UIStackView(axis: .horizontal, spacing: 0, distribution: .fill, alignment: .center)
    lazy var timeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.image = Constants.Images.timeLabelImage
        return imageView
    }()
    lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.font = FontManager.setFont(size: 40, fontType: .black)
        label.numberOfLines = 1
        return label
    }()
    //MARK: Player 1 View Properties
    lazy var player1View: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.systemBackground.withAlphaComponent(0)
        view.clipsToBounds = true
        view.layer.cornerRadius = 15
        return view
    }()
    lazy var player1NameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .left
        label.font = FontManager.setFont(size: 22, fontType: .bold)
        label.text = "\(player1.username ?? "")"
        label.numberOfLines = 1
        return label
    }()
    lazy var player1HpLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .center
        label.font = FontManager.setFont(size: 18, fontType: .bold)
        label.numberOfLines = 1
        return label
    }()
    lazy var player1HpBar: UIProgressView = {
        let bar = UIProgressView(progressViewStyle: .bar)
        bar.center = self.center
        bar.setProgress(1, animated: true)
        bar.trackTintColor = .lightGray
        bar.tintColor = .blue
        bar.transform = CGAffineTransform(scaleX: -1, y: 1)
        bar.transform = bar.transform.scaledBy(x: 1, y: 10)
        return bar
    }()
    
    //MARK: Player 2 View Properties
    lazy var player2View: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.systemBackground.withAlphaComponent(0)
        view.clipsToBounds = true
        view.layer.cornerRadius = 15
        return view
    }()
    lazy var player2NameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .right
        label.font = FontManager.setFont(size: 22, fontType: .bold)
        label.text = "\(player2.username ?? "")"
        label.numberOfLines = 1
        return label
    }()
    lazy var player2HpLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .center
        label.font = FontManager.setFont(size: 18, fontType: .bold)
        label.numberOfLines = 1
        return label
    }()
    lazy var player2HpBar: UIProgressView = {
        let bar = UIProgressView(progressViewStyle: .bar)
        bar.center = self.center
        bar.setProgress(1, animated: true)
        bar.trackTintColor = .lightGray
        bar.tintColor = .blue
        bar.transform = CGAffineTransform(scaleX: -1, y: 1)
        bar.transform = bar.transform.scaledBy(x: 1, y: 10)
        return bar
    }()
    
    //MARK: Initializers
    init(player1: Player, player2: Player) {
        self.player1 = player1
        self.player2 = player2
        super.init(frame: .zero)
        setupViews()
        populateViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Private Methods
    
    fileprivate func setupViews() {
        addSubview(containerView)
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        containerView.addSubview(stackView)
        stackView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(5)
            $0.left.equalToSuperview().offset(10)
            $0.right.equalToSuperview().offset(-10)
            $0.bottom.equalToSuperview().offset(-5)
        }
        [player1View, timeImageView, player2View].forEach {
            stackView.addArrangedSubview($0)
        }
        //player 1
        let p1StackView = UIStackView(axis: .vertical, spacing: 5, distribution: .fill, alignment: .leading)
        [player1HpLabel, player1NameLabel].forEach {
            p1StackView.addArrangedSubview($0)
            $0.snp.makeConstraints {
                $0.width.equalToSuperview()
            }
        }
        player1View.snp.makeConstraints {
            $0.height.equalToSuperview().multipliedBy(0.7)
            $0.width.equalToSuperview().multipliedBy(0.5).offset((GamePlayersView.viewHeight - 10) / -2)
        }
        player1View.addSubview(player1HpBar)
        player1HpBar.snp.makeConstraints {
            $0.height.equalToSuperview().multipliedBy(0.4)
            $0.top.equalToSuperview().offset(2)
            $0.left.right.equalToSuperview()
        }
        player1View.addSubview(p1StackView)
        p1StackView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(2)
            $0.left.equalToSuperview().offset(5)
            $0.right.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-5)
        }
        //time
        timeImageView.snp.makeConstraints {
            $0.height.width.equalTo(stackView.snp.height)
        }
        timeImageView.addSubview(timeLabel)
        timeLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().multipliedBy(1.1) //move label down a little bit
            $0.width.height.equalToSuperview().multipliedBy(0.8)
        }
        //player 2
        let p2StackView = UIStackView(axis: .vertical, spacing: 5, distribution: .fill, alignment: .trailing)
        [player2HpLabel, player2NameLabel].forEach {
            p2StackView.addArrangedSubview($0)
            $0.snp.makeConstraints {
                $0.width.equalToSuperview()
            }
        }
        player2View.addSubview(p2StackView)
        p2StackView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(2)
            $0.left.equalToSuperview()
            $0.bottom.right.equalToSuperview().offset(-5)
        }
        player2View.snp.makeConstraints {
            $0.height.equalToSuperview().multipliedBy(0.7)
            $0.width.equalToSuperview().multipliedBy(0.5).offset((GamePlayersView.viewHeight - 10) / -2) //because stackView's height is 70 and timeImageView's width and height is 70
        }
    }
    
    private func populateViews() {
        player1NameLabel.text = player1.username
//        player1HpLabel.text = "\(30)/\(30)"
        player2NameLabel.text = player2.username
//        player2HpLabel.text = "\(30)/\(30)"
    }
}
