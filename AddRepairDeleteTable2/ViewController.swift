//
//  ViewController.swift
//  AddRepairDeleteTable2
//
//  Created by admin on 2/18/20.
//  Copyright © 2020 Long. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var nodataFootter: UIView!
    @IBOutlet weak var nodataHeatter: UIView!

    var arrayName: [String] = []
    var haveNoData: Bool = true {
        didSet{
            if haveNoData == true {
                tableView.tableFooterView = nodataFootter
            } else {
                tableView.tableFooterView = nodataHeatter
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        tableView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if (arrayName.count == 0 ) {
            haveNoData = true
        } else {
            haveNoData = false
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayName.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "IDCell", for: indexPath)
        cell.textLabel?.text = arrayName[indexPath.row]
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let secondViewcontroller = segue.destination as? SecondViewController
            if let indexTable = tableView.indexPathForSelectedRow {
                secondViewcontroller?.dataSecond = arrayName[indexTable.row]
            }
        }
    
    @IBAction func unwind(for unwindSegue: UIStoryboardSegue) {
        if let passDataUnwind = unwindSegue.source as? SecondViewController {
            if let indexTable = tableView.indexPathForSelectedRow {
                guard let dataCheck = passDataUnwind.dataSecond else { return }
                if dataCheck.trimmingCharacters(in: .whitespaces).isEmpty {
                    // chuoi chua cac ki tu la khoang trang
                } else {
                    arrayName[indexTable.row] = dataCheck
                }
                
            } else {
                guard let dataAdd = passDataUnwind.dataSecond else { return }
                if dataAdd.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                    // chuoi chua cac ki tu la khoang trang, hay dau cach
                } else {
                    arrayName.append(dataAdd)
                }
            }
           tableView.reloadData()
       }
    }
    // sự khác biệt giữa truyền data bằng delegate với truyền data bằng unwind:
    // truyền bằng unwind thì nó hiểu cái hàm tableView.indexpathForSelectedRow được bấm từ cái dòng cell là let = indexTable được truyền về đúng với cái cell mk bấm khi thực hiện sửa cell.
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            arrayName.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.reloadData()
        }
        if ( arrayName.count == 0 ) {
            haveNoData = true
        } else {
            haveNoData = false
        }
    }
}
