//
//  start.swift
//  TicTacToe
//
//  Created by DCS on 30/06/21.
//  Copyright © 2021 DCS. All rights reserved.
//

import UIKit

class start: UIViewController {
   
    private let myButton:UIButton = {
        let button = UIButton()
        button.setTitle("Let's Play", for: .normal)
        //        button.backgroundColor = .white
        button.setTitleColor(UIColor.black, for: .normal)
        button.backgroundColor = UIColor.white.withAlphaComponent(0.4)
        button.addTarget(self, action: #selector(MoveToPart2), for: .touchUpInside)
        button.layer.cornerRadius = 6
        return button
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "My TicTacToe Game App"
        view.addSubview(myButton)
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "bg0.jpg")!)
    }
    @objc func MoveToPart2(){
        let vc = ViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        myButton.frame = CGRect(x: 40, y: view.height/2+200, width: view.width-80, height: 60)
    }
}
