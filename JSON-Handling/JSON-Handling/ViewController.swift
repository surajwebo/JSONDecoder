//
//  ViewController.swift
//  JSON-Handling
//
//  Created by Suraj Mirajkar on 14/03/22.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var decodeButton: UIButton!
    var jsonData: Data?
    var studentsList: StudentsList?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getJsonFromFileInBundle()
    }
    
    func getJsonFromFileInBundle() {
        if let studentsListJsonPath = Bundle.main.path(forResource: "StudentsList", ofType: "json") {
            do {
                jsonData = try String(contentsOfFile: studentsListJsonPath).data(using: .utf8)
            } catch {
                print(error)
            }
        }
    }
    
    
    @IBAction func decodeJson(_ sender: Any) {
        if let jsonData = jsonData {
            do {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "EEE, dd MMM y"
                let jsonDecoder = JSONDecoder()
                jsonDecoder.dateDecodingStrategy = .formatted(dateFormatter)
                studentsList = try jsonDecoder.decode(StudentsList.self, from: jsonData)
                guard let studentsList = studentsList else {
                    print("Json Decoding failed")
                    return
                }
                print("Json Decoded :\n", studentsList.students as Any)
            } catch let error {
                print("Json Decoding failed with error: \n", error.localizedDescription)
            }
        }
    }
}

