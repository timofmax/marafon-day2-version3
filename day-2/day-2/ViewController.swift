//
//  ViewController.swift
//  day-2
//
//  Created by Timofey Privalov on 04.03.2023.
//


import UIKit

final class ViewController: UIViewController {
    
    //MARK: - Properties
    
//    let firstButton = BounceButton(configuration: config)
//    let secondButton = BounceButton(configuration: config)
//    let thirdButton = BounceButton(configuration: config)
//
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewButtons()
    }
    
    //MARK: - Private Methods
    private func setupViewButtons() {
        var config = UIButton.Configuration.filled()
        let firstButton = BounceButton(configuration: config)
        let secondButton = BounceButton(configuration: config)
        let thirdButton = BounceButton(configuration: config)
        let buttonArr = [firstButton, secondButton, thirdButton]
        let buttonNameArr = ["First Button", "Second Medium Button", "Third"]
        var verticalSpace = 60.0
        
        for i in buttonArr.enumerated() {
            let button = buttonArr[i.offset]
            view.addSubview(buttonArr[i.offset])
            button.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                button.topAnchor.constraint(equalTo: view.topAnchor, constant: verticalSpace),
                button.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            ])
            verticalSpace += 60.0
            button.layer.masksToBounds = false
            button.layer.cornerRadius = 15
            button.backgroundColor = .systemBlue
            button.titleLabel?.font = UIFont.systemFont(ofSize: 12)
            button.setTitle("\(buttonNameArr[i.offset])", for: .normal)
            
            if i.offset == 2 {
                button.configurationUpdateHandler = { button in
                    switch button.state {
                    case .normal:
                        buttonArr.forEach { button in
                            button.configuration?.baseBackgroundColor = .systemBlue
                        }
                    case .highlighted:
                        buttonArr.forEach { button in
                            button.configuration?.baseBackgroundColor = .lightGray
                            button.backgroundColor = .lightGray
                        }
                    default:
                        break
                    }
                }
            }
            config.imagePadding = 8
            config.imagePlacement = .trailing
            config.contentInsets = NSDirectionalEdgeInsets(top: 14.0, leading: 10.0, bottom: 14.0, trailing: 10.0)
            button.configuration = config
            button.setImage(UIImage(systemName: "arrow.forward.circle.fill"), for: .normal)
        }
        firstButton.addTarget(self, action: #selector(didTapAndDoNothing), for: .touchUpInside)
        secondButton.addTarget(self, action: #selector(didTapAndDoNothing), for: .touchUpInside)
        thirdButton.addTarget(self, action: #selector(presentVc), for: .touchUpInside)
    }
    
    //MARK: - Button Manipulation Methods
    @objc private func didTapAndDoNothing() {
        print("HELLO! ")
    }
    
    @objc private func presentVc() {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "second") as? SecondViewController else { return }
        vc.modalPresentationStyle = .popover
        present(vc, animated: true)
    }
}
