//
//  TrailerViewController.swift
//  Flix
//
//  Created by Ruben A Gonzalez on 2/12/18.
//  Copyright © 2018 Ruben A Gonzalez. All rights reserved.
//

import UIKit

class TrailerViewController: UIViewController {

    @IBOutlet weak var webView: UIWebView!
    
    var movie: [String: Any]?
    var trailers: [[String: Any]] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.fetchTrailer()
        // Do any additional setup after loading the view.
    }

    func fetchTrailer() {
        let first_url = "https://api.themoviedb.org/3/movie/"
        let second_url = "/videos?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed&language=en-US"
        let movie_id = movie!["id"] as! NSNumber
        let url = URL(string: first_url + movie_id.stringValue + second_url)!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
            
            // This will run when the network request returns
            if let error = error {
                
                print(error.localizedDescription)
            } else if let data = data {
                // Fetch the data from the JSON file
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                print(dataDictionary)
                let trailers = dataDictionary["results"] as! [[String: Any]]
                let trailer = trailers[0]
                let key = trailer["key"] as! String
                if let myURL = URL(string: "https://www.youtube.com/watch?v=" + key) {
                    // Place the URL in a URL Request.
                    let request = URLRequest(url: myURL)
                    // Load Request into WebView.
                    self.webView.loadRequest(request)
                }
            }
        }
        task.resume()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
