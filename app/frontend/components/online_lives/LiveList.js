import React from "react"
import styled from 'styled-components'
import LiveCard from './LiveCard'

export default class LiveList extends React.Component {
  constructor(props){
    super(props)
    this.state = {
      lives: this.props.lives,
      title: this.props.title,
      current_user_id: this.props.current_user_id
    }
  }

  render () {
    const { lives, title, current_user_id } = this.state
    return (
      <React.Fragment>
        <Title>{title}</Title>
        <LivesContainer>
          {
            lives.length == 0 ? <Title>該当の配信ライブは見つかりませんでした。</Title> : lives.map(
              (live, index) => {
                return <LiveCard key={index} live={live} current_user_id={current_user_id}/>
              })
          }
        </LivesContainer>
      </React.Fragment>
    )
  }
}

const LivesContainer = styled.div`
  display: flex;
  flex-wrap: wrap;
  justify-content: center;
  @media (min-width: 576px){
    justify-content: space-between;
  }
`

const Title = styled.h1`
  color: white;
  font-size: 1.5rem;
  margin-top: 10px;
  margin-bottom: 10px;
`