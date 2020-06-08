import React from "react"
import styled from 'styled-components'
import axios from "axios";

export default class LiveCard extends React.Component {
  constructor(props){
    super(props)
    this.state = {
      live: this.props.live,
      current_user_id: this.props.current_user_id
    }

    this.delete = this.delete.bind(this)
  }

  delete(){
    if(confirm('この配信情報を削除しますか') == false ) return

    const config = {
      method: 'delete',
      url: `/online_lives/${this.state.live.id}`,
    }

    axios(config)
        .then(res => {
          location.href = `/online_lives/home`
        }, (res) => {
          console.log('error')
          swal("削除失敗", `削除に失敗しました`, "danger");
          console.log(res)
        })
  }

  render () {
    const { live, current_user_id } = this.state
    return (
      <React.Fragment>  
        <Card>
          { live.is_free && <Free>無料</Free> }
          <Title>{live.title}</Title>
          <Description>{live.description}</Description>
          <BroadcastsAt>{live.broadcasts_at}</BroadcastsAt>
          <ToDetail className='btn btn-light btn-lg' href={live.url}>詳しく</ToDetail>
          { current_user_id == live.user_id && <Delete type="button" className='btn btn-light btn-lg' onClick={this.delete}>削除</Delete> }

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

const Title = styled.div`
  font-size: 1.2rem;
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
  font-weight: bold;
`

const Description = styled.div`
  font-size: 1rem;
  margin-top: 5px;
  white-space: pre-line;
  text-align: left;
`

const BroadcastsAt = styled.div`
  font-size: 1rem;
  font-weight: bold;
  margin-top: 5px;
  white-space: pre-line;
  text-align: right;
`

const ToDetail = styled.a`
  width: 100%;
  border-radius: 5px;
  display: block;
  background-color: gray;
  color: white;
  margin-top: 10px;
  padding: 5px;
  font-size: 1.2rem;
`

const Delete = styled.button`
  width: 100%;
  border-radius: 5px;
  display: block;
  background-color: gray;
  color: white;
  margin-top: 10px;
  padding: 5px;
  font-size: 1.2rem;
`

const Free = styled.div`
  width: 57px;
  background-color: green;
  color: white;
  margin-left: auto;
  font-size: 1rem;
  font-weight: bold;
  border-radius: 5px;
  padding: 2px 5px;
`

