import React from "react"
import axios from "axios";
import styled from 'styled-components';
import swal from 'sweetalert';
import moment from 'moment'

export default class LiveNew extends React.Component {
  constructor(props){
    super(props)
    this.state = {
      live: {
        title: null,
        url: null,
        description: null,
        broadcasts_at: null,
        is_free: true
      },
      saving: false,
      validationMessages: []
    }

    this.save = this.save.bind(this) 
    this.validation = this.validation.bind(this) 
    this.hundleChange = this.hundleChange.bind(this) 
  }

  hundleChange(e){
    const { live } = this.state
    if(e.target.name == 'is_free'){
      live.is_free = !live.is_free
    } else {
      live[e.target.name] = e.target.value
    }
    
    this.setState({ live })
  }

  save(e){
    e.preventDefault();
    const { live } = this.state
    if(!this.validation()) { return false }
    const config = {
      method: 'post',
      url: '/online_lives',
      data: {
        live: live
      }
    }
    this.setState({saving: true}, ()=>{
      axios(config)
        .then(res => {
          location.href = `/online_lives/${res.data.id}`
        }, (res) => {
          swal("保存失敗", `保存に失敗しました`, "danger");
        }).then(()=>{
          this.setState({saving: false})
        })
    })
  }

  validation(){
    const { live } = this.state
    const validationMessages = []
    if(!live.title || live.title.length > 40) { validationMessages.push('タイトルは必須項目で、40文字以内です。')}
    if(!live.description || live.description.length > 200) { validationMessages.push('概要は必須項目で、200文字以内です。')}
    if(!live.url) { validationMessages.push('URLは必須項目です。')}
    this.setState({validationMessages})
    return validationMessages.length === 0
  }

  render () {
    const { live, validationMessages, saving } = this.state
    return (
      <React.Fragment>  
        <Card>
          <Title name='title' type='text' className="form-control" placeholder='タイトル ※ 40文字以内' value={live.title || ''} onChange={ this.hundleChange }/>
          <Description name='description' className="form-control"  style={{height: 200}} placeholder='概要 ※ 200文字以内' value={live.description || ''} onChange={ this.hundleChange }/>
          <div style={{textAlign: 'left'}}>配信日時</div>
          <BroadcastsAt  type="datetime-local" name='broadcasts_at' className="form-control" value={live.broadcasts_at || ''} onChange={ this.hundleChange }/>
          <Url name='url' type='text' className="form-control" placeholder='配信URL' value={live.url || ''} onChange={ this.hundleChange }/>
          <div className="form-check">
            <input className="form-check-input" type="checkbox" name='is_free' checked={live.is_free} onChange={ this.hundleChange }/>
            <label className="form-check-label">無料ライブ</label>
          </div>
          {
            validationMessages.map((msg, index) => {
              return <ValidationMessage key={index}>{msg}</ValidationMessage>
            })
          }
          <SaveButton onClick={this.save} disabled={saving}>保存する</SaveButton>
        </Card>
       </React.Fragment>
    )
  }
}

const Card = styled.div`
  text-align: center;
  display: block;
  position: relative;
  background: #dadada;
  height: auto;
  min-width: 500px;
  width: auto;
  max-width: 500px;
  color: black;
  border-radius: 10px;
  box-shadow: 2px 2px 4px black;
  padding: 15px;
  margin-bottom: 10px;
  @media (max-width: 576px){
    width: 100%;
    min-width: unset;
  }
`

const Title = styled.input`
  font-size: 1.2rem;
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
  font-weight: bold;
`

const Url = styled.input`
  font-size: 1rem;
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
  font-weight: bold;
  margin-top: 5px;
`

const Description = styled.textarea`
  font-size: 1rem;
  margin-top: 5px;
  white-space: pre-line;
  text-align: left;
`

const BroadcastsAt = styled.input`
  font-size: 1rem;
  font-weight: bold;
  margin-top: 5px;
  text-align: right;
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