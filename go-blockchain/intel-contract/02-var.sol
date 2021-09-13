pragma solidity ^0.8.7;
//作者合约
contract vardefine {
    //定义作者年龄
    int256 public AuthAge;
    //定义作者hash
    bytes32 public AuthHash;
    //定义作者姓名
    string public AuthName;
    //定义作者薪水
    uint256 AuthSal;
    //引用传递
    constructor(int256 _age, string memory _name, uint256 _sal) public {
        AuthAge = _age;
        AuthName = _name;
        AuthSal = _sal;
        //byte32定长数组 椭圆曲线算法
        AuthHash = keccak256(abi.encode(AuthAge, AuthName, AuthSal));
    }

}