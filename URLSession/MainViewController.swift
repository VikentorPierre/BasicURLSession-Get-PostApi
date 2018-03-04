//
//  ViewController.swift
//  URLSession
//  Created by Vikentor Pierre on 3/4/18.
//  Copyright © 2018 Vikentor Pierre. All rights reserved.
//

import UIKit
import SnapKit

class MainViewController: UIViewController {
    
    let getButton:UIButton = {
        let button = UIButton()
        button.setTitle("Get", for: .normal)
        button.setTitleColor(UIColor.blue, for: .normal)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.blue.cgColor
        button.layer.cornerRadius = 10
        button.tag = 10
        button.addTarget(self, action: #selector(getPress), for: .touchUpInside)
        return button
    }()
    let postButton:UIButton = {
        let button = UIButton()
        button.setTitle("Post", for: .normal)
        button.setTitleColor(UIColor.blue, for: .normal)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.blue.cgColor
        button.layer.cornerRadius = 10
        button.tag = 20
        button.addTarget(self, action: #selector(postPress), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNav()
        setupLayout()
    }
    func setupLayout(){
        [getButton, postButton].forEach{view.addSubview($0)}
        getButton.snp.makeConstraints { (make) in
            make.width.height.equalTo(50)
            make.center.equalTo(self.view)
            
        }
        postButton.snp.makeConstraints { (make) in
            make.width.height.equalTo(50)
            make.centerX.equalTo(self.view)
            make.top.equalTo(100)
        }
        
        
    }
    func setupNav(){
        navigationItem.title = "URL-Session"
        view.backgroundColor = .white
    }
    @objc func postPress(sender:UIButton){
        let parameter = ["Username":"vick","tweet":"Hello world"] // the data we gonna post
        
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else{return}
        var request = URLRequest(url: url)
        request.httpMethod = "POST" // the type of request
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameter, options: []) else{return}
        request.httpBody = httpBody
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            if let response = response {
                print(response)  }
            if let data = data {
                do{
                    var json = try JSONSerialization.jsonObject(with: data, options: [])
                    print(json)
                }
                catch{
                    print(error)
                }
            }

        }.resume()
        
    }
    
    @objc func getPress(sender:UIButton){
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/users") else{return}
        let session = URLSession.shared
        session.dataTask(with: url) { (data, response, error) in
            // optional chaining because data response and error are optional
            if let response = response {
                print(response)  }
            if let data = data {
                //cannot read the data with just print so we have to convert it to json
                do{
                    var json = try JSONSerialization.jsonObject(with: data, options: [])
                    print(json)
                }
                catch{
                    print(error)
                }
                
            }
            
            }.resume()
    }


}//endClass

