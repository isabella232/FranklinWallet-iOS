//
//  ABIs.swift
//  DiveLane
//
//  Created by Anton Grigorev on 28/11/2018.
//  Copyright © 2018 Matter Inc. All rights reserved.
//

import Foundation

public struct ABIs {
    static let peepeth = """
[ { "constant": false, "inputs": [ { "name": "_followee", "type": "address" } ], "name": "unFollow", "outputs": [], "payable": false, "stateMutability": "nonpayable", "type": "function" },
{ "constant": false, "inputs": [ { "name": "_ipfsHash", "type": "string" } ], "name": "updateAccount", "outputs": [], "payable": false, "stateMutability": "nonpayable", "type": "function" },
{ "constant": true, "inputs": [], "name": "isActive", "outputs": [ { "name": "", "type": "bool" } ], "payable": false, "stateMutability": "view", "type": "function" },
{ "constant": false, "inputs": [ { "name": "_isActive", "type": "bool" } ], "name": "setIsActive", "outputs": [], "payable": false, "stateMutability": "nonpayable", "type": "function" },
{ "constant": false, "inputs": [ { "name": "_followee", "type": "address" } ], "name": "follow", "outputs": [], "payable": false, "stateMutability": "nonpayable", "type": "function" },
{ "constant": false, "inputs": [ { "name": "_name", "type": "bytes16" } ], "name": "changeName", "outputs": [], "payable": false, "stateMutability": "nonpayable", "type": "function" },
{ "constant": true,
"inputs": [ { "name": "", "type": "address" } ], "name": "names",
"outputs": [ { "name": "", "type": "bytes32" } ],
"payable": false, "stateMutability": "view", "type": "function" },
{ "constant": false, "inputs": [ { "name": "_ipfsHash", "type": "string" } ], "name": "reply", "outputs": [], "payable": false, "stateMutability": "nonpayable", "type": "function" },
{ "constant": true,
"inputs": [ { "name": "", "type": "bytes32" } ], "name": "addresses",
"outputs": [ { "name": "", "type": "address" } ],
"payable": false, "stateMutability": "view", "type": "function" },
{ "constant": false, "inputs": [ { "name": "_address", "type": "address" } ], "name": "setNewAddress", "outputs": [], "payable": false, "stateMutability": "nonpayable", "type": "function" },
{ "constant": true,
"inputs": [ { "name": "_addr", "type": "address" } ], "name": "accountExists",
"outputs": [ { "name": "", "type": "bool" } ],
"payable": false, "stateMutability": "view", "type": "function" },
{ "constant": true,
"inputs": [ { "name": "bStr", "type": "bytes16" } ], "name": "isValidName",
"outputs": [ { "name": "", "type": "bool" } ],
"payable": false, "stateMutability": "pure", "type": "function" },
{ "constant": false, "inputs": [ { "name": "_ipfsHash", "type": "string" } ], "name": "share", "outputs": [], "payable": false, "stateMutability": "nonpayable", "type": "function" },
{ "constant": false, "inputs": [ { "name": "_ipfsHash", "type": "string" } ], "name": "saveBatch", "outputs": [], "payable": false, "stateMutability": "nonpayable", "type": "function" },
{ "constant": false, "inputs": [], "name": "cashout", "outputs": [], "payable": false, "stateMutability": "nonpayable", "type": "function" },
{ "constant": true, "inputs": [], "name": "owner", "outputs": [ { "name": "", "type": "address" } ], "payable": false, "stateMutability": "view", "type": "function" },
{ "constant": false, "inputs": [ { "name": "_ipfsHash", "type": "string" } ], "name": "post", "outputs": [], "payable": false, "stateMutability": "nonpayable", "type": "function" },
{ "constant": false,
"inputs": [ { "name": "_name", "type": "bytes16" }, { "name": "_ipfsHash", "type": "string" } ], "name": "createAccount",
"outputs": [], "payable": false, "stateMutability": "nonpayable", "type": "function" },
{ "constant": false,
"inputs": [ { "name": "newMinPercentage", "type": "uint256" } ], "name": "setMinSiteTipPercentage",
"outputs": [],
"payable": false, "stateMutability": "nonpayable", "type": "function" },
{ "constant": false,
"inputs": [ { "name": "_author", "type": "address" }, { "name": "_messageID", "type": "string" },
{ "name": "_ownerTip", "type": "uint256" }, { "name": "_ipfsHash", "type": "string" } ],
"name": "tip",
"outputs": [],
"payable": true, "stateMutability": "payable", "type": "function" },
{ "constant": true, "inputs": [], "name": "newAddress", "outputs": [ { "name": "", "type": "address" } ], "payable": false, "stateMutability": "view", "type": "function" },
{ "constant": true,
"inputs": [ { "name": "", "type": "uint256" } ], "name": "interfaceInstances",
"outputs": [ { "name": "interfaceAddress", "type": "address" }, { "name": "startBlock", "type": "uint96" } ],
"payable": false, "stateMutability": "view", "type": "function" },
{ "constant": false, "inputs": [ { "name": "_address", "type": "address" } ], "name": "transferAccount", "outputs": [], "payable": false, "stateMutability": "nonpayable", "type": "function" },
{ "constant": false, "inputs": [], "name": "lockMinSiteTipPercentage", "outputs": [], "payable": false, "stateMutability": "nonpayable", "type": "function" },
{ "constant": true, "inputs": [], "name": "interfaceInstanceCount", "outputs": [ { "name": "", "type": "uint256" } ], "payable": false, "stateMutability": "view", "type": "function" },
{ "constant": true, "inputs": [], "name": "minSiteTipPercentage", "outputs": [ { "name": "", "type": "uint256" } ], "payable": false, "stateMutability": "view", "type": "function" },
{ "constant": false, "inputs": [ { "name": "newOwner", "type": "address" } ], "name": "transferOwnership", "outputs": [], "payable": false, "stateMutability": "nonpayable", "type": "function" },
{ "constant": true, "inputs": [], "name": "tipPercentageLocked", "outputs": [ { "name": "", "type": "bool" } ], "payable": false, "stateMutability": "view", "type": "function" },
{ "inputs": [], "payable": false, "stateMutability": "nonpayable", "type": "constructor" },
{ "payable": true, "stateMutability": "payable", "type": "fallback" },
{ "anonymous": false, "inputs": [], "name": "PeepethEvent", "type": "event" } ]
"""

}
