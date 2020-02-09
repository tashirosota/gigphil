import React from "react"
import styled from 'styled-components'
import { IoIosClose, IoIosMenu } from "react-icons/io";

export default class Menu extends React.Component {
  constructor(props){
    super(props)
    this.state = {
      visiable: false,
      userID: this.props.userId,
      userName: 'chao____' || this.props.userName
    }

    this.close = this.close.bind(this) 
    this.open = this.open.bind(this) 
  }

  open(){
    this.setState({ visiable: true })
  }

  close(){
    this.setState({ visiable: false })
  }

  render () {
    const { visiable, userID, userName } = this.state
    return (
      <React.Fragment>  
        <MenuHeader>
          <Logo alt="Gigphil | ライブ好きのための検索アプリ @" src="/assets/logo.png"/>
          <OpenButton onClick={this.open}><IoIosMenu/></OpenButton>
        </MenuHeader>
        <Background style={{display: visiable ? 'flex' : 'none'}}>
          <CloseButton onClick={this.close}><IoIosClose/></CloseButton>
          <ItemArea>
            <Item><a className="text-white" href="/searcher">ライブ検索</a></Item>
            <Item><a className="text-white" href="/TT">タイムテーブルジェネレータ</a></Item>
            { userID ? <Item><a className="text-white" href={`/time_tables`}>タイムテーブル管理</a></Item> : '' }
            {
              userID ? <Logout>
                  <a className="text-white" href='/sessions' data-method="delete">ログアウト（{userName}）</a>
                </Logout>:<Login>
                  <a className="text-white" href='/auth/twitter' >ログイン(with Twitter)</a>
                  <LoginDescription>※ログインによりTTの保存や、<br/>シェア機能が使えるようになります。</LoginDescription>
                </Login>
            }
            <Item><a className="text-white" href="mailto:g4160hc@gmail.com">お問い合わせ</a></Item>
          </ItemArea>
        </Background>
      </React.Fragment>
    )
  }
}

const UserName = styled.div`

`

const Logo = styled.img`
  max-width: 155px;
  max-height: 161px;
  margin-left: 12px;
  margin-top: 7px;
  display: block;
`

const MenuHeader = styled.div`
  position: fixed;
  top: 0px;
  height: 55px;
  width: 100%;
  background: #000000ad;
  display: block;
  z-index: 10;
`

const OpenButton = styled.button`
  z-index: 10;
  position: fixed;
  top: -15px;
  right: 50px;
  width: auto;
  height: 60px;
  background: none;
  font-size: 50px;
  border: none;
  color: white;
  @media (max-width: 576px){
    right: 10px;
  }
  
`

const Background = styled.div`
  position: fixed;
  width: 100%;
  height: 100%;
  top: 0px;
  background: #383838de;
  z-index: 10;
  justify-content: center;
`

const CloseButton = styled.button`
  position: fixed;
  top: 20px;
  right: 50px;
  width: 50px;
  height: 50px;
  background: none;
  font-size: 50px;
  border: none;
  color: white;
`

const ItemArea = styled.ul`
  padding: 20px;
  margin-top: 130px;
  left; 20px;
  text-align: center !important;
`

const Item = styled.li`
  list-style-type: none;
  font-size: 20px;
  margin-bottom: 20px;
  color: white
`

const Login = styled.li`
  list-style-type: none;
  font-size: 20px;
  margin-bottom: 15px;
  color: white
`

const LoginDescription = styled.div`
  color: #ff7777;
  font-size: 15px;
  margin-top: 5px;
`

const Logout = styled.li`
  list-style-type: none;
  font-size: 20px;
  margin-bottom: 15px;
  color: white
`
