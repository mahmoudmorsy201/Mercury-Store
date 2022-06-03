//
//  ProductDetailsViewController.swift
//  Mercury-Store
//
//  Created by Rain Moustfa on 29/05/2022.
//

import UIKit
import RxSwift
import RxCocoa
class ProductDetailsViewController: UIViewController, UIScrollViewDelegate{
    
    @IBOutlet weak var productDescription: UITextView!
    @IBOutlet weak var productTitleLabel: UILabel!
    @IBOutlet weak var productPriceLabel: UILabel!
    @IBOutlet weak var imageControl: UIPageControl!
    @IBOutlet weak var addToCart: UIButton!
    @IBOutlet weak var productDetailsCollectionView: UICollectionView!
    {
        didSet {
            productDetailsCollectionView.register(UINib(nibName: ProductDetailsImageCollectionCell.reuseIdentifier(), bundle: nil), forCellWithReuseIdentifier: ProductDetailsImageCollectionCell.reuseIdentifier())
        }
    }
    var viewModel: ProductsDetailViewModelType? {
        didSet {
            self.configure()
        }
    }
    @IBOutlet weak var favoriteBtn: UIButton!

    //private var viewModel: ProductsDetailViewModelType?
     
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
       updateUi()
       collectionViewFrame.onNext(self.productDetailsCollectionView.frame)

        
    }
    init(with viewModel: ProductsDetailViewModelType) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func updateUi(){
       
        productTitleLabel.text = viewModel?.product.title
        productPriceLabel.text = (viewModel?.product.variants[0].price ?? "") + " USD"
        productDescription.text = viewModel?.product.bodyHTML
    }
    
    private let disposeBag = DisposeBag()
    
    private let collectionViewFrame = ReplaySubject<CGRect>.create(bufferSize: 1)
    
   
    
}

extension ProductDetailsViewController {
    private func bindCollectionView() {
        productDetailsCollectionView.dataSource = nil
        productDetailsCollectionView.delegate = nil
        productDetailsCollectionView.rx.setDelegate(self).disposed(by: disposeBag)
        
        viewModel?.bannerObservable
            .drive(productDetailsCollectionView.rx.items(cellIdentifier:  ProductDetailsImageCollectionCell.reuseIdentifier(), cellType:  ProductDetailsImageCollectionCell.self)) {indexPath, item, cell in
                cell.item = item
            }
            .disposed(by: disposeBag)
    }
    
    private func bindPageController() {
        viewModel?.countForPageControll
            .bind(to: imageControl.rx.numberOfPages)
            .disposed(by: disposeBag)
    }
    
    private func bindCollectionViewToPageControll() {
        currentPage(
            offset: productDetailsCollectionView.rx.contentOffset
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

extension ProductDetailsViewController  {
    private func configure() {
        self.bindCollectionView()
        self.bindPageController()
        self.bindCollectionViewToPageControll()
    }
}

extension ProductDetailsViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width:productDetailsCollectionView.frame.width, height: productDetailsCollectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
}

