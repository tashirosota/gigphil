import React from "react"
import styled from 'styled-components'

export default class XScrollableMVList extends React.Component {
  constructor(props){
    super(props)
    this.state = {
      mvs: this.props.mvs,
      title: this.props.title
    }
  }

  render () {
    const { mvs, title } = this.state
    return (
      <React.Fragment>
        <Title>{title}</Title>
        <MvsContainer>
          {
            mvs.map(
              (mv, index) => {
                return <Mv key={index} src={mv} frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen/>
              })
          }
        </MvsContainer>
      </React.Fragment>
    )
  }
}

const MvsContainer = styled.div`
  display: flex;
  overflow-x: scroll;
  justify-content: flex-start;
  padding: 5px;
`

const Title = styled.h1`
  color: white;
  font-size: 25px;
  margin: 10px 0px;
`
const Mv = styled.iframe`
  border-radius: 10px;
  margin-right: 10px;
  width: 200px;
  margin-bottom: 0px;
`