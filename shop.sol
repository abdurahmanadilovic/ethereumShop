pragma solidity ^0.4.0;

contract Item{
    uint public price;
    bool public forSale;
    address public owner;
    
    function Item(uint itemPrice, address initialOwner){
        price = itemPrice;
        owner = initialOwner;
    }    
    
    function changeOwner(address newOwner){
        owner = newOwner;
    }
    
}

contract Shop{
    Item[] items;
    address owner;
    uint wallet;
    
    event ItemSoled(Item item, Shop to);
    event ItemBought(Item item, Shop from);
    
    function Shop(){
        owner = msg.sender;
    }   
    
    function addItem(Item item){
        items.push(item);
    }
    
    function itemCount() returns (uint size){
        return items.length;
    }
    
    function transferItem(uint itemIndex, Shop to, address newOwner) payable returns (bool success) {
        Item itemToSell = items[itemIndex];
        
        to.addItem(items[itemIndex]);
        
        delete items[itemIndex];
        
        itemToSell.changeOwner(newOwner);
        
        ItemSoled(itemToSell, to);
        
        return true;
    }
}
