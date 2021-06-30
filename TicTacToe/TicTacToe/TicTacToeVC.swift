//
//  ViewController.swift
//  TicTacToe
//
//  Created by DCS on 27/06/21.
//  Copyright © 2021 DCS. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private var state = [2,2,2,2,
                         2,2,2,2,
                         2,2,2,2,
                         2,2,2,2]
    
    private let winningCombinations = [[0, 1, 2, 3], [4, 5 ,6 ,7], [8 ,9 ,10 ,11],[12 ,13 ,14 ,15], [0, 4, 8 ,12], [1, 5, 9, 13], [2, 6, 10, 14],[3, 7, 11, 15], [3, 6, 9, 12], [0, 5, 10, 15]]
    private var zeroFlag = false
    
    private let myCollectionView:UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 200, left: 10, bottom: 20, right: 10)
        layout.itemSize = CGSize(width: 70, height: 70)
        
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        return collectionView
    }()
    private let myImageView: UIImageView = {
        
        let myImageView = UIImageView()
        myImageView.contentMode = .scaleAspectFill
        myImageView.clipsToBounds = true
        myImageView.image = UIImage(named: "bg1.jpg")
        
        return myImageView
        
    }()
    private let myLabel:UILabel = {
        let label = UILabel()
        label.text = "Player : 1 - X "
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textAlignment = .center
        label.textColor = UIColor.black
        return label
    }()
    private let myLabel1:UILabel = {
        let label = UILabel()
        label.text = "Player : 2 - 0 "
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textAlignment = .center
        label.textColor = UIColor.black
        return label
    }()
    private let myButton:UIButton = {
        let button = UIButton()
        button.setTitle("Restart", for: .normal)
        //        button.backgroundColor = .white
        button.setTitleColor(UIColor.black, for: .normal)
        button.backgroundColor = UIColor.white.withAlphaComponent(0.4)
        button.addTarget(self, action: #selector(resetState), for: .touchUpInside)
        button.layer.cornerRadius = 6
        return button
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "My TicTacToe Game App"
        view.addSubview(myImageView)
        myCollectionView.addSubview(myLabel)
        myCollectionView.addSubview(myLabel1)
        myCollectionView.addSubview(myButton)
        view.addSubview(myCollectionView)
        self.myCollectionView.backgroundView = myImageView
        setupCollectionView()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
         myLabel.frame = CGRect(x: 20, y: 80, width: view.width - 40, height: 40)
        myLabel1.frame = CGRect(x: 20, y: 110, width: view.width - 40, height: 40)
         myButton.frame = CGRect(x: 40, y: view.height/2+200, width: view.width-80, height: 60)
        myCollectionView.frame = view.bounds
        
    }
    
    
}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    private func setupCollectionView() {
        myCollectionView.register(T4Cell.self, forCellWithReuseIdentifier: "t4cell")
        myCollectionView.dataSource = self
        myCollectionView.delegate = self
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 16
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "t4cell", for: indexPath) as! T4Cell
        cell.setupCell(with: state[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if state[indexPath.row] != 0 && state[indexPath.row] != 1 {
            state.remove(at: indexPath.row)
            
            if zeroFlag {
                state.insert(0, at: indexPath.row)
            } else {
                state.insert(1, at: indexPath.row)
            }
            
            zeroFlag = !zeroFlag
            collectionView.reloadData()
            checkWinner()
        }
    }
    
    private func checkWinner() {
        
        if !state.contains(2) {
            let alert = UIAlertController(title: "Game over!", message: "Draw. Try again", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: { [weak self] _ in
                self?.resetState()
            }))
            DispatchQueue.main.async {
                self.present(alert, animated: true, completion: nil)
            }
        }
        
        for i in winningCombinations {
            if state[ i[0] ] == state[ i[1] ] && state[ i[1] ] == state[ i[2] ]&&state[ i[2] ] == state[ i[3] ] && state[ i[0] ] != 2 {
                announceWinner(player: state[ i[0] ] == 0 ? "0" : "X")
                break
            }
        }
    }
    
    private func announceWinner(player: String) {
        let alert = UIAlertController(title: "Game over!", message: "\(player) won", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: { [weak self] _ in
            self?.resetState()
        }))
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    @objc private func resetState() {
        state = [2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2]
        zeroFlag = false
        myCollectionView.reloadData()
    }
}
