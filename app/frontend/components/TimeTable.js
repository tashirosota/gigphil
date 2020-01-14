import React from "react"
import styled from 'styled-components'
import swal from 'sweetalert';

var defalutRecord = {
  order: '',
  bandName: 'バンド名',
  customPlayTime: null,
  customSettingTime: null,
  memo: '備考'
}
export default class TimeTable extends React.Component {

  constructor(props){
    super(props)
    this.state = {
      eventDate: null,
      title: null,
      place: null,
      memo: null,
      meetingTime: null,
      openTime: null,
      rehearsalSettingTime: null,
      rehearsalPlayTime: null,
      productionSettingTime: null,
      productionPlayTime: null,
      rehearsals: this.defaultRecords(), 
      concerts: this.defaultRecords()
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
        <Container>
          <Title>
            <Input placeholder='バンド名'>{this.state.title}</Input>
          </Title>
          <EventDate>
            <Input placeholder='日付'>{this.state.eventDate}</Input>
          </EventDate>          
          <Place>
            <Input placeholder='場所'>{this.state.place}</Input>
          </Place>
          <Memo>
            <TextArea placeholder='備考'>{this.state.memo}</TextArea>
          </Memo>
          <Rehearsal>
            <TimesContainer>
              <DefaultPlayTime><Input placeholder='順番'/></DefaultPlayTime>
              <DefaultSettingTime><Input placeholder='順番'/></DefaultSettingTime>
            </TimesContainer>
            <Table className='table table-bordered'>
              <Thead>
                <Tr>
                  <Th scope="col">順番</Th>
                  <Th scope="col">バンド名</Th>
                  <Th scope="col">時間</Th>
                  <Th scope="col">演奏</Th>
                  <Th scope="col">転換</Th>
                  <Th scope="col">備考</Th>
                </Tr>
              </Thead>
              <Tbody>
              {
                this.state.concerts.map((record, index) => {
                  return <Tr key={index}>
                    <Td><Input placeholder='順番' defaultValue={record.order}/></Td>
                    <Td><Input placeholder='バンド名' defaultValue={record.bandName}/></Td>
                    <Td>時間</Td>
                    <Td><Input placeholder='演奏' defaultValue={record.customPlayTime}/></Td>
                    <Td><Input placeholder='転換' defaultValue={record.customSettingTime}/></Td>
                    <Td><Input placeholder='備考' defaultValue={record.memo}/></Td>
                    <ButtonArea>
                      <AddButton/>
                      <DeleteButton/>
                    </ButtonArea>
                  </Tr>
                 }
                )
              }
              </Tbody>
            </Table>
          </Rehearsal>
          <TimesContainer>
            <Meeting><Input placeholder='顔合わせ'/></Meeting>
            <Open><Input placeholder='Open'/></Open>
            <Start><Input placeholder='Start'/></Start>
          </TimesContainer>
          <Production>
            <TimesContainer>
              <DefaultPlayTime><Input placeholder='順番'/></DefaultPlayTime>
              <DefaultSettingTime><Input placeholder='順番'/></DefaultSettingTime>
            </TimesContainer>           
            <Table className='table table-bordered'>
             <Thead>
                <Tr>
                  <Th scope="col">順番</Th>
                  <Th scope="col">バンド名</Th>
                  <Th scope="col">時間</Th>
                  <Th scope="col">演奏</Th>
                  <Th scope="col">転換</Th>
                  <Th scope="col">備考</Th>
                </Tr>
              </Thead>
              <Tbody>
                {this.state.concerts.map((record, index) => {
                  return <Tr key={index}>
                    <Td><Input placeholder='順番' defaultValue={record.order}/></Td>
                    <Td><Input placeholder='バンド名' defaultValue={record.bandName}/></Td>
                    <Td>時間</Td>
                    <Td><Input placeholder='演奏' defaultValue={record.customPlayTime}/></Td>
                    <Td><Input placeholder='転換' defaultValue={record.customSettingTime}/></Td>
                    <Td><Input placeholder='備考' defaultValue={record.memo}/></Td>
                    <ButtonArea>
                      <AddButton/>
                      <DeleteButton/>
                    </ButtonArea>
                  </Tr>
                 }
                )}
              </Tbody>
            </Table>
          </Production>
          <SaveButtop>出力</SaveButtop>
        </Container>
      </React.Fragment>
    );
  }
}

const Container = styled.div`
  display: block;
  width: 980px;
  margin: 0 auto;
`

const Input = styled.input`
  
`

const TextArea =  styled.textarea`
  
`

const Title = styled.div`
  
`

const EventDate = styled.div`
  
`

const Place = styled.div`
`

const Memo = styled.div`
  width: 100px;
`
const TimesContainer = styled.div`
  display: flex;
`

const Meeting = styled.div`

`

const Open = styled.div`

`

const Start = styled.div`

`

const DefaultPlayTime = styled.div`

`

const DefaultSettingTime = styled.div`

`

const Rehearsal = styled.div`
  display: block;
  width: 100%;
  height: 100%;
`

const Production = styled.div`
  display: block;
  width: 100%;
  height: 100%;
`

const Table = styled.table`

`

const Thead = styled.thead`

`

const Tr = styled.tr`

`

const Th = styled.th`

`

const Tbody = styled.tbody`

`

const Td = styled.td`

`

const SaveButtop = styled.button`
  
`

const ButtonArea = styled.div`
  
`

const AddButton = styled.button`
  
`

const DeleteButton  = styled.button`
  
`