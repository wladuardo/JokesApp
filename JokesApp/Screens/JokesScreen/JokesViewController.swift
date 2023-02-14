//
//  JokesViewController.swift
//  JokesApp
//
//  Created by Владислав Ковальский on 11.01.2023.
//

import UIKit
import SnapKit

class JokesViewController: UIViewController {
    
    private lazy var jokesCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        layout.estimatedItemSize = CGSize(width: view.frame.width - 20, height: view.frame.height / 6)
        layout.minimumLineSpacing = 20
        collectionView.collectionViewLayout = layout
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.alwaysBounceVertical = true
        collectionView.register(JokeCollectionViewCell.self,
                                forCellWithReuseIdentifier: JokeCollectionViewCell.identifier)
        return collectionView
    }()
    private let topView = UIView()
    private let userImageView = UIImageView()
    private let welcomeLabel = UILabel()
    private let addJokeButton = UIButton(type: .system)
    private let addUserPhotoButton = UIButton(type: .system)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        view.backgroundColor = .white
        setupTopView()
        addJokesCollectionView()
        
        
    }
}

private extension JokesViewController {
    func setupTopView() {
        topView.applyCustomViewStyle(color: .darkGray)
        
        view.addSubview(topView)
        
        topView.snp.makeConstraints({ view in
            view.top.equalTo(self.view.safeAreaLayoutGuide)
            view.leading.equalToSuperview().offset(10)
            view.trailing.equalToSuperview().offset(-10)
            view.height.equalTo(100)
        })
        
        setupUserImageView()
        setupWelcomeLabel()
        setupAddJokeButton()
        setupAddUserPhotoButton()
    }
    
    func setupUserImageView() {
        userImageView.clipsToBounds = true
        userImageView.layer.cornerRadius = 40
        
        if userImageView.image == nil {
            userImageView.image = UIImage(named: "addAvatar")
        }
        
        topView.addSubview(userImageView)
        
        userImageView.snp.makeConstraints({ imageView in
            imageView.top.equalToSuperview().offset(10)
            imageView.leading.equalToSuperview().offset(10)
            imageView.bottom.equalToSuperview().offset(-10)
            imageView.width.equalTo(80)
        })
    }
    
    func setupWelcomeLabel() {
        welcomeLabel.text = "Welcome, Guest"
        welcomeLabel.font = .systemFont(ofSize: 16, weight: .bold)
        
        topView.addSubview(welcomeLabel)
        
        welcomeLabel.snp.makeConstraints({ label in
            label.top.equalTo(userImageView.snp_topMargin)
            label.leading.equalTo(userImageView.snp_trailingMargin).offset(20)
        })
    }
    
    func setupAddJokeButton() {
        let buttonImage = UIImage(systemName: "square.and.pencil")?.withRenderingMode(.alwaysOriginal).withTintColor(.black)
        addJokeButton.setImage(buttonImage, for: .normal)
        addJokeButton.addTarget(self, action: #selector(addJokeButtonAction), for: .touchUpInside)
        
        topView.addSubview(addJokeButton)
        
        addJokeButton.snp.makeConstraints({ button in
            button.top.equalToSuperview().offset(20)
            button.trailing.equalToSuperview().offset(-20)
            button.bottom.equalToSuperview().offset(-20)
        })
    }
    
    func setupAddUserPhotoButton() {
        addUserPhotoButton.clipsToBounds = true
        addUserPhotoButton.layer.cornerRadius = 20
        addUserPhotoButton.addTarget(self, action: #selector(addUserPhotoButtonAction), for:.touchUpInside)
        
        topView.addSubview(addUserPhotoButton)
        
        addUserPhotoButton.snp.makeConstraints({ button in
            button.edges.equalTo(userImageView)
        })
    }
    
    func addJokesCollectionView() {
        view.addSubview(jokesCollection)
        
        jokesCollection.snp.makeConstraints({ collection in
            collection.top.equalTo(topView.snp_bottomMargin).offset(40)
            collection.trailing.leading.equalToSuperview()
            collection.bottom.equalToSuperview()
        })
        
    }
    
    func animateCollectionViewCell(cell: UICollectionViewCell) {
        cell.layer.transform = CATransform3DMakeScale(0.1,0.1,1)
        UIView.animate(withDuration: 0.2, animations: {
            cell.layer.transform = CATransform3DMakeScale(1,1,1)
        },completion: { finished in
            UIView.animate(withDuration: 0.1, animations: {
                cell.layer.transform = CATransform3DMakeScale(1,1,1)
            })
        })
    }
}

private extension JokesViewController {
    @objc
    func addJokeButtonAction() {
        print("hi")
    }
    
    @objc
    func addUserPhotoButtonAction() {
        let provider = CameraProvider(delegate: self)
        do {
            let picker = try provider.getImagePicker(source: .photoLibrary)
            present(picker, animated: true)
        } catch {
            NSLog("Error: \(error.localizedDescription)")
        }
    }
}

extension JokesViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = jokesCollection.dequeueReusableCell(withReuseIdentifier: JokeCollectionViewCell.identifier, for: indexPath)
        animateCollectionViewCell(cell: cell)
        return cell
    }
    
    
    
}

extension JokesViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = (
            info[UIImagePickerController.InfoKey.editedImage] as? UIImage ??
            info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        )
        DispatchQueue.main.async {
            self.userImageView.image = image
        }
        picker.dismiss(animated: true, completion: nil)
    }
}
