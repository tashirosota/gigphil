import React from "react"
import ReactSelect from 'react-select';
import styled from 'styled-components'

export default class Search extends React.Component {
  constructor(props){
    super(props)
    this.state = {
      word: '',
      broadcastsDate: ''
    }
    this.saerch = this.saerch.bind(this) 
    this.hundleChange = this.hundleChange.bind(this) 
  }

  saerch(){
    const { word, broadcastsDate} = this.state
    if((!word && !broadcastsDate)) return;
    location.href = `/online_lives?word=${word}&broadcasts_date=${broadcastsDate}`
  }

  hundleChange(e){
    this.setState({
      [e.target.name]: e.target.value
    })
  }

  render () {

    const { word, broadcastsDate } = this.state
    return (
      <React.Fragment>
        <Title>配信ライブまとめ</Title>
        <Description>配信ライブのまとめサイトです。<br/>誰でも登録することが出来ます。<br/>配信ライブの情報源として使ってやってください🙇‍♂️</Description>
        <DateTimeSelect type="date" name='broadcastsDate' className="form-control" value={broadcastsDate} onChange={this.hundleChange}/>
        <SearchWard name='word' placeholder='タイトル、概要からの曖昧検索' className="form-control" value={word} onChange={ this.hundleChange}/>
        <SearchButton className='btn btn-light btn-lg' onClick={this.saerch}>検索</SearchButton>
      </React.Fragment>
    )
  }
}

const Title = styled.h1`
  text-align: center;
  font-size: 30px;
  color: white;
  margin: 25px 0px;
`

const SearchButton = styled.button`
  width: 100%;
  background: #f35f04;
  color: white;
  border: none;
  font-size: 20px;
  box-shadow: 1px 1px 4px grey;
  margin-bottom: 10px;
`

const DateTimeSelect = styled.input`
  width: 100%;
  padding: 0px 10px;
  margin-bottom: 20px;
`

const SearchWard = styled.input`
  width: 100%;
  padding: 0px 10px;
  margin-bottom: 20px;
`

const Description =  styled.h2`
  text-align: left;
  font-size: 1rem;
  color: white;
  margin-bottom: 15px;
  @media (min-width: 576px){
    text-align: center;
  }
`
