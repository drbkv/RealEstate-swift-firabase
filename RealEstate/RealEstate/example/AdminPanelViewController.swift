//
//  AdminPanelViewController.swift
//  RealEstate
//
//  Created by Ramzan on 11.05.2024.
//

import Foundation
import UIKit
import Firebase

class AdminPanelViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    private var listings: [RealEstateListing] = []
    private let tableView = UITableView()
    private let databaseRef = Database.database().reference().child("listings")

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Admin Panel"

        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        loadListings()
    }

    private func loadListings() {
        databaseRef.observeSingleEvent(of: .value) { [weak self] (snapshot) in
            guard let listingData = snapshot.value as? [String: Any] else {
                print("No listing data found")
                return
            }
            self?.listings.removeAll()
            for (_, value) in listingData {
                if let listing = value as? [String: Any] {
                    let userId = listing["userId"] as? String ?? ""
                    let typeString = listing["type"] as? String ?? ""
                    let propertyTypeString = listing["propertyType"] as? String ?? ""
                    let price = listing["price"] as? Int ?? 0
                    let numberOfRooms = listing["numberOfRooms"] as? Int ?? 0
                    let area = listing["area"] as? Int ?? 0
                    let photoURL = listing["photoURL"] as? String ?? ""
                    let description = listing["description"] as? String ?? ""
                    let address = listing["address"] as? String ?? ""

                    let type: ListingType = typeString == "sale" ? .sale : .rent
                    let propertyType: PropertyType
                    switch propertyTypeString {
                    case "apartment":
                        propertyType = .apartment
                    case "house":
                        propertyType = .house
                    default:
                        propertyType = .other
                    }

                    let realEstateListing = RealEstateListing(
                        id: nil,
                        userId: userId,
                        type: type,
                        propertyType: propertyType,
                        price: price,
                        numberOfRooms: numberOfRooms,
                        area: area,
                        photoURL: photoURL,
                        description: description,
                        address: address
                    )
                    self?.listings.append(realEstateListing)
                }
            }
            self?.tableView.reloadData()
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listings.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let listing = listings[indexPath.row]
        cell.textLabel?.text = "\(listing.address), \(listing.type == .sale ? "Sale" : "Rent")"
        return cell
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let listing = listings[indexPath.row]
            deleteListing(listing)
        }
    }

    private func deleteListing(_ listing: RealEstateListing) {
        if let id = listing.id {
            databaseRef.child(id).removeValue { [weak self] error, _ in
                if let error = error {
                    print("Error deleting listing: \(error.localizedDescription)")
                } else {
                    print("Listing deleted successfully")
                    self?.loadListings()
                }
            }
        }
    }
}

