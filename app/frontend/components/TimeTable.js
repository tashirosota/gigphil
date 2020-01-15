import React from "react"
import styled from 'styled-components'
import swal from 'sweetalert';
import html2canvas from 'html2canvas'

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

  export(){
    html2canvas(document.querySelector("#timetable")).then(canvas => {
      debugger
      canvas.toBlob(blob => {
        const a = document.createElement('a');
        a.download = `timetable.png`;
        a.href = window.URL.createObjectURL(blob);
        a.click();
      })
  });
  }

  render () {
    return (
      <React.Fragment>
        <Container>
          <Head>
            <Logo alt="Gigphil | ライブ好きのための検索アプリ @" src="/assets/logo.png"/>
          </Head>
          <TTContainer id={'timetable'}>
            <HeadTable className='table table-bordered'>
              <Tbody>
                <Title>
                  <Td style={{width: 80}}>タイトル</Td>
                  <Td><Input  placeholder='タイトル'>{this.state.title}</Input></Td>
                </Title>
                <EventDate>
                  <Td>日付</Td>
                  <Td><Input placeholder='日付'>{this.state.eventDate}</Input></Td>
                </EventDate>
                <Place>
                  <Td>場所</Td>
                  <Td><Input placeholder='場所'>{this.state.place}</Input></Td>
                </Place>
                <Memo>
                  <Td>備考</Td>
                  <Td><TextArea  placeholder='備考'>{this.state.memo}</TextArea></Td>
                </Memo>
              </Tbody>
            </HeadTable>
            <Rehearsal>
              <TimesContainer>
                <DefaultPlayTime><Text>持ち時間:</Text><Input placeholder='順番' style={{width: 100}}/><Text>分</Text></DefaultPlayTime>
                <DefaultSettingTime><Text>転換時間:</Text><Input placeholder='順番' style={{width: 100}}/><Text>分</Text></DefaultSettingTime>
                <ButtonArea>
                  <DeleteButton type="button" className='btn btn-secondary btn-sm'>削除 </DeleteButton>
                  <AddButton type="button" className='btn btn-secondary btn-sm'>追加</AddButton>
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
                      <Td style={{width: 60}}><Input defaultValue={record.order}/></Td>
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
              <Meeting><div style={{width: 100}}>顔合わせ:</div><Input placeholder='顔合わせ'/></Meeting>
              <Open><div style={{width: 100}}>OPEN:</div><Input placeholder='Open'/></Open>
              <Start><div style={{width: 100}}>START:</div><Input placeholder='Start'/></Start>
            </TimesContainer>
            <Production>
              <TimesContainer>
                <DefaultPlayTime><Text>持ち時間:</Text><Input placeholder='順番' style={{width: 100}}/><Text>分</Text></DefaultPlayTime>
                <DefaultSettingTime><Text>転換時間:</Text><Input placeholder='順番' style={{width: 100}}/><Text>分</Text></DefaultSettingTime>
                <ButtonArea>
                  <DeleteButton type="button" className='btn btn-secondary btn-sm'>削除 </DeleteButton>
                  <AddButton type="button" className='btn btn-secondary btn-sm'>追加</AddButton>
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
                      <Td style={{width: 60}}><Input defaultValue={record.order}/></Td>
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
          <SaveButtop type="button" className='btn btn-light btn-lg' onClick={this.export}>png書き出し</SaveButtop>
        </Container>
      </React.Fragment>
    );
  }
}

const TTContainer = styled.div`
  background: white;
  padding: 30px 10px;
  input {
    border: none;

  };
  textarea {
    border: none;
  };
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
  height: auto;
  margin: 0px auto;
  margin-bottom: 30px;
`

const Input = styled.input`
  width: 100%;
  padding: 0px 10px;
  th {
    border: none;
  }
`

const Text = styled.div`
  width: 100px;
  padding-top: 3px;
`

const TextArea =  styled.textarea`
  width: 100%;
  padding: 0px 10px
`

const Title = styled.tr`
  
`

const EventDate = styled.tr`
  
`

const Place = styled.tr`
`

const Memo = styled.tr`
`
const TimesContainer = styled.div`
  display: flex;
  margin-top: 20px;
  margin-bottom: 10px;
`

const Meeting = styled.div`
  display: flex;
`

const Open = styled.div`
  display: flex;
`

const Start = styled.div`
  display: flex;
`

const DefaultPlayTime = styled.div`
  display: flex;
  
`

const DefaultSettingTime = styled.div`
  display: flex;
  border-bottom: 10px black
`

const Rehearsal = styled.div`
  display: block;
  width: 100%;
  height: 100%;
  margin-bottom: 50px;
`

const Production = styled.div`
  display: block;
  width: 100%;
  height: 100%;
`

const HeadTable = styled.table`

`

const Table = styled.table`

`

const Thead = styled.thead`

`

const Tr = styled.tr`

`

const Th = styled.th`
  text-align: center;
`

const Tbody = styled.tbody`

`

const Td = styled.td`
  padding: 0px 5px !important;
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