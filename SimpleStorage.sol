// SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;

contract SimpleStorage {
    event debug(address addr);

    struct item { 
        int price;
        address  owner;
        int buyer;
        bool paid;
    }

    int[] itemsArray;
    mapping(uint => item) public items;

    function storeItem(int price, address owner) public {
        uint itemID = itemsArray.length;
        itemsArray.push(int(itemsArray.length));
        items[itemID] = item({price:price, owner:owner, paid:false, buyer:0});
    }

    function getItem(uint itemID) external view returns (int price, address owner, int userID, bool paid){
        return (items[itemID].price, items[itemID].owner, items[itemID].buyer, items[itemID].paid);
    }

    function pay(uint itemID, int buyer) public payable {
        
        emit debug(msg.sender);
        if(msg.value >= uint(items[itemID].price)) {
            address payable owner = payable(items[itemID].owner);
            items[itemID].buyer = buyer;
            items[itemID].paid = true;
            owner.transfer(msg.value);
        }
    }


}