import React from "react"
import styled from 'styled-components'
import { IoIosClose, IoIosMenu } from "react-icons/io";

export default class Menu extends React.Component {
  constructor(props){
    super(props)
    this.state = {
      visiable: false,
      current_user: this.props.current_user
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
    const { visiable, current_user } = this.state
    return (
      <React.Fragment>  
        <MenuHeader>
          <Logo alt="Gigphil | ライブ好きのための検索アプリ @" src="/assets/logo.png"/>
          <ToTop href='/'/>
          <Icon src={current_user.icon_url}/>
          <OpenButton onClick={this.open}><IoIosMenu/></OpenButton>
        </MenuHeader>
        <Background style={{display: visiable ? 'flex' : 'none'}}>
          <CloseButton onClick={this.close}><IoIosClose/></CloseButton>
          <ItemArea>
            <Item><a className="text-white" href="/indies_wiki">インディーズwiki(β版)</a></Item>
            {/* { current_user.id ? <Item><a className="text-white" href="/indies_wiki/favorites">お気に入り</a></Item> : '' } */}
            <Item><a className="text-white" href="/searcher">ライブ検索</a></Item>
            <Item><a className="text-white" href="/TT">タイムテーブルジェネレータ</a></Item>
            { current_user.id ? <Item><a className="text-white" href={`/time_tables`}>タイムテーブル管理</a></Item> : '' }
            {
              current_user.id ? <Logout>
                  <a className="text-white" href='/sessions' data-method="delete">ログアウト（{current_user.name}）</a>
                </Logout>:<Login>
                  <a className="text-white" href='/auth/twitter' >ログイン(with Twitter)</a>
                  <LoginDescription>※ログインすることにより、<br/>各種機能が開放されます。</LoginDescription>
                </Login>
            }
            <Item><a className="text-white" href="mailto:g4160hc@gmail.com">お問い合わせ</a></Item>
          </ItemArea>
        </Background>
      </React.Fragment>
    )
  }
}

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

const Icon = styled.img`
  z-index: 10;
  position: fixed;
  padding: 0px;
  top: 8px;
  right: 80px;
  width: auto;
  height: 39px;
  background: none;
  font-size: 50px;
  border: none;
  color: white;
  border-radius: 100px;
  @media (max-width: 576px){
    right: 62px;
  }
`

const OpenButton = styled.button`
  z-index: 10;
  position: fixed;
  padding: 0px;
  top: -12px;
  right: 21px;
  width: auto;
  height: 41px;
  background: none;
  font-size: 45px;
  border: none;
  color: white;
  @media (max-width: 576px){
    right: 4px;
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
const ToTop = styled.a`
  position: absolute;
  top: 0;
  left: 0;
  width: 180px;
  bottom: 0;
  margin: auto;
`