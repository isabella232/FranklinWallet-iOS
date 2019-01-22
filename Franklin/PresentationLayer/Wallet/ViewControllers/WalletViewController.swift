//
//  WalletViewController.swift
//  DiveLane
//
//  Created by Anton Grigorev on 08/09/2018.
//  Copyright © 2018 Matter Inc. All rights reserved.
//

import UIKit
import Web3swift
import EthereumAddress
import BigInt

class WalletViewController: BasicViewController, SWRevealViewControllerDelegate {

    @IBOutlet weak var netLabel: UILabel!
    @IBOutlet weak var walletTableView: BasicTableView!
    @IBOutlet weak var sendMoneyButton: BasicBlueButton!
    @IBOutlet weak var scanQrButton: ScanButton!
    
    private var tokensService = TokensService()
    private var walletsService = WalletsService()
    private var tokensArray: [TableToken] = []

    private let alerts = Alerts()
    private let plasmaCoordinator = PlasmaCoordinator()
    private let etherCoordinator = EtherCoordinator()

    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action:
        #selector(self.handleRefresh(_:)),
                for: UIControl.Event.valueChanged)
        refreshControl.alpha = 0

        return refreshControl
    }()
    
    func setGestureForSidebar() {
        if self.revealViewController() != nil { self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = Colors.background
        self.tabBarController?.tabBar.selectedItem?.title = nil
        self.setupNavigation()
        self.setupTableView()
        self.setupNet()
        self.additionalSetup()
    }
    
    func additionalSetup() {
        self.sendMoneyButton.setTitle("Send money", for: .normal)
    }
    
    func setupNet() {
        self.netLabel.text = "Connected to \(CurrentNetwork.currentNetwork.name.capitalized)"
    }

    func setupTableView() {
        let nibToken = UINib.init(nibName: "TokenCell", bundle: nil)
        self.walletTableView.delegate = self
        self.walletTableView.dataSource = self
        let footerView = UIView()
        footerView.backgroundColor = Colors.background
        self.walletTableView.tableFooterView = footerView
        self.walletTableView.addSubview(self.refreshControl)
        self.walletTableView.register(nibToken, forCellReuseIdentifier: "TokenCell")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //self.refreshing(true)
        self.setGestureForSidebar()
        self.setTokensList()
    }

    func setupNavigation() {
        //self.title = CurrentNetwork.currentNetwork.name.capitalized
        self.navigationController?.navigationBar.isHidden = true
    }

    func clearData() {
        tokensArray.removeAll()
    }
    
    func setTokensList() {
        self.clearData()
        DispatchQueue.global().async { [unowned self] in
//            let franklin = self.plasmaCoordinator.getFranklin()
            let tokens = self.etherCoordinator.getTokens()
            self.tokensArray = tokens
            self.reloadDataInTable(completion: {
                self.updateTokensBalances {
                    self.reloadDataInTable {
                        //self.refreshing(false)
                    }
                }
            })
        }
    }
    
    @IBAction func showMenu(_ sender: Any) {
        self.revealViewController()?.revealToggle(animated: true)
    }

//    func unselectAllTokens() {
//        var indexPath = IndexPath(row: 0, section: 0)
//        for wallet in twoDimensionalTokensArray {
//            for _ in wallet.tokens {
//                self.twoDimensionalTokensArray[indexPath.section].tokens[indexPath.row].isSelected = false
//                if let cell = self.walletTableView.cellForRow(at: indexPath) as? TokenCell {
//                    cell.changeSelectButton(isSelected: false)
//                }
//                indexPath.row += 1
//            }
//            indexPath.section += 1
//            indexPath.row = 0
//        }
//    }

//    func selectToken(cell: UITableViewCell) {
//        unselectAllTokens()
//        guard let cell = cell as? TokenCell else {return}
//        guard let indexPathTapped = self.walletTableView.indexPath(for: cell) else {return}
//        let token = self.twoDimensionalTokensArray[indexPathTapped.section].tokens[indexPathTapped.row]
//        CurrentWallet.currentWallet = token.inWallet
//        CurrentToken.currentToken = token.token
//        self.twoDimensionalTokensArray[indexPathTapped.section].tokens[indexPathTapped.row].isSelected = true
//        cell.changeSelectButton(isSelected: true)
//    }

    func enterPincode(for transaction: PlasmaTransaction) {
        //need to wallet.getPassword
        let enterPincode = EnterPincodeViewController(for: .transaction, data: transaction)
        self.navigationController?.pushViewController(enterPincode, animated: true)
    }

    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        self.updateTokensBalances {
            self.reloadDataInTable {
                self.refreshing(false)
            }
        }
    }

    func reloadDataInTable(completion: @escaping () -> Void) {
        DispatchQueue.main.async { [unowned self] in
            self.walletTableView.reloadData()
            completion()
        }
    }

    func refreshing(_ enabled: Bool) {
        if enabled {
            DispatchQueue.main.async { [unowned self] in
                self.refreshControl.alpha = 0
                self.refreshControl.beginRefreshing()
            }
        } else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2,
                                          execute: { [unowned self] in
                                            self.refreshControl.endRefreshing()
//                                            let cell = self.walletTableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? TokenCell
//                                            AnimationController().makeMoveUpWithBounce(rowHeight: Constants.rows.heights.tokens, duration: 1.0, delayFactor: 0.0, cell: cell!)
            })
        }
    }

    func updateTokenRow(rowIndexPath: IndexPath) {
        DispatchQueue.main.async { [unowned self] in
            self.walletTableView.reloadRows(at: [rowIndexPath], with: .none)
        }
    }

    func updateTokensBalances(completion: @escaping () -> Void) {
        DispatchQueue.global().async { [unowned self] in
            var index = 0
            for token in self.tokensArray {
                var currentTableToken = token
                let currentToken = token.token
                let currentWallet = token.inWallet
                let balance: String
                if currentToken.isFranklin() {
                    balance = self.plasmaCoordinator.getBalance(wallet: currentWallet)
                } else {
                    balance = self.etherCoordinator.getBalance(for: currentToken, wallet: currentWallet)
                }
                currentToken.balance = balance
                currentTableToken.token = currentToken
                self.tokensArray[index] = currentTableToken
                index += 1
            }
            completion()
        }
    }
        
