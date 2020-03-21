import React from "react"
import styled from 'styled-components'
import axios from "axios";
import swal from 'sweetalert';
import { IoIosAddCircleOutline, IoIosRemoveCircleOutline} from "react-icons/io";


export default class ArtistSoundEdit extends React.Component {
  constructor(props){
    super(props)

    this.state = {
      artistId: this.props.artistId,
      sounds: this.props.sounds,
      sound: { 
        title: null,
        url: null
      }
    }

    this.deleteSound = this.deleteSound.bind(this)
    this.addSound = this.addSound.bind(this) 
  }

  addSound(){
    const { sound, sounds } = this.state
    const config = {
      method: 'post',
      url: `/indies_wiki/artists/${this.artistId}/sound`,
      data: {
        sound: sound
      }
    }

    axios(config)
      .then(res => {
        sounds.push(res.sound)
      }, (res) => {
        console.log('error')
        swal("保存失敗", `保存に失敗しました`, "danger");
        console.log(res)
      })
  }

  deleteSound(id, index){
    const { sound, sounds, artistId } = this.state
    const config = {
      method: 'delete',
      url: `/indies_wiki/artists/${artistId}/sounds/${id}`
    }

    axios(config)
      .then(res => {
        sounds.filter(n => sound.id !== index);
      }, (res) => {
        console.log('error')
        swal("保存失敗", `削除に失敗しました`, "danger");
        console.log(res)
      })
  }

  render () {
    const { sounds, sound } = this.state
    return (
      <React.Fragment> 
        <Sounds>
          {
            sounds.map(
              (sound, index) => {
                <SoundArea key={index}>
                  <Titlelabel>{sound.title}</Titlelabel>
                  <UrlLabel>{sound.url}</UrlLabel>
                  <DeleteButton onClick={this.deleteSound(sound.id)}><IoIosRemoveCircleOutline/></DeleteButton>
                </SoundArea>
              }
            )
          }
          <SoundInputArea>
            <TitleInput type="text" value={sound.title || '' } placeholder="プレイリスト最高（AppleMusic）"/>
            <UrlInput type="text" value={sound.url  || ''} placeholder="https://music.apple.com/jp/playlist/hogehoge"/>
            <AddButton onClick={this.addSound(sound)}><IoIosAddCircleOutline/></AddButton>
          </SoundInputArea>
        </Sounds>
      </React.Fragment>
    )
  }
}

const Sounds = styled.div`

`

const SoundArea = styled.div`

`

const Titlelabel = styled.p`

`

const UrlLabel = styled.p`

`

const DeleteButton = styled.a`
 
`

const SoundInputArea = styled.div`
  text-align: center;
  margin: 0px auto;
  width: autpo;
`

const UrlInput = styled.input`
 
`

const TitleInput = styled.input`
 
`

const AddButton = styled.a`
 
`