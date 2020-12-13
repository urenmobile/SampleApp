//
//  ProductViewController.swift
//  SampleApp
//
//  Created by Remzi YILDIRIM on 12/2/20.
//

import UIKit
import CoreData

class ProductViewController: BaseViewController<ProductViewModel> {
    
    // MARK: - Variables
    
    let layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 8
        layout.sectionInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        return layout
    }()
    
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.register(ProductCollectionViewCell.self, forCellWithReuseIdentifier: ProductCollectionViewCell.reuseIdentifier)
        return collectionView
    }()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupViewModel()
    }
    
    override func setupView() {
        navigationItem.title = Localizer.products.localized
        view.backgroundColor = .white
        
        view.addSubview(collectionView)
        
        collectionView.layout {
            $0.safeAreaLayoutGuide.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
            $0.safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
            $0.safeAreaLayoutGuide.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor)
            $0.safeAreaLayoutGuide.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        }
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    
    override func setupViewModel() {
        viewModel.state.receive(on: DispatchQueue.main).sink { [weak self] in
            guard let `self` = self else { return }
            self.handle(state: $0)
        }.cancel(by: cancelBag)
        
        viewModel.reloadableChangesSubject.receive(on: DispatchQueue.main).sink { [weak self] in
            self?.batchUpdate(with: $0)
        }.cancel(by: cancelBag)
        
        viewModel.getData()
    }
    
    private func handle(state: State) {
        switch state {
        case .loading:
            showLoadingView()
        case .populate, .empty:
            removeLoadingView()
        case .failure(let alert):
            removeLoadingView()
            show(alert: alert)
        }
    }
    
    private func batchUpdate(with reloadable: ReloadableChanges) {
        collectionView.performBatchUpdates({ [weak self] in
            self?.collectionView.insertItems(at: reloadable.insertItems)
            self?.collectionView.deleteItems(at: reloadable.deleteItems)
            self?.collectionView.reloadItems(at: reloadable.reloadItems)
            reloadable.moveItems.forEach { self?.collectionView.moveItem(at: $0.from, to: $0.to) }
        }, completion: nil)
    }
    
}

// MARK: - UICollectionViewDelegateFlowLayout
extension ProductViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let interItemSpacing: CGFloat = 2 * layout.minimumInteritemSpacing
        let sectionInset: CGFloat = layout.sectionInset.left + layout.sectionInset.right
        let width = (collectionView.frame.width - interItemSpacing - sectionInset) / 2
        let height: CGFloat = 200
        return CGSize(width: width, height: height)
    }
}

// MARK: - UICollectionViewDataSource
extension ProductViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.numberOfSections()
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItemsInSection(section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        print("indexPath: \(indexPath)")
        let viewData = viewModel.item(at: indexPath)
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCollectionViewCell.reuseIdentifier, for: indexPath) as! ProductCollectionViewCell
        cell.configure(with: viewData)
        
        return cell
    }
    
}

// MARK: - UICollectionViewDelegate
extension ProductViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        viewModel.willDisplayItem(at: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.didSelectItem(at: indexPath)
    }
}
