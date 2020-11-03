//
//  ViewController.swift
//  RickAndMortyAPI
//
//  Created by Santiphop on 1/11/2563 BE.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet var tableView: UITableView!
    @IBOutlet var pageLabel: UILabel!
    
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var prevButton: UIButton!
    
    @IBAction func prevButtonAction(_ sender: Any) {
        if let prevPage = viewModel.infoData.prev {
            currentPage -= 1
            self.updateView(url: prevPage)
        }
        
    }
    @IBAction func nextButtonAction(_ sender: Any) {
        if let nextPage = viewModel.infoData.next {
            currentPage += 1
            self.updateView(url: nextPage)
        }
        
    }

    var currentPage:Int = 1
    
    var resultDetail = ResultInfo(id: 0, name: "", status: nil, species: nil, gender: nil, image: nil, origin: nil, location: nil)
    
    var viewModel = ResultViewModel()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell1", for: indexPath)
        let result = viewModel.results[indexPath.row]
        cell.textLabel?.text = "\(result.name)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        resultDetail = viewModel.results[indexPath.row]
        performSegue(withIdentifier: "MainToDetailViewController", sender: nil)
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Character"
        
        viewModel.getDataFromAPIHandleClass(url: EndPoint.resourceURL)
        updateView(url: EndPoint.resourceURL)

//        while true {
//            print("try")
//            if viewModel.infoData.pages != nil {
//                DispatchQueue.main.async {
//                    self.updatePageLabel()
//                    self.tableView.reloadData()
//                }
//                break
//            }
//        }
        
        
        
    }


    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            
            let destinationVC = segue.destination as! ResultInfoViewController
            
            // Pass text to SecondVC
            destinationVC.resultDetail = self.resultDetail

    }
    
    func updateView(url: String) {
        self.viewModel.getDataFromAPIHandleClass(url: url)
        sleep(1)
        
        self.pageLabel.text = "\(self.currentPage) / \(self.viewModel.infoData.pages!)"
        self.tableView.reloadData()
        
    }
}

//
//extension ViewController {
//    func getDataFrom(url:String) {
//        let request = viewModel.apiRequest
//        request.getResultDataFromAPI(url: url) { [weak self] result in
//            switch result {
//            case .failure(let err):
//                print(err)
//            case .success(let results):
////                self?.listOfResults = results
//                self?.viewModel.characters = results
//            }
//
//        }
//
//
//        request.getInfoDataFromAPI(url: url) { [weak self] result in
//            switch result {
//            case .failure(let err):
//                print(err)
//            case .success(let info):
//                self?.infoData = info
//            }
//
//        }
//    }
//}
