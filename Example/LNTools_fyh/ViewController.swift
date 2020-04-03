//
//  ViewController.swift
//  LNTools_fyh
//
//  Created by diligencefu@sina.com on 03/24/2020.
//  Copyright (c) 2020 diligencefu@sina.com. All rights reserved.
//

import UIKit
import LNTools_fyh
import Kingfisher
import SnapKit

class ViewController: UIViewController {
    
    fileprivate let identifier_cell = "identifier_cell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let mainTableView = UITableView.init(frame: self.view.frame, style: .plain)
        mainTableView.register(ImageViewerCell.self, forCellReuseIdentifier: identifier_cell)
        mainTableView.tableFooterView = UIView.init()
        mainTableView.delegate = self
        mainTableView.dataSource = self
        mainTableView.estimatedRowHeight = 100
        mainTableView.tag = 1021
        mainTableView.tableFooterView = UIView()
        mainTableView.backgroundColor = UIColor.init(red: 0.99, green: 0.99, blue: 0.99, alpha: 1)
        self.automaticallyAdjustsScrollViewInsets = false
        self.view.addSubview(mainTableView)
        navigationItem.title = "图片浏览示例"        
    }
}

extension ViewController:UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier_cell, for: indexPath) as! ImageViewerCell
        cell.setImages()
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let kWidth = (kScreenW-7*2-16*2)/3
        return 8*2+kWidth*2+28
    }
    
}

class ImageViewerCell: UITableViewCell, LNImageBrowserProtocol {
    var ln_imageViews: UIView = UIView.init()
    let browser = LNImageBrowser()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configSubViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configSubViews() {

        self.contentView.addSubview(ln_imageViews)
        ln_imageViews.snp.makeConstraints { (ls) in
            ls.left.equalToSuperview().offset(16)
            ls.right.equalToSuperview().offset(-16)
            ls.bottom.equalToSuperview().offset(-8)
            ls.top.equalToSuperview().offset(8)
        }
    }
    
    let imagesUrl = ["https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=3488207672,3352446836&fm=26&gp=0.jpg",
                     "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1581675426354&di=1dc272af302d722b6e7583ea755c84b1&imgtype=0&src=http%3A%2F%2Fimage.biaobaiju.com%2Fuploads%2F20190628%2F16%2F1561709094-hpxrjwqIHU.jpg",
                     "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1581675426353&di=1362baa439a996f93d66df26ada6d132&imgtype=0&src=http%3A%2F%2Fimage.biaobaiju.com%2Fuploads%2F20190504%2F20%2F1556971709-MxekFPmLtc.jpg",
                     "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1581675426348&di=a90b3e36d0e3d663e2243b49001701fe&imgtype=0&src=http%3A%2F%2Fimage.biaobaiju.com%2Fuploads%2F20190903%2F20%2F1567513927-mVpnhHtiZo.jpg",
                     "https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=3747472594,317786805&fm=26&gp=0.jpg"]
    
    
    public func setImages() {
        _ = ln_imageViews.subviews.map {
            $0.removeFromSuperview()
        }
        
        let kSpace = CGFloat(7)
        var kWidth = CGFloat()
        
        kWidth = (kScreenW-kSpace*2-16*2)/3
        
        let kHeight = kWidth
        let lines = 3
        
        //MARK: 根据图片的数量进行排列
        for index in 0..<5{
            let row =  CGFloat(index%lines)
            
            let imageV = UIImageView.init(frame: CGRect(x:(kWidth + kSpace) * row, y:kSpace+(kSpace+kHeight)*CGFloat(index/lines), width: kWidth, height: kHeight))
            
            imageV.kf.setImage(with: URL.init(string: imagesUrl[index]), placeholder: UIImage.init(named: "placeholder_1"))
            imageV.contentMode = .scaleAspectFill
            imageV.clipsToBounds = true
            imageV.isUserInteractionEnabled = true
            imageV.layer.cornerRadius = 2
            imageV.tag = 170 + index
            ln_imageViews.addSubview(imageV)
            
            browser.addImageBrowser(obj: self)
        }
    }
}

let kScreenBounds = UIScreen.main.bounds
let kScreenW = kScreenBounds.width
