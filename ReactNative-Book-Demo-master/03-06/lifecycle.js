/**
* 章节: 03-06
* React Native 中的生命周期
* FilePath: /03-06/lifecycle.js
* @Parry
*/

import React, { Component } from 'react';
import { AppRegistry,View,Text } from 'react-native';
 
/**
 * 虚拟Dom的生命周期
 * 初始化：setup porps and state
 * 加载：componentWillMount reder componentDidMount
 * 更新：props --- componetWillRecieveProps shouldComponentUpdate(性能优化很重要 减少不必要的UI更新)  componentWillUpdate  render componentDidUpdate 
 * state --- shouldComponentUpdate  componentWillUpdate  render componentDidUpdate 
 * 卸载:componentWillUnmount
 * 
 */
export default class LifeCycle extends Component {

  constructor(props) {
    super(props);
    this.state = {
        name: "React"
    }
  }
 
  //组件即将加载
  componentWillMount() {
    console.log("componentWillMount");
  }
 
  //开始组件渲染
  render() {
    console.log("render");
    return (
      <View>
        <Text>
          {this.state.name}
        </Text>
      </View>
    );
  }
 
  //组件加载完毕后
  componentDidMount() {
    console.log("componentDidMount");
  }
 
  //组件接收到新的 props
  componentWillReceiveProps(nextProps) {
    console.log("componentWillReceiveProps");
  }
 
  //逻辑控制是否需要更新组件
  shouldComponentUpdate(nextProps, nextState) {
    console.log("shouldComponentUpdate");
  }
 
  //组件即将更新重新渲染
  componentWillUpdate(nextProps, nextState) {
    console.log("componentWillUpdate");
  }
 
  //组件重新渲染后
  componentDidUpdate(prevProps, prevState) {
    console.log("componentDidUpdate");
  }
 
  //组件卸载注销前
  componentWillUnmount() {
    console.log("componentWillUnmount");
  }
}
 
AppRegistry.registerComponent('LifeCycle', () => Main);