import React from "react"
import styled from 'styled-components'
import { IoLogoTwitter, IoIosHome, IoIosStarOutline, IoIosCheckmarkCircleOutline, IoMdShare } from "react-icons/io";
import { FaEdit } from "react-icons/fa";

export default class ArtistDetail extends React.Component {
  constructor(props){
    super(props)
    this.state = {
      artist: this.props.artist,
      didLogined: this.props.didLogined
    }
  }

  render () {
    const { artist, didLogined } = this.state
    return (
      <React.Fragment> 
        <Detail>
         <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>
          <Icon alt={artist.name} src={artist.icon}/> 
          <SNSItems>
            { artist.hp ? <SNSItem href={artist.hp}><IoIosHome/></SNSItem> : ''}
            { artist.twitter ? <SNSItem href={artist.twitter}><IoLogoTwitter/></SNSItem> : ''}
            {/* {
              artist.is_favorite ? <AddButton><IoIosCheckmarkCircleOutline/></AddButton> : <AddButton><IoIosStarOutline/></AddButton>
            } */}
            {
              didLogined ? <SNSItem href={`/indies_wiki/artists/${artist.id}/edit`}><FaEdit/></SNSItem> : ''
            }
            <SNSItem href={encodeURI(`https://twitter.com/intent/tweet?url=${location.href}&text=${artist.name} | Gigphil`)} data-show-count="false"><IoMdShare/></SNSItem>
          </SNSItems>
          <Name>{artist.name}</Name>
          <Description>{artist.description}</Description>
          <TagList>
            <Area href={`/indies_wiki/artists?selected_area=${artist.area}`}>#{artist.area}</Area>
            {
              artist.tags.map(
                (tag, index) => {
                  return <Tag key={index} href={`/indies_wiki/artists?tags=${tag}`}>#{tag}</Tag>
                })
            }
          </TagList>
          {
            artist.sounds.length === 0 ? '' : <div>
              <ListTitle>Sounds</ListTitle>
              <Items>
                {
                  artist.sounds.map(
                    (sound, index) => {
                      return <SoundItem key={index} href={sound.url}>・{sound.title}</SoundItem>
                    })
                }
              </Items>
            </div>
          }
          {/* comments0の時は飛ぶリンクを出してあげる */}
          {
            artist.comments.length === 0 ? '' : <div>
              <TitleArea>
                <ListTitle>Forum</ListTitle>
                <AndMore href={`/indies_wiki/artists/${artist.id}/forum/comments`}>もっと見る ></AndMore>
              </TitleArea>
              <Items>
                {
                  artist.comments.map(
                    (comment, index) => {
                      return <Item key={index}>{comment}</Item>
                    })
                }
              </Items>
            </div>
          }
          {
            artist.histories.length === 0 ? '' : <div>
              <ListTitle>Histories</ListTitle>
              <Items>
                {
                  artist.histories.map(
                    (history, index) => {
                      return <Item key={index}>{history}</Item>
                    })
                }
              </Items>
            </div>
          }

        </Detail>  
      </React.Fragment>
    )
  }
}

const Detail = styled.div`
  text-align: center;
  margin: 0px auto;
  width: autpo;
`

const Icon = styled.img`
  border-radius: 10px;
  width: auto;
  max-height: 240px;
  max-width: 340px;
  margin-bottom: 0px;
`

const Name = styled.h1`
  text-align: center;
  color: white;
  font-size: 1.5rem;
  margin: 20px 5px;
`
const Description = styled.h2`
  color: white;
  font-size: 1.3rem;
  text-align: left;
`

const SNSItems = styled.ul`
  display: flex;
  justify-content: flex-end;
  margin: 0px;
`

const SNSItem = styled.a`
  font-size: 30px;
  margin: 0px 10px;
  color: white;
  padding: 0px
`

const AddButton = styled.button`
  font-size: 30px;
  margin: 0px 5px;
  padding: 0px;
  color: white;
  background: no-repeat;
  border: none;
}
`

const TagList = styled.ul`
  display: flex;
  flex-wrap: wrap;
  margin: 15px 0px;
  padding: 0px;
`

const Area = styled.a`
  font-size: 15px;
  background: #f35f04;
  width: fit-content;
  padding: 2px 7px;
  border-radius: 6px;
  margin-right: 5px;
  margin-bottom: 5px;
  color: white !important;
  box-shadow: 1px 1px 4px grey;
`
const Tag = styled.a`
  font-size: 15px;
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
  max-width: 150px;
  color: black;
`

const TitleArea = styled.div`
  display: flex;
  justify-content: space-between;
`

const ListTitle = styled.h3`
  color: white;
  text-align: initial;
  width: fit-content;
`

const AndMore = styled.a`
  color: white;
  text-align: initial;
  font-size: 20px;
      font-size: 16px;
    padding-top: 7px;
    padding-right: 5px;
`

const Items = styled.ul`
  display: block;
  height: auto;
  background: white;
  border-radius: 10px;
  box-shadow: 1px 1px 4px grey;
  padding: 5px;
  text-align: left;
`

const SoundItem = styled.a`
  display: block;
  margin-right: auto;
  width: fit-content;
  color: black;
  text-overflow: ellipsis;
  white-space: nowrap;
  overflow: hidden;
  padding: 0px;
`

const Item = styled.p`
  display: block;
  margin-right: auto;
  width: fit-content;
  color: black;
  padding: 0px;
  margin: 0px;
  margin-left: 5px;
`
