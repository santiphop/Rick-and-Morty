//
//  ViewController.swift
//  RickAndMortyAPI
//
//  Created by Santiphop on 1/11/2563 BE.
//

import UIKit

class ViewController: UIViewController {
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
    
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Character"
        
        updateView(url: EndPoint.resourceURL)
       
    }


    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            
            let destinationVC = segue.destination as! ResultInfoViewController
            
            // Pass text to SecondVC
            destinationVC.resultDetail = self.resultDetail

    }
    
    func updateView(url: String) {
        self.viewModel.getDataFromAPIRequest(url: url) { _ in
            DispatchQueue.main.async {
                self.pageLabel.text = "\(self.currentPage) / \(self.viewModel.infoData.pages!)"
                self.tableView.reloadData()
            }
        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
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
}
