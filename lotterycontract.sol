//SPDX-License-Identifier: MIT

pragma solidity >=0.8.7;

contract lottery{
    //entities- manager,player, and winner
    address public manager;
    address payable[] public players;
    address payable public winner;

    constructor() {
        manager=msg.sender;
    }
    
    function participate() public payable{
        require(msg.value==1 ether, "you need to pay 1 ether only");
        players.push(payable(msg.sender));
    }

   function getbalance() public view returns(uint){
    require(manager==msg.sender,"Access Denied");
    return address(this).balance;
}

   function random() internal view returns(uint){
      return uint(keccak256(abi.encodePacked(block.difficulty,block.timestamp,players.length)));
   }
    function pickwinner() public{
        require(manager==msg.sender, "Acess Denied");
        require(players.length>=3, "Insufficient Players");

        uint r=random();
        uint index = r%players.length;
        winner=players[index];
        winner.transfer(getbalance());
        players= new address payable[](0); //this will initialize the players array back to zero 0

    }

}