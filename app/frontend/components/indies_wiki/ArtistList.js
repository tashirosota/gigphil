import React from "react"
import styled from 'styled-components'
import ArtiscCard from './ArtistCard'

export default class ArtistList extends React.Component {
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
            artists.length == 0 ? <Title>該当のアーティストは見つかりませんでした。</Title> : artists.map(
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
  flex-wrap: wrap;
  justify-content: center;
  @media (min-width: 576px){
    justify-content: left;
  }
`

const Title = styled.h1`
  color: white;
  font-size: 25px;
  margin-top: 10px;
  margin-bottom: 5px;
`