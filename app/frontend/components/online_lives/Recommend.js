import React from "react"
import styled from 'styled-components'
import { IoIosAddCircleOutline } from "react-icons/io";


export default class Recommend extends React.Component {
  constructor(props){
    super(props)
    this.state = {
      didLogined: this.props.didLogined
    }
  }

  render () {
    const { didLogined } = this.state
    return (
      <React.Fragment> 
        {
          didLogined ? <AddLive href='/online_lives/new'><IoIosAddCircleOutline/></AddLive> : <Login href='/auth/twitter'>twitterでログイン！<br/>配信ライブ情報を<br/>登録しよう！</Login>
        }
        
      </React.Fragment>
    )
  }
}

const AddLive= styled.a`
  position: fixed;
  height: 60px;
  width: 60px;
  z-index: 10;
  border-radius: 51px;
  text-align: center;
  bottom: 19px;
  right: 19px;
  color: white;
  background: gray;
  font-size: 55px;
  svg {
    overflow: hidden;
    margin-bottom: 35px;
  }
  :hover {
    color: white;
    text-decoration: underline;
  }
`

const Login = styled.a`
  margin: 0px 35px;
  position: fixed;
  padding: 20px;
  height: 135px;
  font-size: 1.5rem;
  z-index: 5;
  border-radius: 10px;
  bottom: 40px;
  padding-top: 15px;
  left: 0px;
  right: 0px;
  color: white;
  background: #131313ad;
  :hover {
    color: white;
    text-decoration: underline;
  }
`