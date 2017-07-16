pragma solidity ^0.4.11;

// creeate own tokens, so that this contract can substract coins from purchasing address
contract Shop{
    struct Item {
        uint price;
        address owner;
        bool forSale;
        string name;
    }
    mapping (uint => Item) items;
    event ItemSoled(uint itemId, address to);
    address owner;
    uint wallet;
    uint itemNumber;

    function Shop(){
        owner = msg.sender;
    }   
    
    function addItem(uint price, address owner, bool forSale, string name) returns (uint itemId) {
        itemId = itemNumber++;
        items[itemId] = Item(price, owner, forSale, name);
    }
    
    function itemCount() returns (uint size){
        return itemNumber;
    }
    
    function transferItem(uint itemId, address newOwner) payable returns (bool success) {
        Item memory itemToSell = items[itemId];
        
        if (itemId >= itemNumber) {
            return false;
        }
        
        if (newOwner.balance >= items[itemId].price) {
            
            items[itemId].owner.transfer(items[itemId].price);
            itemToSell.owner = newOwner;
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
