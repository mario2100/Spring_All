pragma solidity^0.8.7;

//合约
contract func_demo {
    address public admin;
    constructor() public {
        admin = msg.sender;
    }

    //修饰符
    function deposit() public payable {
        //nothing to do
    }
    function getBalance() public view returns (uint256) {
        return address(this).balance;
    }
}