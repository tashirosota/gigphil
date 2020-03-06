import React from "react"
import styled from 'styled-components'
import ReactSelect from 'react-select'

export default class ArtistEdit extends React.Component {
  constructor(props){
    super(props)
    this.state = {
      artist: this.props.artist,
      tags: this.props.tags,
      areas: this.props.areas,
      uploadFileURL: null,
      saving: false,
      validationMessages: []
    }

    this.hundleChange = this.hundleChange.bind(this) 
    this.save = this.save.bind(this) 
    this.validation = this.validation.bind(this) 
  }

  hundleChange(e){
    const { artist } = this.state
    if(e.target.name == 'icon'){
      artist.icon = e.target.files[0]
      this.setState({ uploadFileURL: window.URL.createObjectURL(e.target.files[0]) })
    } else if(e.target.name == 'area_id') {
      artist.area.id = e.target.value
    } else {
      artist[e.target.name] = e.target.value
    }
    this.setState({ artist })
  }

  save(){
    const { saving } = this.state
    if(!this.validation()) { return false }
    // this.setState({saving: true}, ()=>{

    // })
  }

  validation(){
    const { artist, uploadFileURL } = this.state
    const validationMessages = []
    if(!uploadFileURL) { validationMessages.push('アーティスト写は必須項目です')}
    if(!artist.name) { validationMessages.push('アーティスト名は必須項目です。')}
    if(!artist.area.id) { validationMessages.push('エリアは必須項目です。')}
    this.setState({validationMessages})
    validationMessages.length == 0
  }

  render () {
    const { artist, tags, areas, uploadFileURL, validationMessages, saving } = this.state
    return (
      <React.Fragment> 
        <Editor>
          <IconArea>
            <Icon alt={artist.name} src={uploadFileURL || artist.icon}/> 
            <IconInput alt={artist.name} name='icon' type="file" onChange={ this.hundleChange }/> 
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
          <Input name='twitter' type='text' placeholder='Twitter URL' value={artist.hp || ''}  onChange={ this.hundleChange }/>
          <Input name='hp' type='text' placeholder='HP URL' value={artist.twitter || ''}  onChange={ this.hundleChange }/>
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

const Editor = styled.div`
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

