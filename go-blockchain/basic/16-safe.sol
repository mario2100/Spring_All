pragma solidity^0.6.0;

import "./SafeMath.sol";

contract safe_demo {
    using SafeMath for uint256;
    uint256 amount;
    constructor() public {
        //
        amount.add(10);
    }
}