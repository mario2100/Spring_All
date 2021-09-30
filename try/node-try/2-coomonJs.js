// 逻辑输出到全局变量上 如jQuery $
//全局变量一多
//没有html 怎们办
//CommonJs模块规范
//
var result = require('./3-lib')
//注意引用被覆盖的导出
console.log(result);
//是否为同一引用 是的
result.addition = 'addition'
console.log(result);