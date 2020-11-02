//
//  ResultInfoViewController.swift
//  RickAndMortyAPI
//
//  Created by Santiphop on 2/11/2563 BE.
//

import UIKit

class ResultInfoViewController: UIViewController {

    @IBOutlet var label: UILabel!
    @IBOutlet weak var resultImage: UIImageView!
    var resultDetail:ResultInfo!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = resultDetail.name
        let format = "ID: \(resultDetail.id)\nName: \(resultDetail.name)\nStatus: \(resultDetail.status!)\nSpecies: \(resultDetail.species!)\nGender: \(resultDetail.gender!)\nOrigin: \(resultDetail.origin!.name!)\nLocation: \(resultDetail.location!.name!)"
        label.text = format
        resultImage.load(url: URL(string: resultDetail.image!)!)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
