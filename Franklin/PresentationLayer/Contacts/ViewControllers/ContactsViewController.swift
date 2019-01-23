//
//  ContactsViewController.swift
//  DiveLane
//
//  Created by Anton Grigorev on 16.10.2018.
//  Copyright © 2018 Matter Inc. All rights reserved.
//

import UIKit
import SideMenu

class ContactsViewController: BasicViewController, SWRevealViewControllerDelegate, AddContactDelegate {

    @IBOutlet weak var collectionView: UICollectionView!
    //@IBOutlet weak var contactsTableView: BasicTableView!
    @IBOutlet weak var helpLabel: UILabel!
    @IBOutlet weak var addContactButton: BasicBlueButton!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var contactsList: [Contact] = []
    var filteredContactsList: [Contact] = []
    
    let contactsService = ContactsService()
    let alerts = Alerts()
    let interactor = Interactor()
    
    private let reuseIdentifier = "ContactCell"
    private let sectionInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    private let itemsPerRow: CGFloat = 3
    
    var searchActive : Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = Colors.background
        self.hideKeyboardWhenTappedAround()
        self.setupNavigation()
        self.setupTableView()
        self.setupSearchBar()
        self.additionalSetup()
        self.setupSideBar()
    }
    
    func additionalSetup() {
        self.addContactButton.setTitle("Add contact", for: .normal)
    }
    
//    func setGestureForSidebar() {
//        if self.revealViewController() != nil { self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
//        }
//    }

    func setupNavigation() {
        self.navigationController?.navigationBar.isHidden = true
    }

    func setupTableView() {
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        //self.contactsTableView.delegate = self
        //self.contactsTableView.dataSource = self
        let footerView = UIView()
        footerView.backgroundColor = Colors.firstMain
        //self.contactsTableView.tableFooterView = footerView
        
        let nibSearch = UINib.init(nibName: "ContactCell", bundle: nil)
        self.collectionView.register(nibSearch, forCellWithReuseIdentifier: reuseIdentifier)
        self.contactsList.removeAll()
    }

    func setupSearchBar() {
        searchBar.delegate = self
        definesPresentationContext = true
//        searchController = UISearchController(searchResultsController: nil)
//        searchController.dimsBackgroundDuringPresentation = false
//        contactsTableView.tableHeaderView = searchController.searchBar
//        searchController.searchBar.delegate = self
//        searchController.searchBar.barTintColor = UIColor.white
//        searchController.delegate = self
//        searchController.searchBar.tintColor = UIColor.lightGray
//        searchController.hidesNavigationBarDuringPresentation = false
//        definesPresentationContext = true
//        self.searchController.hideKeyboardWhenTappedOutsideSearchBar(for: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.makeHelpLabel(enabled: false)
        //self.setGestureForSidebar()
        getAllContacts()
    }
    
    func setupSideBar() {
        let menuLeftNavigationController = UISideMenuNavigationController(rootViewController: SettingsViewController())
        SideMenuManager.default.menuLeftNavigationController = menuLeftNavigationController
        
        //SideMenuManager.default.menuAddPanGestureToPresent(toView: self.navigationController!.navigationBar)
        SideMenuManager.default.menuAddScreenEdgePanGesturesToPresent(toView: self.view)
        
        SideMenuManager.default.menuFadeStatusBar = false
        SideMenuManager.default.menuPresentMode = .menuSlideIn
        SideMenuManager.default.menuWidth = 0.85 * UIScreen.main.bounds.width
        SideMenuManager.default.menuShadowOpacity = 0.5
        SideMenuManager.default.menuShadowColor = UIColor.black
        SideMenuManager.default.menuShadowRadius = 100
    }
    
    func hasBeenDismissed() {
        getAllContacts()
    }

    func getAllContacts() {
        do {
            let contacts = try contactsService.getAllContacts()
            updateContactsList(with: contacts)
        } catch {
            updateContactsList(with: [])
        }
    }
    
    @IBAction func showMenu(_ sender: UIButton) {
        //self.revealViewController()?.revealToggle(animated: true)
        present(SideMenuManager.default.menuLeftNavigationController!, animated: true, completion: nil)
    }

    @IBAction func addContact(_ sender: Any) {
        self.searchBar.endEditing(true)
        let addContactController = AddContactController()
        addContactController.delegate = self
        addContactController.modalPresentationStyle = .overCurrentContext
        self.present(addContactController, animated: true, completion: nil)
    }
    
    func makeHelpLabel(enabled: Bool) {
        DispatchQueue.main.async { [weak self] in
            self?.helpLabel.alpha = enabled ? 1 : 0
        }
    }
    
    func emptyContactsList() {
        contactsList = []
        DispatchQueue.main.async { [weak self] in
            self?.collectionView?.reloadData()
        }
    }
    
    func updateContactsList(with list: [Contact]) {
        DispatchQueue.main.async { [weak self] in
            self?.contactsList = list
            if list.count == 0 && self?.searchBar.text == "" {
                self?.makeHelpLabel(enabled: true)
            }
            self?.collectionView?.reloadData()
        }
    }
}

