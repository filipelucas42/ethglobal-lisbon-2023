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
        uint256 timestamp = block.timestamp;
        
        emit debug(msg.sender);
        if(msg.value >= uint(items[itemID].price)) {
            address payable owner = payable(items[itemID].owner);
            items[itemID].buyer = buyer;
            items[itemID].paid = true;
            owner.transfer(msg.value);
        }
    }

    function getAllItems() external view  returns(int[] memory ids, address[] memory owners, int[] memory buyers, bool[] memory payed){
        uint lenght = itemsArray.length;
        address[] memory owenrs_ = new address[](lenght);
        int[] memory buyers_ = new int[](lenght);
        bool[] memory payed_ = new bool[](lenght);
        for(uint256 i=0; i < itemsArray.length; i++) {
            item  memory item_ = items[i];
            owenrs_[i] = item_.owner;
            buyers_[i] = item_.buyer;
            payed_[i] = (item_.paid);
        }
        return (itemsArray, owenrs_, buyers_, payed_);
    }
}