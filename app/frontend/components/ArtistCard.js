import React from "react"
import styled from 'styled-components'
import swal from 'sweetalert';
import axios from "axios";
import { IoIosClose, IoIosMenu } from "react-icons/io";

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
          <Area>{artist.area}</Area>
          <TagList>
            {
              artist.tags.map(
                (tag, index) => {
                  return <Tag key={index}>{tag}</Tag>
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
  margin-top: 100px;
  display: block;
  background: black;
  height: 230px;
  width: 170px;
  color: white;
  border-radius: 10px;
  p {
    margin: 0px;
   }
`

const Icon = styled.img`
  width: auto;
  max-height: 120px;
  padding: 8px;
`

const Name = styled.div`
  font-size: 15px;
  text-overflow: ellipsis;
  white-space: nowrap;
  overflow: hidden;
  padding: 0px 5px;
`

const Area = styled.div`
  font-size: 10px;
  background: gray;
  width: fit-content;
  padding: 2px;
  margin-left: 10px; 
  border-radius: 6px;
  margin: 8px 10px;
`

const TagList = styled.div`
  display: flex;
  flex-wrap: wrap;
  padding: 0px 10px;
`

const Tag = styled.div`
  font-size: 10px;
  background: gray;
  width: fit-content;
  padding: 2px;
  border-radius: 6px;
  margin-right: 5px;
  margin-bottom: 5px;
`