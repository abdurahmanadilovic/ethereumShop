pragma solidity ^0.4.11;

contract Shop{
    struct Item {
        uint price;
        address owner;
        bool forSale;
    }

    mapping (uint => Item) items;

    address owner;
    uint wallet;
    uint itemNumber;
    // event ItemSoled(Item item, Shop to);
    // event ItemBought(Item item, Shop from);
    
    function Shop(){
        owner = msg.sender;
    }   
    
    function addItem(uint price, address owner, bool forSale) returns (uint itemId){
        itemId = itemNumber++;
        items[itemId] = Item(price, owner, forSale);
    }
    
    function itemCount() returns (uint size){
        return itemNumber;
    }
    
    function transferItem(uint itemId, address newOwner) payable returns (bool success) {
        Item memory itemToSell = items[itemId];
        
        
        itemToSell.owner = newOwner;
        
        // ItemSoled(itemToSell, to);
        
        return true;
    }
    
    function getItemsForOwner(address owner) returns (uint userItremsCount){
        uint userItemsCount = 0;
        for (uint i=0; i<itemNumber; i++){
            if(items[i].owner == owner){
                userItemsCount++;
            }
        }
        
        return userItemsCount;
    }
}
