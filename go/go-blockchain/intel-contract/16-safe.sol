pragma solidity ^0.8.7;

import "./SafeMath.sol";

contract safe_demo {
    using SafeMath for uint256;
    uint256 amount;
    constructor() public {
        //
        amount.add(10);
    }
}