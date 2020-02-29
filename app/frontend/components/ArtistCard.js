import React from "react"
import styled from 'styled-components'

export default class ArtistCard extends React.Component {
  constructor(props){
    super(props)
    this.state = {
      artist: this.props.artist
    }
  }

  render () {
    const { artist } = this.state
    return (
      <React.Fragment>  
        <Card>
          <Icon  alt={artist.name} src={artist.icon}/>
          <Name>{artist.name}</Name>
          <TagList>
            <Area>#{artist.area}</Area>
            {
              artist.tags.map(
                (tag, index) => {
                  return <Tag key={index}>#{tag}</Tag>
                })
            }
          </TagList>
        </Card>
       </React.Fragment>
    )
  }
}

const Card = styled.div`
  text-align: center;
  display: block;
  background: #dadada;
  height: 222px;
  width: 160px;
  color: black;
  border-radius: 10px;
  box-shadow: 2px 2px 4px black;
  margin: 5px auto 10px 6px;
  p {
    margin: 0px;
   }
`

const Icon = styled.img`
  border-radius: 20px;
  width: auto;
  max-height: 114px;
  max-width: 163px;
  padding: 8px;
`

const Name = styled.div`
  font-size: 15px;
  text-overflow: ellipsis;
  white-space: nowrap;
  overflow: hidden;
  padding: 0px 5px;
  margin-bottom: 10px;
`

const Area = styled.div`
  font-size: 8px;
  background: #f35f04;
  width: fit-content;
  padding: 2px 7px;
  border-radius: 6px;
  margin-right: 5px;
  margin-bottom: 5px;
  color: white;
  box-shadow: 1px 1px 4px grey;
`
const Tag = styled.div`
  font-size: 8px;
  background: white;
  width: fit-content;
  padding: 2px 7px;
  border-radius: 6px;
  margin-right: 5px;
  margin-bottom: 5px;
  box-shadow: 1px 1px 4px grey;
  text-overflow: ellipsis;
  white-space: nowrap;
  overflow: hidden;
  max-width: 82px;
`

const TagList = styled.div`
  display: flex;
  flex-wrap: wrap;
  padding: 0px 10px;
`