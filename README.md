# Crypto MarketPlace

This projects aims to create a proof of concept of a MarketPlace that runs on web3.

Similar to Amazon but instead of using the traditional payment system to verify transactions,
it uses the blockchain to verify who bought the items.

All items info are stored in a smart contract, storing the following information:
* price
* title
* description
* image url
* paid status
* seller address
* buyer identifier (example: email)

In this proof of concept we do not tackle privacy issues, in this version of the
project we just ask for the buyers email to be stored on the blockchain to be associated 
with the purchased item. A next iteration would for example encrypt the email with a public
key before going to the blockchain, then the MarketPlace team would decrypt it with a private key.

Crypto TechStakk:
* [MetaMask SDK](https://metamask.io/sdk/)
* [Linea](https://linea.build/)

## Smart Contract
The smart contract developed for this POC has the following methods:

```
// gets the items stored in the smart contract
function getAllItems() external view  returns(int[] memory ids, address[] memory sellers, bool[] memory payed, int[] memory prices, string[] memory buyers, string[] memory titles, string[] memory descriptions, string[] memory URLImages)

// pay for the item storing the relation between the email and the item id
function pay(uint itemID, string memory buyer) public payable

// putting an item to sell with the item info
function storeItem(int price, address seller, string memory title, string memory description, string memory URLImage) public
```
