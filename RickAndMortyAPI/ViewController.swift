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
        if infoData.prev != nil {
            currentPage -= 1
            self.getDataFrom(url: infoData.prev!)
            self.pageLabel.text = "\(self.currentPage) / \(self.infoData.pages!)"
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            
        }
        
    }
    @IBAction func nextButtonAction(_ sender: Any) {
        if infoData.next != nil {
            currentPage += 1
            
            self.getDataFrom(url: infoData.next!)
            self.pageLabel.text = "\(self.currentPage) / \(self.infoData.pages!)"
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    var infoData = InfoData(count: nil, pages: nil, next: nil, prev: nil)
    var currentPage:Int = 1

    var listOfResults = [ResultInfo]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.navigationItem.title = "Character"
                self.pageLabel.text = "\(self.currentPage) / \(self.infoData.pages!)"
            }
        }
    }
    
    var resultDetail = ResultInfo(id: 0, name: "", status: nil, species: nil, gender: nil, image: nil, origin: nil, location: nil)
    
    var viewModel = ResultViewModel()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listOfResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell1", for: indexPath)
        let result = listOfResults[indexPath.row]
        cell.textLabel?.text = "\(result.name)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        resultDetail = viewModel.getResult(at: indexPath.row)
        performSegue(withIdentifier: "MainToDetailViewController", sender: nil)
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        self.getDataFrom(url: EndPoint.resourceURL)
        
    }


    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            
            let destinationVC = segue.destination as! ResultInfoViewController
            
            // Pass text to SecondVC
            destinationVC.resultDetail = self.resultDetail
        
    }
}

extension ViewController {
    func getDataFrom(url:String) {
        let request = viewModel.apiRequest
        request.getResultDataFromAPI(url: url) { [weak self] result in
            switch result {
            case .failure(let err):
                print(err)
            case .success(let results):
                self?.listOfResults = results
                self?.viewModel.characters = results
            }
            
        }
        
        
        request.getInfoDataFromAPI(url: url) { [weak self] result in
            switch result {
            case .failure(let err):
                print(err)
            case .success(let info):
                self?.infoData = info
            }
            
        }
    }
}
