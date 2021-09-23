/**
 * 章节: 01-01-02
 * index.js 定义了 React 项目的入口
 * FilePath: /01-01-02/index.js
 * @Parry
 */

/**
 * React:
 * 解决Model与View有数据流动时可能会出现双向的数据流动
 * 减少直接操作dom的昂贵花费
 * 单向数据流
 * 
 * RN：
 * html5体验差于rn
 * 减少开发成本 一套代码部署多个移动平台
 * 热更新：main.bundle.js
 * 
 * 
 * nodejs:
 * 事件驱动、非阻塞式IO
 * 
 * 
 * watchman 
 * 
 * react-native init project-name
 * 
 * 直接适配好了iphone x
 * 
 * 生成的app完美适配iOS 和 Andoid 两个平台
 * 
 * bridge
 * 
 */

var React = require('react');
var ReactDOM = require('react-dom');
import BodyIndex from './components/bodyindex';
//父组件
class Index extends React.Component {

	//生命周期函数 componentWillMount，组件即将加载
	componentWillMount(){
		console.log("Index - componentWillMount");
	}

	//生命周期函数 componentDidMount，组件加载完毕
	componentDidMount(){
		console.log("Index - componentDidMount");
	}

	//页面表现组件渲染
	render() {
		return (
			<div>
				//子组件
				<BodyIndex id={1234567890} name={"IndexPage"}/>
			</div>
		);
	}
}

ReactDOM.render(<Index/>, document.getElementById('example'));