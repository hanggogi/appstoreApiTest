//
//  DetailViewController.swift
//  appstoreApiTest
//
//  Created by samga on 2020/04/17.
//  Copyright © 2020 samga. All rights reserved.
//

import UIKit
import ObjectMapper

class DetailViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    @IBOutlet weak var btnWeb: UIButton!
    @IBOutlet weak var btnShare: UIButton!
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var lbSubTitle: UILabel!
    @IBOutlet weak var lbPrice: UILabel!
    @IBOutlet weak var tbHeight: NSLayoutConstraint!
    @IBOutlet weak var detailTbHeight: NSLayoutConstraint!
    @IBOutlet weak var detailCollectionView: UICollectionView!
    @IBOutlet weak var lbappSize: UILabel!
    @IBOutlet weak var lbAge: UILabel!
    @IBOutlet weak var btnVersion: UIButton!
    @IBOutlet weak var tbDetail: UITextView!
    @IBOutlet weak var tbReleaseNote: UITextView!
    @IBOutlet weak var viewCategory: UIView!
    
    var detailData: resultVO?
    var istbOpen: Bool = false
    var tbReleaseSize : CGSize = CGSize()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        detailCollectionView.dataSource = self
        detailCollectionView.delegate = self
        setUi()
        self.detailCollectionView.reloadData()
        // Do any additional setup after loading the view.
    }
    
    func setUi(){
        self.btnWeb.layer.borderColor = UIColor.lightGray.cgColor
        self.btnWeb.layer.borderWidth = 1
        self.btnShare.layer.borderColor = UIColor.lightGray.cgColor
        self.btnShare.layer.borderWidth = 1
        self.tbHeight.constant = 0
        self.lbTitle.text = self.detailData?.trackName
        self.lbSubTitle.text = self.detailData?.artistName
        self.lbPrice.text = self.detailData?.formattedPrice
        let bcf = ByteCountFormatter()
        bcf.allowedUnits = [.useMB]
        self.lbappSize.text = bcf.string(fromByteCount: Int64(self.detailData!.fileSizeBytes)!)
        self.lbAge.text = self.detailData?.trackContentRating
        self.btnVersion.setTitle(self.detailData?.version, for: .normal)
        self.tbReleaseNote.text = self.detailData?.releaseNotes
        let sizeToFitIn = CGSize(width: self.tbReleaseNote.bounds.size.width, height: CGFloat(MAXFLOAT))
        self.tbReleaseSize = self.tbReleaseNote.sizeThatFits(sizeToFitIn)
        tbReleaseNote.textContainerInset = UIEdgeInsets(top: 7, left: 15, bottom: 0, right: 10)
        self.tbDetail.text = self.detailData?.desc
        let detailSizeToFitIn = CGSize(width: self.tbDetail.bounds.size.width, height: CGFloat(MAXFLOAT))
        let newSize = self.tbDetail.sizeThatFits(detailSizeToFitIn)
        self.detailTbHeight.constant = newSize.height
        var x = 10
        for genre in self.detailData!.genres{
            let button = UIButton(frame: CGRect(x: x,y: 0,width: 50,height: 20))
            button.titleLabel?.adjustsFontSizeToFitWidth = true
            button.titleLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
            button.setTitle("#" + genre, for: .normal)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 12)
            button.setTitleColor(UIColor.lightGray, for: .normal)
            button.contentEdgeInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
            button.sizeToFit()
            button.layer.borderWidth = 1
            button.layer.borderColor = UIColor.lightGray.cgColor
            button.layer.cornerRadius = 5
            self.viewCategory.addSubview(button)
            x = x + Int(button.bounds.size.width) + 5
        }
    }
    
    @IBAction func onClicktbHeight(_ sender: Any) {
        if istbOpen == false{
            self.tbHeight.constant = self.tbReleaseSize.height
            self.btnVersion.setImage(UIImage(named: "uparrow"), for: .normal)
        }
        else{
            self.tbHeight.constant = 0
            self.btnVersion.setImage(UIImage(named: "downarrow"), for: .normal)
        }
        istbOpen = !istbOpen
    }
    
    @IBAction func onClickbtnWeb(_ sender: Any) {
        let url = URL(string: self.detailData!.trackViewUrl)
        UIApplication.shared.open(url!, options: [:])

    }
    @IBAction func onClickbtnShare(_ sender: Any) {
        let items = [URL(string: self.detailData!.trackViewUrl)!]
        let ac = UIActivityViewController(activityItems: items, applicationActivities: nil)
        present(ac, animated: true)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return (self.detailData?.screenshotUrls.count)!
    }
        
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: DetailCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "DetailCollectionViewCell", for: indexPath) as! DetailCollectionViewCell

        let imageURL = URL(string: (self.detailData?.screenshotUrls[indexPath.row]) as! String)

        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: imageURL!) else { return }

            let image = UIImage(data: imageData)
            DispatchQueue.main.async {
                cell.imgView!.image = image
            }
        }
        return cell
    }

}
