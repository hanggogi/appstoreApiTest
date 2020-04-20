//
//  ViewController.swift
//  appstoreApiTest
//
//  Created by samga on 2020/04/16.
//  Copyright © 2020 samga. All rights reserved.
//

import UIKit
import Alamofire
import ObjectMapper

struct Config {
    static let searchURL = "https://itunes.apple.com/search?term=핸드메이드&country=kr&media=software"
}

class ViewController: UIViewController  {
    
    @IBOutlet weak var handMadeTableView: UITableView!
    
    private var detailViewController: DetailViewController?
    
    var datas: [resultVO] = []
    var resultCnt = 0;
    
    func loadData(){
        let encodedUrl = Config.searchURL.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        AF.request(encodedUrl!, method: .get,  parameters: nil, encoding: JSONEncoding.default)
            .responseJSON { response in
            switch response.result {

            case .success(let result):

                let resultDic = result as! [String: Any]
                self.resultCnt = resultDic["resultCount"] as! Int
                
                for data in resultDic["results"] as! NSArray {
                    self.datas.append(resultVO(JSON: data as! [String : Any])!)
                }
                self.handMadeTableView.reloadData()
            default:
                print("Error")
            }
                
        }
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        handMadeTableView.dataSource = self
        handMadeTableView.delegate = self
        loadData()
        

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        let vc = segue.destination as! DetailViewController
        let cell = sender as! UITableViewCell
        let indexPath = handMadeTableView.indexPath(for: cell)
        vc.detailData = self.datas[indexPath!.row]

    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
            return .lightContent
        }
}

extension ViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
 
    }
}

extension ViewController: UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView,
                    numberOfRowsInSection section: Int) -> Int {
        return self.resultCnt
    }
    

    func tableView(_ tableView: UITableView,
                    cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: HmTableViewCell = tableView.dequeueReusableCell(withIdentifier: "HmTableViewCell", for: indexPath) as! HmTableViewCell
        let cellData = self.datas[indexPath.row] as resultVO
        print(self.datas)
        let imageURL = URL(string: cellData.artworkUrl512)

        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: imageURL!) else { return }

            let image = UIImage(data: imageData)
            DispatchQueue.main.async {
                cell.imgView!.image = image
            }
        }
        cell.resultTitle.text = cellData.trackName
        cell.resultSubTitle.text = cellData.artistName
        cell.category.text = cellData.genres.joined(separator: " , ")
        cell.price.text = cellData.formattedPrice
        cell.rateView.rating = Double(cellData.averageUserRating)
        return cell
    }
    

}
