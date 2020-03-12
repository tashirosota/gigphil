import React from "react"
import ReactSelect from 'react-select';
import styled from 'styled-components'

export default class Search extends React.Component {
  constructor(props){
    super(props)
    this.state = {
      tags: props.tags,
      areas: props.areas,
      selectedArea: '',
      artistName: '',
      selectedTags: [],
      totalCount: props.total_count
    }
    this.saerch = this.saerch.bind(this) 
    this.hundleChange = this.hundleChange.bind(this) 
    this.hundleTagChange = this.hundleTagChange.bind(this) 
  }

  saerch(){
    const { artistName, selectedArea, selectedTags } = this.state
    location.href = `/indies_wiki/artists?artist_name=${artistName}&selected_area=${selectedArea}&tags=${selectedTags}`
  }

  hundleChange(e){
    this.setState({
      [e.target.name]: e.target.value
    })
  }

  hundleTagChange(tags){
    if(tags == null){
      this.setState({
        selectedTags: []
      })
    } else {
      this.setState({
        selectedTags: tags.map((tag) => {
          return tag.value
        })
      })
    }
  }

  render () {

    const { tags, areas, artistName, selectedArea, totalCount } = this.state
    return (
      <React.Fragment>
        <Title>インディーズwiki(β版)</Title>
        <Description>インディーズwikiはユーザ投稿型、公開式のバンドデータベースです。<br/>twitterでログインすることにより、誰でも好きなアーティストを登録、編集できます。</Description>
        <Count>現在の登録数: {totalCount}組</Count>
        <a href="https://twitter.com/share?ref_src=twsrc%5Etfw" className="twitter-share-button" data-show-count="false">Tweet</a><script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>
        <ArtistName name='artistName' placeholder='アーティスト名' className="form-control" value={artistName} onChange={ this.hundleChange }/>
        <ReactSelect
          isMulti
          name="selectedTags"
          options={tags.map((tag) => {
            return ({ value: tag, label: tag })
          })}
          placeholder="タグで絞る"
          className="basic-multi-select"
          onChange={this.hundleTagChange}
        />
        <AreaSelect name='selectedArea' className="form-control" value={selectedArea} onChange={ this.hundleChange }>
          <option value=''>エリアで絞る</option>
          {
            areas.map((area, index) => {
            return <option key={index} value={area}>{area}</option>
            })
          }
        </AreaSelect>
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
  margin-bottom: 20px;
  width: 100%;
  background: #f35f04;
  color: white;
  border: none;
  font-size: 20px;
  box-shadow: 1px 1px 4px grey;
`

const AreaSelect = styled.select`
  margin: 20px 0px;
  padding: 0px 5px;
`

const ArtistName = styled.input`
  backgroun
  width: 100px;
  padding: 0px 10px;
  margin-bottom: 20px;
`

const Description =  styled.h2`
  text-align: left;
  font-size: 16px;
  color: white;
`

const Count =  styled.h3`
  text-align: center;
  font-size: 20px;
  color: white;
  margin: 20px 0px;
`