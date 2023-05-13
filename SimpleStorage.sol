// SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;

contract SimpleStorage {
    event debug(address addr);

    struct item { 
        int price;
        address  owner;
        string buyer;
        bool paid;
        string title;
        string description;
        string URLImage;
    }

    int[] itemsArray;
    mapping(uint => item) public items;

    function storeItem(int price, address owner, string memory title, string memory description, string memory URLImage) public {
        uint itemID = itemsArray.length;
        itemsArray.push(int(itemsArray.length));
        items[itemID] = item({price:price, owner:owner, paid:false, buyer:"", title: title, description: description, URLImage:URLImage});
    }

    function getItem(uint itemID) external view returns (int price, address owner, string memory buyer, bool paid, string memory title, string memory description, string memory URLImage){
        return (items[itemID].price, items[itemID].owner, items[itemID].buyer, items[itemID].paid, items[itemID].title, items[itemID].description, items[itemID].URLImage);
    }

    function pay(uint itemID, string memory buyer) public payable {
        //uint256 timestamp = block.timestamp;
        
        emit debug(msg.sender);
        if(msg.value >= uint(items[itemID].price)) {
            address payable owner = payable(items[itemID].owner);
            items[itemID].buyer = buyer;
            items[itemID].paid = true;
            owner.transfer(msg.value);
        }
    }

    function getAllItems() external view  returns(int[] memory ids, address[] memory owners, bool[] memory payed, int[] memory prices, string[] memory buyers, string[] memory titles, string[] memory descriptions, string[] memory URLImages){
        uint lenght = itemsArray.length;
        address[] memory owners_ = new address[](lenght);
        string[] memory buyers_ = new string[](lenght);
        bool[] memory payed_ = new bool[](lenght);
        int[] memory prices_ = new int[](lenght);
        string[] memory titles_ = new string[](lenght);
        string[] memory descriptions_ = new string[](lenght);
        string[] memory URLImages_ = new string[](lenght);
        for(uint256 i=0; i < itemsArray.length; i++) {
            item  memory item_ = items[i];
            owners_[i] = item_.owner;
            buyers_[i] = item_.buyer;
            payed_[i] = (item_.paid);
            prices_[i] = (item_.price);
            titles_[i] = (item_.title);
            descriptions_[i] = item_.description;
            URLImages_[i] = item_.URLImage;
        }
        return (itemsArray, owners, payed_, prices_ , buyers_, titles_, descriptions_, URLImages_);
    }
}