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
                return <Mv key={index}>
                    <Src src={mv.url} frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen/>
                    <ArtistName>{mv.artistName}</ArtistName>
                  </Mv>
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
const Mv = styled.div`
  width: 200px;
  margin-right: 10px;
`

const Src = styled.iframe`
  width: 200px;
  border-radius: 10px;
  margin-bottom: 0px;
`

const ArtistName = styled.p`
  color: white;
  text-align: center;
`