import React from "react"
import styled from 'styled-components'

export default class LoginRecommend extends React.Component {
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
          didLogined ? '' : <Login href='/auth/twitter'>twitterでログイン！<br/>アーティストを登録しよう！</Login>
        }
        
      </React.Fragment>
    )
  }
}

const Login = styled.a`
  position: fixed;
  padding: 20px;
  height: 100px;
  font-size: 1.5rem;
  z-index: 5;
  border-radius: 10px;
  bottom: 40px;
  left: 0px;
  right: 0px;
  color: white;
  background: #000000ad;
  :hover {
    color: white;
    text-decoration: underline;
  }
`