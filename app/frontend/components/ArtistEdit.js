import React from "react"
import styled from 'styled-components'
import axios from "axios";
import swal from 'sweetalert';
import ReactSelect from 'react-select'

export default class ArtistEdit extends React.Component {
  constructor(props){
    super(props)
    this.state = {
      artist: this.props.artist,
      tags: this.props.tags,
      areas: this.props.areas,
      isNew: this.props.is_new,
      uploadFileURL: null,
      saving: false,
      validationMessages: []
    }

    this.hundleChange = this.hundleChange.bind(this) 
    this.save = this.save.bind(this) 
    this.validation = this.validation.bind(this) 
    this.fileInput = React.createRef();
  }

  hundleChange(e){
    const { artist } = this.state
    if(e.target.name == 'icon'){
      this.setState({ uploadFileURL: window.URL.createObjectURL(e.target.files[0]) })    
    } else if(e.target.name == 'area_id') {
      artist.area.id = e.target.value
    } else {
      artist[e.target.name] = e.target.value
    }
    this.setState({ artist })
  }

  save(e){
    e.preventDefault();
    const { artist, isNew } = this.state
    if(!this.validation()) { return false }
    const formData = new FormData()
    if(this.fileInput.current.files[0]) {
      formData.append("artist[icon]", this.fileInput.current.files[0])
    }
    formData.append("artist[name]", artist.name)
    formData.append("artist[description]", artist.name)
    formData.append("artist[area_id]", artist.area.id)
    artist.tags.forEach((tag) => { formData.append("artist[tag_ids][]", tag.id)})
    if(artist.twitter){ formData.append("artist[twitter]", artist.twitter) }
    if(artist.hp){ formData.append("artist[hp]", artist.hp) }
    const config = {
      method: (isNew ? 'post' : 'put'),
      url: (isNew ? '/indies_wiki/artists' : `/indies_wiki/artists/${artist.id}`),
      data: formData
    }
    this.setState({saving: true}, ()=>{
      axios(config)
        .then(res => {
          location.href = `/indies_wiki/artists/${res.data.id}`
        }, (res) => {
          swal("保存失敗", `保存に失敗しました。hp、twitterまたは、アー写を確認して下さい。※同名のアーティストが存在する場合も保存出来ません。`, "danger");
        }).then(()=>{
          this.setState({saving: false})
        })
    })
  }

  validation(){
    const { artist, uploadFileURL } = this.state
    const validationMessages = []
    if(!(uploadFileURL || artist.icon)) { validationMessages.push('アーティスト写真は必須項目です')}
    if(!artist.name) { validationMessages.push('アーティスト名は必須項目です。')}
    if(!artist.area.id) { validationMessages.push('エリアは必須項目です。')}
    this.setState({validationMessages})
    return validationMessages.length === 0
  }

  render () {
    const { artist, tags, areas, uploadFileURL, validationMessages, saving } = this.state
    return (
      <React.Fragment> 
        <Editor>
          <IconArea>
            <Icon alt={artist.name} src={uploadFileURL || artist.icon || '/assets/default_icon.jpeg'}/> 
            <IconInput alt={artist.name} name='icon' type="file" ref={this.fileInput} accept="image/*" onChange={ this.hundleChange }/> 
          </IconArea>
          <Input name='name' type='text' placeholder='アーティスト名 ※ 必須' value={artist.name || ''}  onChange={ this.hundleChange }/>
          <Description name='description' placeholder='このアーティストの説明を説明を入力してください。' value={artist.description || ''}  onChange={ this.hundleChange }/>
          <AreaSelect name='area_id' className="form-control" value={artist.area.id || ''} onChange={ this.hundleChange }>
            <option value=''>エリアを選ぶ ※ 必須</option>
            {
              areas.map((area, index) => {
              return <option key={index} value={area.id}>{area.name}</option>
              })
            }
          </AreaSelect>
          <ReactSelect
            isMulti
            name="selectedTags"
            options={tags.map((tag) => {
              return ({ value: tag.id, label: tag.name })
            })}
            placeholder="タグを追加する"
            className="basic-multi-select"
            onChange={this.hundleTagChange}
          />
          <Input name='twitter' type='text' placeholder='https://twitter.com/ARTIST_ID' value={artist.twitter || ''}  onChange={ this.hundleChange }/>
          <Input name='hp' type='text' placeholder='HP URL' value={artist.hp || ''}  onChange={ this.hundleChange }/>
          {
            validationMessages.map((msg, index) => {
              return <ValidationMessage key={index}>{msg}</ValidationMessage>
            })
          }
          <SaveButton onClick={this.save} disabled={saving}>保存する</SaveButton>
        </Editor>  
      </React.Fragment>
    )
  }
}

const Editor = styled.form`
  text-align: center;
  margin: 0px auto;
  width: autpo;
`
const IconArea = styled.div`
  position: relative;
`

const Icon = styled.img`
  border-radius: 10px;
  width: auto;
  max-height: 200px;
  max-width: 340px;
  margin-bottom: 0px;
  display: block;
  margin: 0px auto;
  background: white;
`

const IconInput = styled.input`
  opacity: 0;
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  margin: auto;
`

const Input = styled.input`
  text-align: center;
  font-size: 1.4rem;
  display: block;
  margin: 20px auto;
  padding: 5px;
  width: 100%;
  height: 35px;
  background: inherit;
  color: white;
  border: none;
  border-bottom: 2px groove white;
`
const Description = styled.textarea`
  font-size: 1.3rem;
  text-align: left;
  display: block;
  margin: 20px auto;
  padding: 5px;
  width: 100%;
  height: fit-content;
  min-height: 100px;
  background: inherit;
  color: white;
  border: none;
  border-bottom: 2px groove white;
`
const AreaSelect = styled.select`
  margin: 20px 0px;
  padding: 0px 5px;
`

const SaveButton = styled.button`
  width: 100%;
  background: #f35f04;
  color: white;
  border: none;
  font-size: 20px;
  box-shadow: 1px 1px 4px grey;
  border-radius: 0.25rem;
  margin-top: 20px;
  height: 50px;
`

const ValidationMessage = styled.p`
  color: #ff7777;
  font-size: 15px;
  margin-top: 5px;
`

