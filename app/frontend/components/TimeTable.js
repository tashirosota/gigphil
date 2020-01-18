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
      eventDate: '2020-10-01',
      title: 'タイトル',
      place: '場所',
      memo: '備考',
      meetingTime: '17:30',
      openTime: '18:00',
      startTime: '18:30',
      playTimes: [15, 20, 25, 30, 35, 40, 45, 60, 100, 120],
      settingTimes: [5, 10, 15, 20],
      rehearsalSettingTime: 5,
      rehearsalPlayTime: 20,
      productionSettingTime: 10,
      productionPlayTime: 30,
      rehearsals: this.defaultRecords(), 
      concerts: this.defaultRecords()
    }

    this.removeProduction = this.removeProduction.bind(this)
    this.addProduction = this.addProduction.bind(this)
    this.removeRehearsal = this.removeRehearsal.bind(this)
    this.addRehearsal = this.addRehearsal.bind(this)
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
      canvas.toBlob(blob => {
        const a = document.createElement('a');
        a.download = `timetable`;
        a.href = window.URL.createObjectURL(blob);
        a.click();
      })
    });
  }

  removeProduction(){
    let concerts = this.state.concerts
    concerts.pop()
    this.setState({concerts})
  }

  addProduction(){
    let concerts = this.state.concerts
    const record = Object.assign({}, defalutRecord)
    record.order = concerts.length + 1
    concerts.push(record)
    this.setState({concerts})
  }

  removeRehearsal(){
    let rehearsals = this.state.rehearsals
    rehearsals.pop()
    this.setState({rehearsals})
  }

  addRehearsal(){
    let rehearsals = this.state.rehearsals
    const record = Object.assign({}, defalutRecord)
    record.order = rehearsals.length + 1
    rehearsals.push(record)
    this.setState({rehearsals})
  }


  render () {
    return (
      <React.Fragment>
        <Container>
          <Head>
            <Logo alt="Gigphil | ライブ好きのための検索アプリ @" src="/assets/logo.png"/>
          </Head>
          <div id={'timetable'}>
            <TTContainer>
              <HeadTable className='table table-bordered'>
                <Tbody>
                  <Title>
                    <Td style={{width: 110}}>タイトル</Td>
                    <Td><TextLeftInput name="title" value={this.state.title} onChange={ e => this.setState({title: e.target.value}) }/></Td>
                  </Title>
                  <EventDate>
                    <Td>日付</Td>
                    <Td><TextLeftInput name="eventDate" type='date' value={this.state.eventDate} onChange={ e => this.setState({eventDate: e.target.value})}/></Td>
                  </EventDate>
                  <Place>
                    <Td>場所</Td>
                    <Td><TextLeftInput name="place" value={this.state.place} onChange={ e => this.setState({place: e.target.value})}/></Td>
                  </Place>
                  <Memo>
                    <Td>備考</Td>
                    <Td><TextArea name="memo" value={this.state.memo} onChange={ e => this.setState({memo: e.target.value})}/></Td>
                  </Memo>
                </Tbody>
              </HeadTable>
              <Rehearsal>
                <TimesContainer>
                  <DefaultPlayTime>
                    <Text>持ち時間:</Text>
                    <Select name='rehearsalPlayTime' value={this.state.rehearsalPlayTime} style={{width: 100}} onChange={ e => this.setState({rehearsalPlayTime: e.target.value})}>
                      {
                        this.state.playTimes.map((time, index) => {
                        return <option key={index} value={time}>{time}</option>
                        })
                      }
                      </Select>
                    <Text>分</Text>
                  </DefaultPlayTime>
                  <DefaultSettingTime>
                    <Text>転換時間:</Text>
                    <Select name='rehearsalSettingTime' value={this.state.rehearsalSettingTime} style={{width: 100}} onChange={ e => this.setState({rehearsalSettingTime: e.target.value})}>
                      {
                        this.state.settingTimes.map((time, index) => {
                        return <option key={index} value={time}>{time}</option>
                        })
                      }
                      </Select>
                    <Text>分</Text>
                  </DefaultSettingTime>
                  <ButtonArea>
                    <DeleteButton type="button" className='btn btn-secondary btn-sm' onClick={this.removeRehearsal}>削除</DeleteButton>
                    <AddButton type="button" className='btn btn-secondary btn-sm' onClick={this.addRehearsal}>追加</AddButton>
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
                    this.state.rehearsals.map((record, index) => {
                      return <Tr key={index}>
                        <Td style={{width: 80}}>{record.order}</Td>
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
                <Meeting>
                  <div style={{width: 100}}>顔合わせ:</div>
                  <TimeInput placeholder='顔合わせ' type='time' value={this.state.startTime} onChange={ e => this.setState({title: e.startTime.value})}/>
                </Meeting>
                <Open>
                  <div style={{width: 80}}>OPEN:</div>
                  <TimeInput placeholder='12:00' type='time' value={this.state.startTime} onChange={ e => this.setState({startTime: e.target.value})}/>
                </Open>
                <Start>
                  <div style={{width: 80}}>START:</div>
                  <TimeInput placeholder='Start' type='time' value={this.state.startTime} onChange={ e => this.setState({startTime: e.target.value})}/>
                </Start>
              </TimesContainer>
              <Production>
                <TimesContainer>
                  <DefaultPlayTime>
                    <Text>持ち時間:</Text>
                    <Select name='productionPlayTime' value={this.state.productionPlayTime} style={{width: 100}} onChange={ e => this.setState({productionPlayTime: e.target.value})}>
                      {
                        this.state.playTimes.map((time, index) => {
                        return <option key={index} value={time}>{time}</option>
                        })
                      }
                      </Select>
                    <Text>分</Text>
                  </DefaultPlayTime>
                  <DefaultSettingTime>
                    <Text>転換時間:</Text>
                    <Select name='productionSettingTime' value={this.state.productionSettingTime} style={{width: 100}}  onChange={ e => this.setState({productionSettingTime: e.target.value})}>
                      {
                        this.state.settingTimes.map((time, index) => {
                        return <option key={index} value={time}>{time}</option>
                        })
                      }
                      </Select>
                    <Text>分</Text>
                  </DefaultSettingTime>
                  <ButtonArea>
                    <DeleteButton type="button" className='btn btn-secondary btn-sm' onClick={this.removeProduction}>削除</DeleteButton>
                    <AddButton type="button" className='btn btn-secondary btn-sm' onClick={this.addProduction}>追加</AddButton>
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
                        <Td style={{width: 80}}>{record.order}</Td>
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
          </div>
          <SaveButtop type="button" className='btn btn-light btn-lg' onClick={this.export}>png書き出し</SaveButtop>
        </Container>
      </React.Fragment>
    );
  }
}

const Container = styled.div`
  display: block;
  width: 1200px;
  min-height: 2200px;
  padding: 0 50px;
  margin: 0 auto;
  font-size: large;
`


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

const Logo = styled.img`
  max-width: 400px;
  max-height: 176px;
  margin: 0px auto;
  margin-bottom: 30px;
`

const TextLeftInput = styled.input`
  width: 100%;
  padding: 0px 10px;
  th {
    border: none;
  }
`

const Select = styled.select`
  width: 100%;
  padding: 0px 10px;
  th {
    border: none;
  }
  text-align: center;
  border: none;
  background-color: #fff;
`

const Input = styled.input`
  width: 100%;
  padding: 0px 10px;
  th {
    border: none;
  }
  text-align: center;
`

const TimeInput = styled.input`
  width: 100px;
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
  padding: 0px 10px;
  height: 150px;
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
  text-align: center;
`

const SaveButtop = styled.button`
  margin-top: 30px;
  width: 100%;
  height: 100px;
  font-size: 45px;;
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