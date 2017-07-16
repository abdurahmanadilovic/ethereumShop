pragma solidity ^0.4.11;

// 0.000000000000000002 is equal to 2 eth on the remix web ide

contract Shop{
    struct Item {
        uint price;
        address owner;
        bool forSale;
        string name;
    }
    mapping (uint => Item) items;
    mapping (address => uint) coinBank;
    event ItemSoled(uint itemId, address to);
    address owner;
    uint wallet;
    uint itemNumber;
    uint totalCoins = 600000;
    uint coinValuePerEth = 6000;
    
    function Shop(){
        owner = msg.sender;
        coinBank[owner] = totalCoins;
    }   
    
    function buyCoin() payable returns (bool success){
        uint ethAmount = msg.value;
        address buyer = msg.sender;
        uint coinsBought = ethAmount * coinValuePerEth;
        
        if(coinBank[owner] >= coinsBought){
            coinBank[owner] -= coinsBought;
            coinBank[buyer] += coinsBought;
            success = true;
        }
        else{
            success = false;
        }
    }
    
    function addItem(uint price, address owner, bool forSale, string name) returns (uint itemId) {
        itemId = itemNumber++;
        items[itemId] = Item(price, owner, forSale, name);
    }
    
    function transferItem(uint itemId, address newOwner) returns (bool success) {
        Item memory itemToSell = items[itemId];
        
        if (itemId >= itemNumber) {
            return false;
        }
        
        if (coinBank[newOwner] >= items[itemId].price) {
            coinBank[newOwner] -= items[itemId].price;
            coinBank[itemToSell.owner] += items[itemId].price;
            items[itemId].owner = newOwner;
            ItemSoled(itemId, newOwner);
            
            return true;
        } else {
            return false;
        }
    }
    
    function getItemsForOwner(address owner) returns (uint userItremsCount) {
        uint userItemsCount = 0;
        for (uint i=0; i<itemNumber; i++) {
            if (items[i].owner == owner) {
                userItemsCount++;
            }
        }
        
        return userItemsCount;
    }
}
