/**
 * 章节: 06-07
 * 演示 View、Image、TextInput 组件的综合使用
 * FilePath: /06-07/TextInputComponent/signup/index.js
 * @Parry
 */

import React, {Component} from 'react'
import {
  AppRegistry,
  StyleSheet,
  Text,
  View,
  Image,
  TextInput,
  TouchableOpacity,
  TouchableHighlight
} from 'react-native'

//导入一些使用到的图片资源，从本地加载。
const background = require("./signup_bg.png");
const backIcon = require("./back.png");
const personIcon = require("./signup_person.png");
const lockIcon = require("./signup_lock.png");
const emailIcon = require("./signup_email.png");
const birthdayIcon = require("./signup_birthday.png");

export default class SignupVriew extends Component {
  render() {
    return (
      <View style={styles.container}>
        <Image
          source={background}
          style={[styles.container, styles.bg]} //加载多个样式的写法
          //图片的缩放方式
          resizeMode="cover">                   
          <View style={styles.headerContainer}>

            <View style={styles.headerIconView}>
              <TouchableOpacity style={styles.headerBackButtonView}> 
                <Image source={backIcon} style={styles.backButtonIcon} resizeMode="contain"/>
              </TouchableOpacity>
            </View>

            <View style={styles.headerTitleView}>
              <Text style={styles.titleViewText}>注册</Text>
            </View>

          </View>

          <View style={styles.inputsContainer}>

            <View style={styles.inputContainer}>
              <View style={styles.iconContainer}>
                <Image source={personIcon} style={styles.inputIcon} resizeMode="contain"/>
              </View>
              <TextInput
                style={[styles.input, styles.whiteFont]}
                placeholder="用户名" //占位提示文字
                placeholderTextColor="#FFF" //占位提示文字的颜色
                underlineColorAndroid='transparent'/>
            </View>

            <View style={styles.inputContainer}>
              <View style={styles.iconContainer}>
                <Image source={emailIcon} style={styles.inputIcon} resizeMode="contain"/>
              </View>
              <TextInput
                style={[styles.input, styles.whiteFont]}
                placeholder="邮箱"
                placeholderTextColor="#FFF"/>
            </View>

            <View style={styles.inputContainer}>
              <View style={styles.iconContainer}>
                <Image source={lockIcon} style={styles.inputIcon} resizeMode="contain"/>
              </View>
              <TextInput
                secureTextEntry={true}
                style={[styles.input, styles.whiteFont]}
                placeholder="密码"
                placeholderTextColor="#FFF"/>
            </View>

          </View>

          <View style={styles.footerContainer}>

            <TouchableHighlight onPress={this.login.bind(this)}>
              <View style={styles.signup}>
                <Text style={styles.whiteFont}>注 册</Text>
              </View>
            </TouchableHighlight>

            <TouchableOpacity>
              <View style={styles.signin}>
                <Text style={styles.greyFont}>已有账号？<Text style={styles.whiteFont}>
                    登录</Text>
                </Text>
              </View>
            </TouchableOpacity>
          </View>
        </Image>
      </View>
    );
  }

  login() {
    //这里可以添加你的登录逻辑
    console.log("开始模拟登陆...");
  }
}

//如下特别贴出了详细的样式定义，供你学习完整页面样式控制的写法
let styles = StyleSheet.create({
  container: {
    flex: 1
  },
  bg: {
    paddingTop: 30,
    width: null,
    height: null
  },
  headerContainer: {
    flex: 1
  },
  inputsContainer: {
    flex: 3,
    marginTop: 50
  },
  footerContainer: {
    flex: 1
  },
  headerIconView: {
    marginLeft: 10,
    backgroundColor: 'transparent'
  },
  headerBackButtonView: {
    width: 25,
    height: 25
  },
  backButtonIcon: {
    width: 25,
    height: 25
  },
  headerTitleView: {
    backgroundColor: 'transparent',
    marginTop: 25,
    marginLeft: 25
  },
  titleViewText: {
    fontSize: 40,
    color: '#fff'
  },
  inputs: {
    paddingVertical: 20
  },
  inputContainer: {
    borderWidth: 1,
    borderBottomColor: '#CCC',
    borderColor: 'transparent',
    flexDirection: 'row',
    height: 75
  },
  iconContainer: {
    paddingHorizontal: 15,
    justifyContent: 'center',
    alignItems: 'center'
  },
  inputIcon: {
    width: 30,
    height: 30
  },
  input: {
    flex: 1,
    fontSize: 20
  },
  signup: {
    backgroundColor: '#FF3366',
    paddingVertical: 25,
    alignItems: 'center',
    justifyContent: 'center',
    marginBottom: 15
  },
  signin: {
    justifyContent: 'center',
    alignItems: 'center',
    backgroundColor: 'transparent'
  },
  greyFont: {
    color: '#D8D8D8'
  },
  whiteFont: {
    color: '#FFF'
  }
})
