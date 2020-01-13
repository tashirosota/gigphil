import React from "react"
import styled from 'styled-components'
import swal from 'sweetalert';

const defalutRecord = {
  order: 1,
  bandName: 'バンド名',
  customPlayTime: null,
  customSettingTime: null,
  memo: null
}
export default class TimeTable extends React.Component {

  constructor(props){
    super(props)
    this.state = {
      eventDate: null,
      title: null,
      place: null,
      meetingTime: null,
      openTime: null,
      rehearsalSettingTime: null,
      rehearsalPlayTime: null,
      productionSettingTime: null,
      productionPlayTime: null,
      rehearsals: defaultRecords(), 
      concerts: defaultRecords()
    }
  }

  defaultRecords(){
    return [...Array(6)].map(
      (_, index) => {
        const record = Object.assign({}, defalutRecord)
        record.order = index + 1
        return record
      }
    )
  }

  render () {
    return (
      <React.Fragment>
        <Title>{this.state.title}</Title>
        <EventDate>{this.state.eventDate}</EventDate>
        <Place>{this.state.place}</Place>
      </React.Fragment>
    );
  }
}

const Title = styled.h1`
  
`

const EventDate = styled.h1`
  
`

const Place = styled.h1`
`