//        guard !self.ratesUpdating else {return}
//        self.ratesUpdating = true
//        guard !self.twoDimensionalTokensArray.isEmpty else {return}
//        var indexPath = IndexPath(row: 0, section: 0)
//        for wallet in self.twoDimensionalTokensArray {
//            for token in wallet.tokens {
//                var currentTableToken = token
//                let currentToken = token.token
//                let currentWallet = token.inWallet
//                let balance = self.etherCoordinator.getBalance(for: currentToken, wallet: currentWallet)
//                currentToken.balance = balance
//                let balanceInDollars = self.etherCoordinator.getBalanceInDollars(for: token.token, withBalance: balance)
//                currentToken.usdBalance = balanceInDollars
//                currentTableToken.token = currentToken
//                self.twoDimensionalTokensArray[indexPath.section].tokens[indexPath.row] = currentTableToken
////                    let ip = indexPath
////                    self.updateTokenRow(rowIndexPath: ip)
//                try? token.inWallet.setBalance(token: currentToken, network: CurrentNetwork.currentNetwork, balance: balance)
//                try? token.inWallet.setUsdBalance(token: currentToken, network: CurrentNetwork.currentNetwork, usdBalance: balanceInDollars)
//                indexPath.row += 1
//            }
//            indexPath.section += 1
//            indexPath.row = 0
//        }
//        self.ratesUpdating = false
//        completion()
//    }

    func deleteToken(in indexPath: IndexPath) {
        let token = self.tokensArray[indexPath.row].token
        let wallet = self.tokensArray[indexPath.row].inWallet
        let network = CurrentNetwork.currentNetwork
        let isEtherToken = token == Ether()
        let isFranklin = token == Franklin()
        if isEtherToken {return}
        if isFranklin {return}
        do {
            try wallet.delete(token: token, network: network)
            CurrentToken.currentToken = Franklin()
            self.setTokensList()
        } catch let error {
            self.alerts.showErrorAlert(for: self, error: error, completion: nil)
        }
    }

    func didPressAdd(sender: UIButton) {
        guard let wallet = CurrentWallet.currentWallet else {
            self.alerts.showErrorAlert(for: self, error: "Can't select wallet", completion: nil)
            return
        }
        let searchTokenController = SearchTokenViewController(for: wallet)
        self.navigationController?.pushViewController(searchTokenController, animated: true)
    }

}

//extension WalletViewController: UITableViewDelegate, UITableViewDataSource, TableHeaderDelegate {
extension WalletViewController: UITableViewDelegate, UITableViewDataSource {
    
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let background: TableHeader
//        switch self.blockchainControl.selectedSegmentIndex {
//        case Blockchain.ether.rawValue:
//            background = TableHeader(for: (self.twoDimensionalTokensArray[section].tokens.first?.inWallet)!, plasma: false, section: section)
//        default:
//            background = TableHeader(for: (self.twoDimensionalUTXOsArray[section].utxos.first?.inWallet)!, plasma: true, section: section)
//        }
//        background.delegate = self
//        return background
//    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constants.rows.heights.tokens
    }
//
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return Constants.headers.heights.tokens
//    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tokensArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TokenCell",
                                                       for: indexPath) as? TokenCell else {
                                                        return UITableViewCell()
        }
        let tableToken = self.tokensArray[indexPath.row]
        cell.configure(token: tableToken)
        cell.delegate = self
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let indexPathForSelectedRow = tableView.indexPathForSelectedRow else {
            return
        }
        let cell = tableView.cellForRow(at: indexPathForSelectedRow) as? TokenCell
        guard let selectedCell = cell else {
            return
        }
        guard let indexPathTapped = self.walletTableView.indexPath(for: selectedCell) else {
            return
        }
        let tableToken = self.tokensArray[indexPathTapped.row]
        let tokenViewController = TokenViewController(token: tableToken.token)
        self.navigationController?.pushViewController(tokenViewController, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.deleteToken(in: indexPath)
        }
    }

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        guard let indexPathForSelectedRow = tableView.indexPathForSelectedRow else {
            return false
        }
        let cell = tableView.cellForRow(at: indexPathForSelectedRow) as? TokenCell
        guard let selectedCell = cell else {
            return false
        }
        guard let indexPathTapped = self.walletTableView.indexPath(for: selectedCell) else {
            return false
        }
        let token = self.tokensArray[indexPathTapped.row].token
        if token.isEther() || token.isFranklin() {
            return false
        }
        return true
    }
}

extension WalletViewController: TokenCellDelegate {
    func tokenInfoTapped(_ sender: TokenCell) {
        guard let indexPathTapped = self.walletTableView.indexPath(for: sender) else {
            return
        }
        let token = self.tokensArray[indexPathTapped.row].token
        print(token.walletAddress)
    }
}
