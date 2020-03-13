import React from "react"
import styled from 'styled-components'
import ArtiscCard from './ArtistCard'

export default class XScrollableArtistList extends React.Component {
  constructor(props){
    super(props)
    this.state = {
      artists: this.props.artists,
      title: this.props.title
    }
  }

  render () {
    const { artists, title } = this.state
    return (
      <React.Fragment>
        <Title>{title}</Title>
        <ArtistsContainer>
          {
            artists.map(
              (artist, index) => {
                return <ArtiscCard key={index} artist={artist}/>
              })
          }
        </ArtistsContainer>
      </React.Fragment>
    )
  }
}

const ArtistsContainer = styled.div`
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