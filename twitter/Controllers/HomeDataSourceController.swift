//
//  DataSourceController.swift
//  twitter
//
//  Created by Paul Dong on 16/12/17.
//  Copyright © 2017 Paul Dong. All rights reserved.
//

import LBTAComponents
import TRON

class HomeDataSourceController: DatasourceController {
    
    let errorMessageLabel: UILabel = {
        let l = UILabel()
        l.text = "Apologies something went wrong. Please try again later ..."
        l.textAlignment = .center
        l.numberOfLines = 0
        l.isHidden = true
        return l
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(errorMessageLabel)
        
        //from LBTAComponent
        errorMessageLabel.fillSuperview()
        
        collectionView?.backgroundColor = UIColor(r: 232, g: 236, b: 241)
        setupNavigationBarItems()
        Service.sharedInstance.fetchHomeFeed { (homeDatasource, error) in
            if let err = error {
                self.errorMessageLabel.isHidden = false
                
                if let apiError = err as? APIError<Service.JSONError> {
                    if apiError.response?.statusCode != 200 {
                        self.errorMessageLabel.text = "Status code was not 200"
                    }else if let errMessage = apiError.error?.localizedDescription {
                        self.errorMessageLabel.text = errMessage
                    }
                }
                return
            }

            if let datasource = homeDatasource {
                self.errorMessageLabel.isHidden = true
                self.datasource = datasource
            }
        }
    }
    
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        collectionViewLayout.invalidateLayout()
    }
    
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var viewWidth: CGFloat = 0
        var viewHeight: CGFloat = 150
        var font: UIFont = UIFont.systemFont(ofSize: 15)
        
        if indexPath.section == 0 {
            guard let user = self.datasource?.item(indexPath) as? User else { return .zero }
            //estimation of the height of our cell based on user.bioText
            //12 - constent of leftAnchor,
            //50 - width of profileImage,
            //8  - constant of leftAnchor of nameLabel，
            //12 - righAnchor of bioTextView
            viewWidth = view.frame.width - 12 - 50 - 8 - 12
            font = UIFont.systemFont(ofSize: 15)
            viewHeight = calculateHeight(viewWidth: viewWidth, text: user.bioText, font: font)
            
            return CGSize(width: view.frame.width, height: viewHeight + 78)
        } else if indexPath.section == 1{
            guard let tweet = self.datasource?.item(indexPath) as? Tweet else { return .zero }
            //estimation of the height of our cell based on user.bioText
            //12 - constent of leftAnchor,
            //50 - width of profileImage,
            //8  - constant of leftAnchor of nameLabel，
            viewWidth = view.frame.width - 12 - 50 - 8
            font = UIFont.systemFont(ofSize: 15)
            viewHeight = calculateHeight(viewWidth: viewWidth, text: tweet.messageText, font: font)
            
            return CGSize(width: view.frame.width, height: viewHeight + 78)
        }
        
        return CGSize(width: view.frame.width, height: 150)
    }
    
    private func calculateHeight(viewWidth: CGFloat, text: String, font: UIFont) -> CGFloat {
        let size = CGSize(width: viewWidth, height: 1000)
        let attributes = [NSFontAttributeName: font]
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        
        let calculateFrame = NSString(string: text).boundingRect(with: size, options: options, attributes: attributes, context: nil)
        
        return calculateFrame.height
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 1 {
            return .zero
        }
        return CGSize(width: view.frame.width, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        if section == 1 {
            return .zero
        }
        return CGSize(width: view.frame.width, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if section == 0 {
            return UIEdgeInsets.zero
        }
        return UIEdgeInsets(top: 14, left: 0, bottom: 0, right: 0)
    }
}
