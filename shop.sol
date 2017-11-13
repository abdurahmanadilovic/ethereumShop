pragma solidity ^0.4.11;

// 0.000000000000000002 is equal to 2 eth on the remix web ide

contract Ownable {
    address public owner;

    function Ownable() {
        owner = msg.sender;
    }

    modifier onlyOwner {
        if (msg.sender != owner) throw;
        // the _; will be replaced by the actual function body when the modifier is used!
        _;
    }

    function transferOwnership(address newOwner) onlyOwner {
        if (newOwner != address(0)) {
            owner = newOwner;
        }
    }
}

contract Shop is Ownable{
    struct Item {
        uint price;
        address owner;
        bool forSale;
        string name;
    }
    mapping (uint => Item) items;
    mapping (address => uint) coinBank;
    event ItemBought(uint itemId, address to);
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
        if(coinBank[owner] >= coinsBought && ethAmount > 0){
            uint coinsBought = ethAmount * coinValuePerEth;
            coinBank[owner] -= coinsBought;
            coinBank[buyer] += coinsBought;
            success = true;
        }
        else{
            success = false;
        }
    }
    
    function addItem(uint price, address owner, bool forSale, string name) onlyOwner returns (uint itemId) {
        itemId = itemNumber++;
        items[itemId] = Item(price, owner, forSale, name);
    }
    
    function transferItem(uint itemIndex, address newOwner) onlyOwner returns (bool success) {
        Item memory itemToSell = items[itemIndex];
        
        if (itemIndex > itemNumber || coinBank[newOwner] < itemToSell.price || !itemToSell.forSale) {
            success = false;
            return;
        }
        
        coinBank[newOwner] -= itemToSell.price;
        coinBank[itemToSell.owner] += itemToSell.price;
        itemToSell.owner = newOwner;
        items[itemIndex] = itemToSell;
        ItemBought(itemIndex, newOwner);
        success = true;
    }
    
    function coinCount(address account) onlyOwner returns (uint coinCount) {
        coinCount = coinBank[account];
    }
    
    function getItemsForAddress(address owner) onlyOwner returns (uint userItremsCount) {
        uint userItemsCount = 0;
        for (uint i=0; i<itemNumber; i++) {
            if (items[i].owner == owner) {
                userItemsCount++;
            }
        }
        
        return userItemsCount;
    }
}
