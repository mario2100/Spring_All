pragma solidity^0.6.1;

contract array_demo {
    string[5] public names;
    uint256[] public ages;
    constructor() public {
        names[0] = "yekai";
        //names.push("fuhongxue");//can not do this
        ages.push(10);
    }
    function getLength() public view returns(uint256, uint256) {
        return (names.length,ages.length);
    }
}