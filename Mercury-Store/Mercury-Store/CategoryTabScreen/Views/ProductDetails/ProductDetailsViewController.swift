//
//  ProductDetailsViewController.swift
//  Mercury-Store
//
//  Created by Rain Moustfa on 29/05/2022.
//

import UIKit
import RxSwift
import RxCocoa
import Toast_Swift

class ProductDetailsViewController: UIViewController, UIScrollViewDelegate{
    
    // MARK: - IBOutlets
    @IBOutlet weak var containerViewForAddToCartButton: UIView!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var productDescription: UILabel!
    @IBOutlet weak var productTitleLabel: UILabel!
    @IBOutlet weak var productPriceLabel: UILabel!
    @IBOutlet weak var imageControl: UIPageControl!
    @IBOutlet weak var addToCart: UIButton!
    @IBOutlet weak var productImagesCollectionView: UICollectionView! {
        didSet {
            productImagesCollectionView.register(UINib(nibName: ProductDetailsImageCollectionCell.reuseIdentifier(), bundle: nil), forCellWithReuseIdentifier: ProductDetailsImageCollectionCell.reuseIdentifier())
        }
    }
    @IBOutlet weak var favoriteBtn: UIButton!
    
    // MARK: - Properties
    private var viewModel: ProductsDetailViewModelType!
    private let disposeBag = DisposeBag()
    private let collectionViewFrame = ReplaySubject<CGRect>.create(bufferSize: 1)
    
    // MARK: - Set up
    init(with viewModel: ProductsDetailViewModelType) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUi()
        setUpUI()
        collectionViewFrame.onNext(self.productImagesCollectionView.frame)
    }
    private func setUpUI() {
        self.containerViewForAddToCartButton.makeCorners(corners: [.topLeft,.topRight], radius: 12)
        self.addToCart.tintColor = ColorsPalette.labelColors
        self.addToCart.configuration?.background.backgroundColor = ColorsPalette.lightColor
        closeButton.tintColor = ColorsPalette.labelColors
        productPriceLabel.textColor = ColorsPalette.lightColor
    }
    private func updateUi(){
        productTitleLabel.text = viewModel.product.title
        productPriceLabel.text = "\(viewModel.product.variants[0].price )EGP"
        productDescription.text = viewModel.product.bodyHTML
        self.configure()
    }
    
    // MARK: - Private handlers
    private func bindCloseButton() {
        closeButton.rx.tap
            .subscribe {[weak self] _ in
                self?.viewModel.popViewController()
            }.disposed(by: disposeBag)

    }
  
}

// MARK: - Extensions
extension ProductDetailsViewController {
    // MARK: - Private handlers
    private func bindCollectionView() {
        productImagesCollectionView.dataSource = nil
        productImagesCollectionView.delegate = nil
        productImagesCollectionView.rx.setDelegate(self).disposed(by: disposeBag)
        
        viewModel.bannerObservable
            .drive(productImagesCollectionView.rx.items(cellIdentifier:  ProductDetailsImageCollectionCell.reuseIdentifier(), cellType:  ProductDetailsImageCollectionCell.self)) {indexPath, item, cell in
                cell.item = item
            }
            .disposed(by: disposeBag)
        viewModel.sendImagesToCollection()
    }
    
    private func bindPageController() {
        viewModel.countForPageControll
            .bind(to: imageControl.rx.numberOfPages)
            .disposed(by: disposeBag)
    }
    
    private func bindCollectionViewToPageControll() {
        currentPage(
            offset: productImagesCollectionView.rx.contentOffset
                .asObservable(),
            frame: collectionViewFrame.asObserver()
        )
        .bind(to: imageControl.rx.currentPage)
        .disposed(by: disposeBag)
    }
    
    private func currentPage(offset: Observable<CGPoint>, frame: Observable<CGRect>) -> Observable<Int> {
        return Observable.combineLatest(offset,frame)
            .map{ Int($0.0.x) / Int($0.1.width)}
        
    }
}

// MARK: - Extensions
extension ProductDetailsViewController  {
    // MARK: - Private handlers
    private func configure() {
        self.bindCollectionView()
        self.bindPageController()
        self.bindCollectionViewToPageControll()
        self.addToFavourite()
        self.addToCartTapBinding()
        self.bindFavouriteButton()
        self.bindCloseButton()
    }
}
// MARK: - Extensions
extension ProductDetailsViewController{
    // MARK: - Private handlers
    func bindFavouriteButton(){
        favoriteBtn.favouriteState(state: viewModel.isProductFavourite )
    }
    func addToFavourite(){
        favoriteBtn.rx.tap.subscribe(onNext: { [weak self] in
            self!.view.makeToast("Added to Favorites", duration: 3.0, position: .top)
            guard let self = self else {return}
            self.favoriteBtn.favouriteState(state:  self.viewModel.toggleFavourite() )
        }).disposed(by: disposeBag)
    }
}
// MARK: - Extensions
extension ProductDetailsViewController{
    // MARK: - Private handlers
    private func addToCartTapBinding(){
        addToCart.rx.tap.subscribe { [weak self] _ in
            self!.view.makeToast("Added to Bag", duration: 3.0, position: .bottom)
            guard let self = self else { return }
            self.viewModel.modifyOrderInCartIfCartIdIsNil(self.viewModel.product.variants[0].id)
        }.disposed(by: disposeBag)

        

    }
}
// MARK: - Extensions
extension ProductDetailsViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width:productImagesCollectionView.frame.width, height: productImagesCollectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
}

