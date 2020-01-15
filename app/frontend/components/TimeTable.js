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
          <Head>
            <Logo alt="Gigphil | ライブ好きのための検索アプリ @" src="/assets/logo.png"/>
          </Head>
          <TTContainer>
            <Title>
              <Input placeholder='タイトル'>{this.state.title}</Input>
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
                <ButtonArea>
                  <DeleteButton type="button" className='btn btn-secondary'>削除 </DeleteButton>
                  <AddButton type="button" className='btn btn-secondary'>追加</AddButton>
                </ButtonArea>
              </TimesContainer>
              <Table className='table table-bordered'>
                <Thead>
                  <Tr>
                    <Th scope="col"> 順番</Th>
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
                      <Td style={{width: 50}}><Input defaultValue={record.order}/></Td>
                      <Td><Input placeholder='バンド名' defaultValue={record.bandName}/></Td>
                      <Td style={{width: 200}}>時間</Td>
                      <Td style={{width: 100}}><Input placeholder='演奏' defaultValue={record.customPlayTime}/></Td>
                      <Td style={{width: 100}}><Input placeholder='転換' defaultValue={record.customSettingTime}/></Td>
                      <Td><Input placeholder='備考' defaultValue={record.memo}/></Td>
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
                <ButtonArea>
                  <DeleteButton type="button" className='btn btn-secondary'>削除 </DeleteButton>
                  <AddButton type="button" className='btn btn-secondary'>追加</AddButton>
                </ButtonArea>
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
                      <Td style={{width: 50}}><Input defaultValue={record.order}/></Td>
                      <Td><Input placeholder='バンド名' defaultValue={record.bandName}/></Td>
                      <Td style={{width: 200}}>時間</Td>
                      <Td style={{width: 100}}><Input placeholder='演奏' defaultValue={record.customPlayTime}/></Td>
                      <Td style={{width: 100}}><Input placeholder='転換' defaultValue={record.customSettingTime}/></Td>
                      <Td><Input placeholder='備考' defaultValue={record.memo}/></Td>
                    </Tr>
                  }
                  )}
                </Tbody>
              </Table>
            </Production>
          </TTContainer>
          <SaveButtop type="button" className='btn btn-light btn-lg'>jpeg書き出し</SaveButtop>
        </Container>
      </React.Fragment>
    );
  }
}

const TTContainer = styled.div`
  background: white;
  padding: 30px 10px;
`

const Head = styled.div`
  display: flex;
`

const Container = styled.div`
  display: block;
  width: 980px;
  margin: 0 auto;
`

const Logo = styled.img`
  max-width: 400px;
  margin: auto;
  margin-bottom: 30px;
`

const Input = styled.input`
  width: 100%;
  padding: 0px 10px;
  th {
    border: none;
  }
`

const TextArea =  styled.textarea`
  width: 100%;
  padding: 0px 10px
`

const Title = styled.div`
  
`

const EventDate = styled.div`
  
`

const Place = styled.div`
`

const Memo = styled.div`
`
const TimesContainer = styled.div`
  display: flex;
  margin: 5px 0px;
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
  padding: 0px!important;
  text-align: center;
`

const Tbody = styled.tbody`

`

const Td = styled.td`
  padding: 0px!important;
`

const SaveButtop = styled.button`
  margin-top: 30px;
  width: 100%;
`

const ButtonArea = styled.div`
  margin-left: auto;

`

const AddButton = styled.button`
  margin: 0px 5px;
`

const DeleteButton  = styled.button`
 margin: 0px 5px;
`