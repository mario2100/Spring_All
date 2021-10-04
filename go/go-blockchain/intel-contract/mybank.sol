pragma solidity ^0.8.7;

//银行合约案例
contract mybank {
    //记录储户余额
    mapping(address => uint256) public balances;
    //银行账户总余额
    uint256 totalAmount;
    //银行名称
    string public bankName;
    constructor(string memory _name) public {
        bankName = _name;
        totalAmount = 0;
    }

    //存钱
    function inBank() public payable {
        //msg
        require(msg.value > 0, "value must bigger than 0");
        //if fail , rollback ,cost gas
        balances[msg.sender] += msg.value;
        //接收存款
        totalAmount += msg.value;
        //验证成功与否
        require(totalAmount == address(this).balance);
    }

    //转账他行或提现业务
    function outBank(uint256 _amount) public {
        //msg
        require(balances[msg.sender] >= _amount, "balances[msg.sender] must bigger than _amount");
        //if fail , rollback ,cost gas
        balances[msg.sender] -= _amount;
        msg.sender.transfer(_amount);
        totalAmount -= _amount;
        require(totalAmount == address(this).balance);
    }

    //转账
    function transferTo(address _to, uint256 _amount) public {
        require(address(0) != _to, "_to must a valid address");
        require(balances[msg.sender] >= _amount);
        balances[msg.sender] -= _amount;
        balances[_to] += _amount;
        require(totalAmount == address(this).balance);
    }
}