pragma solidity^0.8.7;

contract localobj {
    address public admin;
    bytes32 public hash;
    uint256 public randnum;
    //内建对象
    //block
    //msg
    constructor() public {
        admin = msg.sender;
        hash = blockhash(0);
        randnum = uint256(keccak256(abi.encode(now, msg.sender, hash))) % 100;
    }
}