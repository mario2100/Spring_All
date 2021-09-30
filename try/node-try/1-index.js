// node 全局变量 剪刀石头布游戏
// console.log(process.argv);
var length = process.argv.length;
var playerAction = process.argv[length - 1];
console.log('你出：' + playerAction);
var radom = Math.random() * 3;
if (radom < 1) {
    var pcAction = 'rock'
} else if (radom > 2) {
    var pcAction = 'scissor'
} else {
    var pcAction = 'cloth'
}
console.log('电脑出：' + pcAction);

if (pcAction == playerAction) {
    console.log('平局');
} else if ((pcAction == 'rock' && playerAction == 'cloth') ||
    (pcAction == 'scissor' && playerAction == 'rock') ||
    (pcAction == 'cloth' && playerAction == 'scissorn')) {
    console.log('你赢了');
} else {
    console.log('你输了');
}

