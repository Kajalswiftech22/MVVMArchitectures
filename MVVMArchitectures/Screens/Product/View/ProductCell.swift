//
//  ProductCell.swift
//  MVVMArchitectures
//
//  Created by intern on 9/24/23.
//

import UIKit

class ProductCell: UITableViewCell {
    
    @IBOutlet weak var productBgView: UIView!
    @IBOutlet weak var productTitleLabel: UILabel!
    @IBOutlet weak var productCategoryLabel: UILabel!
    @IBOutlet weak var rateBtn: UIButton!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var productImageView: UIImageView!
    
    var product: Product?{
        didSet{
            productDetailConfigure()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        productBgView.layer.cornerRadius = 16
        productBgView.clipsToBounds = false
        productBgView.backgroundColor = .systemGray6
        productImageView.layer.cornerRadius = 10
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func productDetailConfigure() {
        guard let product else {
            return
        }
        productTitleLabel.text = product.title
        productCategoryLabel.text = product.category
        descriptionLabel.text = product.description
        priceLabel.text = "$\(product.price)"
        rateBtn.setTitle("\(product.rating.rate)", for: .normal)
        productImageView.setImage(with: product.image)
    }
}
