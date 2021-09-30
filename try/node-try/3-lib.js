console.log('lib 1234')
exports.hello = 'hello world'
exports.add = function (a, b) {
    return a + b;
}
//覆盖
module.exports = function (a, b) {
    return a - b;
}

setTimeout(() => {
    console.log(exports)
}, 2000)
