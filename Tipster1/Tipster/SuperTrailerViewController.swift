//
//  SuperTrailerViewController.swift
//  Tipster
//
//  Created by Man deng Ho on 4/22/23.
//

import UIKit
import WebKit

class SuperTrailerViewController: UIViewController, WKNavigationDelegate {
    
    //var webView: WKWebView!
    @IBOutlet weak var superTrailer: WKWebView!
    
    var movieId: Int!
    
    override func loadView() {
       
        let webConfiguration = WKWebViewConfiguration()
        superTrailer = WKWebView(frame: .zero, configuration: webConfiguration)
        superTrailer.navigationDelegate = self
        view = superTrailer
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        guard let movieId = movieId else {
                    print("movieId is nil")
                    return
                }
   // https://api.themoviedb.org/3/movie/9413/videos?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed&language=en-US
                let apiKey = "a07e22bc18f5cb106bfe4cc1f83ad8ed"
                let videoUrlStr = "https://api.themoviedb.org/3/movie/\(movieId)/videos?api_key=\(apiKey)&language=en-US"
                guard let videoUrl = URL(string: videoUrlStr) else {
                    print("Error creating video url")
                    return
                }
                
                let videoTask = URLSession.shared.dataTask(with: videoUrl) { (videoData, videoResponse, videoError) in
                    if let videoError = videoError {
                        print(videoError.localizedDescription)
                    } else if let videoData = videoData {
                        let videoDataDictionary = try! JSONSerialization.jsonObject(with: videoData, options: []) as! [String: Any]
                        let videos = videoDataDictionary["results"] as! [[String:Any]]
                        
                        if let firstVideo = videos.first {
                            let videoKey = firstVideo["key"] as! String
                            let videoUrl = URL(string: "https://www.youtube.com/watch?v=\(videoKey)")!
                            let request = URLRequest(url: videoUrl)
                            DispatchQueue.main.async {
                                self.superTrailer.load(request)
                            }
                        }
                    }
                }
                
                videoTask.resume()
                        }
    }
    

    /*
    // MARK: - Navigation

        // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


