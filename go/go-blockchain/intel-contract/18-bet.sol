pragma solidity ^0.8.7

//智能博彩
//角色分析
//管理员和玩家
//功能分析
//下注 开奖
contract Bet{
address public owner;//管理者
bool isFinished;//游戏结束标识
struct Player{
address payable addr;
uint amount;
}

Player[] inBig;
Player[] inSmall;
uint totalBig;
uint totalSmall;
uint nowtime;

constructor() public {
owner = msg.sender;
totalBig = 0;
totalSmall = 0;
isFinished = false;
nowtime =now;
}

//下注
function stake(bool flag) public payable returns (bool) {
require(msg.value > 0);
Player memory p = Player(msg.sender, msg.value);
count = _count;
if (flag){
inBig.push(p);
totalBig += p.amount;
}else{
inSmall.push(p);
totalSmall += p.amount;
}
return true;
}

//开奖
function open() payable public returns (bool){
//开奖时间限制
require(now > nowtime + 20);
//游戏还未结束
require(!isFinished);
//0-8 开小 9-17开大
uint points = uint(keccak256(abi.encode(msg.sender,now, block.number))) % 18;
uint i = 0;
Player memory p;
if (points >= 9){
for (i = 0;i < inBig.length;i++){
//退还下大的人本金和奖金
p = inBig[i];
//按比例分配奖金
p.addr.transfer(p.amount + totalSmall * p.amount / totalBig);
}
}else{
for (i = 0;i < inSmall.length;i++){
p = inSmall[i];
//按比例分配奖金
p.addr.transfer(p.amount + totalBig * p.amount / totalSmall);
}
}
//开奖只能开一次
isFinished = true;
return true;
}



}