extension ContactsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView,
                                 numberOfItemsInSection section: Int) -> Int {
        if contactsList.isEmpty {
            return 0
        } else {
            return contactsList.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if !contactsList.isEmpty {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ContactCell",
                                                           for: indexPath) as? ContactCell else {
                                                            return UICollectionViewCell()
            }
            cell.configure(with: contactsList[indexPath.row])
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
}

//extension ContactsViewController: UITableViewDelegate, UITableViewDataSource {
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if contactsList.isEmpty {
//            return 0
//        } else {
//            return contactsList.count
//        }
//    }
//
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return 1
//    }
//
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return Constants.rows.heights.contacts
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        if !contactsList.isEmpty {
//            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ContactCell",
//                                                           for: indexPath) as? ContactCell else {
//                                                            return UITableViewCell()
//            }
//            cell.configure(with: contactsList[indexPath.row])
//            return cell
//        } else {
//            return UITableViewCell()
//        }
//    }
//
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let contact = contactsList[indexPath.row]
////        let tokenController = TokenViewController(destinationAddress: contact.address)
////        tokenController.modalPresentationStyle = .overCurrentContext
////        self.navigationController?.pushViewController(tokenController, animated: true)
//        tableView.deselectRow(at: indexPath, animated: true)
//    }
//
//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            do {
//                let contact = contactsList[indexPath.row]
//                try contact.deleteContact()
//                let searchText = self.searchBar.text ?? ""
//                if searchText != "" {
//                    self.searchContact(string: searchText)
//                } else {
//                    self.getAllContacts()
//                }
//            } catch let error {
//                alerts.showErrorAlert(for: self, error: error, completion: nil)
//            }
//        }
//    }
//}

//extension ContactsViewController: UISearchControllerDelegate {
//    func didPresentSearchController(_ searchController: UISearchController) {
//        searchController.searchBar.showsCancelButton = false
//    }
//}

extension ContactsViewController: UISearchBarDelegate {

    func searchContact(string: String) {
        guard let list = try? ContactsService().getFullContactsList(for: string) else {
            self.emptyContactsList()
            return
        }
        self.updateContactsList(with: list)
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
            getAllContacts()
        } else {
            let contact = searchText
            searchContact(string: contact)
        }
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.collectionView.setContentOffset(.zero, animated: true)
//        self.contactsTableView.setContentOffset(.zero, animated: true)
        getAllContacts()
    }
}

extension ContactsViewController: UIViewControllerTransitioningDelegate {
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return DismissAnimator()
    }
    
    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return interactor.hasStarted ? interactor : nil
    }
}

extension ContactsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
//        let availableWidth = view.frame.width - paddingSpace
//        let widthPerItem = availableWidth / itemsPerRow
        
        let width = UIScreen.main.bounds.width * 0.8 / 3 - 15
        
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
}
