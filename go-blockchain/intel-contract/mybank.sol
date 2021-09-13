pragma solidity^0.8.7;

contract mybank{
    mapping(address=>uint256) public balances;
    uint256 totalAmount;//zong jin e 
    string public bankName;
    constructor(string memory _name) public {
        bankName = _name;
        totalAmount = 0;
    }
    function inBank() public payable {
        //msg
        require(msg.value > 0, "value must bigger than 0");//if fail , rollback ,cost gas 
        balances[msg.sender] += msg.value;
        totalAmount += msg.value;
        require(totalAmount == address(this).balance);
    }
    function outBank(uint256 _amount) public  {
        //msg
        require(balances[msg.sender] >= _amount, "balances[msg.sender] must bigger than _amount");//if fail , rollback ,cost gas 
        balances[msg.sender] -= _amount;
        msg.sender.transfer(_amount);
        totalAmount -= _amount;
        require(totalAmount == address(this).balance);
    }
    function transferTo(address _to, uint256 _amount) public {
        require(address(0) != _to, "_to must a valid address");
        require(balances[msg.sender] >= _amount);
        balances[msg.sender] -= _amount;
        balances[_to] += _amount;
        require(totalAmount == address(this).balance);
    }
}