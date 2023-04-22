//
//  MovieDetailsViewController.swift
//  Tipster
//
//  Created by Man deng Ho on 9/16/22.
//

import UIKit
import AlamofireImage

class MovieDetailsViewController: UIViewController {
    
    
    @IBOutlet weak var backDropView: UIImageView!
    
    @IBOutlet weak var posterView: UIImageView! {
        didSet {
            let imageTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
            posterView.addGestureRecognizer(imageTapGestureRecognizer)
            posterView.isUserInteractionEnabled = true
        }
    }
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var synopsisLabel: UILabel!

    var movie: [String: Any]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        // Do any additional setup after loading the view.
       
               
        posterView.isUserInteractionEnabled = true
       
        titleLabel.text = movie["title"] as? String
        titleLabel.sizeToFit()
        synopsisLabel.text = movie["overview"] as? String
        synopsisLabel.sizeToFit()
        
        let baseUrl = "https://image.tmdb.org/t/p/w185"
        let posterPath = movie["poster_path"] as! String
        let posterUrl = URL(string: baseUrl + posterPath)
        
        posterView.af_setImage(withURL: posterUrl!)
        
        let backdropPath = movie["backdrop_path"] as! String
        let backdropUrl = URL(string: "https://image.tmdb.org/t/p/w780" + backdropPath)
        
        backDropView.af_setImage(withURL: backdropUrl!)
        
    }
    
    @objc func imageTapped() {
        //navigate to another view controller
        // Create an instance of the trailerViewController
           
           
           // Set the movieId property of the trailerViewController
           
        let videotrailerVC = videoTrailerViewController()
        videotrailerVC.movieId = movie["id"] as? Int
            self.present(videotrailerVC, animated: true)
           // Present the trailerViewController
           
       
       
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
