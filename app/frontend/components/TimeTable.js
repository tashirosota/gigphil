import React from "react"
import styled from 'styled-components'
import swal from 'sweetalert';
import moment from 'moment'
import axios from "axios";

let defalutRecord = {
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
      timeTable: {
        eventDate: '2020-10-01',
        title: 'タイトル',
        place: '場所',
        memo: '備考',
        meetingTime: '17:30',
        openTime: '18:00',
        startTime: '18:30',
        rehearsalSettingTime: 5,
        rehearsalPlayTime: 20,
        productionSettingTime: 10,
        productionPlayTime: 30,
        rehearsals: this.defaultRecords(), 
        concerts: this.defaultRecords()
      },
      playTimes: [15, 20, 25, 30, 35, 40, 45, 60, 100, 120],
      settingTimes: [5, 10, 15, 20]
    }

    this.removeProduction = this.removeProduction.bind(this)
    this.addProduction = this.addProduction.bind(this)
    this.removeRehearsal = this.removeRehearsal.bind(this)
    this.addRehearsal = this.addRehearsal.bind(this)
    this.change = this.change.bind(this)
    this.changeProductionRecord = this.changeProductionRecord.bind(this)
    this.changeRehearsalRecord = this.changeRehearsalRecord.bind(this)
    this.calculateProductionTime = this.calculateProductionTime.bind(this)
    this.calculateRehearsalTime = this.calculateRehearsalTime.bind(this)
    this.exportAsPdf = this.exportAsPdf.bind(this)
  }

  exportAsPdf() {
    axios(config)
        .then(res => {
          const blob = new Blob([res.data], { type: "application/pdf" })
          const url = window.URL.createObjectURL(blob)
          // downloadByUrl(url);
          location.href = url
        })
    const config = {
      method: 'post',
      responseType: 'blob',
      url: '/api/TT/export',
      data: this.state
    }
    const downloadByUrl = pdfURL => {
      const a = document.createElement("a");
      a.href = pdfURL;
      a.download = "time_table.pdf";
      // aタグ要素を画面に一時的に追加する
      document.body.appendChild(a);
      a.click();
      // 不要になったら削除.
      document.body.removeChild(a);
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

  removeProduction(){
    const { timeTable } = this.state
    timeTable.concerts.pop()
    this.setState({timeTable})
  }

  addProduction(){
    let concerts = this.state.timeTable.concerts
    const record = Object.assign({}, defalutRecord)
    record.order = concerts.length + 1
    concerts.push(record)
    this.setState({concerts})
  }

  removeRehearsal(){
    const { timeTable } = this.state
    timeTable.rehearsals.pop()
    this.setState({timeTable})
  }

  addRehearsal(){
    let rehearsals = this.state.timeTable.rehearsals
    const record = Object.assign({}, defalutRecord)
    record.order = rehearsals.length + 1
    rehearsals.push(record)
    this.setState({rehearsals})
  }

  change(e){
    const { timeTable } = this.state
    timeTable[e.target.name] = e.target.value
    this.setState({timeTable})
  }

  changeRehearsalRecord(e, i){
    const { timeTable } = this.state
    timeTable.rehearsals[i][e.target.name] = e.target.value
    this.setState({timeTable})
  }

  changeProductionRecord(e, i){
    const { timeTable } = this.state
    timeTable.concerts[i][e.target.name] = e.target.value
    this.setState({timeTable})
  }

  // ロジック更に複雑うううう
  calculateRehearsalTime(i){
    const { timeTable } = this.state
    let finishTime = moment(timeTable.meetingTime, 'hh:mm')
    let startTime = null
    let reverse_i = timeTable.rehearsals.length -1 - i // わかりやすい用に逆順でのindexに変えてやる
    let _rehearsals = Object.assign([], timeTable.rehearsals)
    var settingSubValue = null
    _rehearsals.reverse().some((record, index) => {
      if(index == 0){
        var subValue = record.customPlayTime || timeTable.rehearsalPlayTime
        startTime = finishTime.clone()
        startTime.subtract(subValue, 'm')
        if(reverse_i == 0) return true;
      } else {
        finishTime = startTime.clone()
        finishTime.subtract(settingSubValue, 'm')

        var subValue = record.customPlayTime || timeTable.rehearsalPlayTime
        startTime = finishTime.clone()
        startTime.subtract(subValue, 'm')
        if(index == reverse_i) return true;
      }
      settingSubValue = record.customSettingTime || timeTable.rehearsalSettingTime
    })
    return `${startTime.format('HH:mm')} - ${finishTime.format('HH:mm')}`
  }

  // ロジック複雑うううう
  calculateProductionTime(i){
    const { timeTable } = this.state
    let startTime = moment(timeTable.startTime, 'hh:mm')
    let finishTime = null
    timeTable.concerts.some((record, index) => {
      if(index == 0){
        var addValue = record.customPlayTime || timeTable.productionPlayTime
        finishTime = startTime.clone()
        finishTime.add(addValue, 'm')
        if(i == 0) return true; // トッパーのみここで終了
      } else {
        startTime = finishTime.clone()
        addValue = record.customSettingTime || timeTable.productionSettingTime
        startTime.add(addValue, 'm')
        var addValue = record.customPlayTime || timeTable.productionPlayTime
        finishTime = startTime.clone()
        finishTime.add(addValue, 'm')
        if(index == i) return true;
      }
    })
    return `${startTime.format('HH:mm')} - ${finishTime.format('HH:mm')}`
  }f

  render () {
    const { timeTable, playTimes, settingTimes } = this.state
    return (
      <React.Fragment>
        <Container>
          <Head>
            <Logo alt="Gigphil | ライブ好きのための検索アプリ @" src="/assets/logo.png"/>
            <Description className="text-white">タイムテーブルシミュレーター</Description>
            <SearcherLink><a className="text-white" href="/searcher">ライブ検索はこちら</a></SearcherLink>
          </Head>
          
          <div id={'timetable'}>
            <TTContainer>
              <HeadTable className='table table-bordered'>
                <Tbody>
                  <Title>
                    <Td style={{width: 110}}>タイトル</Td>
                    <Td><TextLeftInput name="title" value={timeTable.title} onChange={ this.change }/></Td>
                  </Title>
                  <EventDate>
                    <Td>日付</Td>
                    <Td><TextLeftInput name="eventDate" type='date' value={timeTable.eventDate} onChange={ this.change }/></Td>
                  </EventDate>
                  <Place>
                    <Td>場所</Td>
                    <Td><TextLeftInput name="place" value={timeTable.place} onChange={ this.change }/></Td>
                  </Place>
                  <Memo>
                    <Td>備考</Td>
                    <Td><TextArea name="memo" value={timeTable.memo} onChange={ this.change }/></Td>
                  </Memo>
                </Tbody>
              </HeadTable>
              <Rehearsal>
                <TimesContainer>
                  <DefaultPlayTime>
                    <Text>持ち時間:</Text>
                    <Select name='rehearsalPlayTime' value={timeTable.rehearsalPlayTime} style={{width: 100}} onChange={ this.change }>
                      {
                        playTimes.map((time, index) => {
                        return <option key={index} value={time}>{time}</option>
                        })
                      }
                      </Select>
                    <Text>分</Text>
                  </DefaultPlayTime>
                  <DefaultSettingTime>
                    <Text>転換時間:</Text>
                    <Select name='rehearsalSettingTime' value={timeTable.rehearsalSettingTime} style={{width: 100}} onChange={ this.change }>
                      {
                        settingTimes.map((time, index) => {
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
                    timeTable.rehearsals.map((record, index) => {
                      return <Tr key={index}>
                        <Td style={{width: 80}} >{record.order}</Td>
                        <Td><Input name='bandName' value={record.bandName} onChange={ e => { this.changeRehearsalRecord(e, index) } } /></Td>
                        <Td style={{width: 200}}>{this.calculateRehearsalTime(index)}</Td>
                        <Td style={{width: 100}}>
                          <Select name='customPlayTime' value={record.customPlayTime || timeTable.rehearsalPlayTime} onChange={ e => { this.changeRehearsalRecord(e, index) } }>
                          {
                            playTimes.map((time, index) => {
                            return <option key={index} value={time}>{time}</option>
                            })
                          }
                          </Select>
                        </Td>
                        <Td style={{width: 100}}>
                          <Select name='customSettingTime' disabled={index==0} value={record.customSettingTime || timeTable.rehearsalSettingTime} onChange={ e => { this.changeRehearsalRecord(e, index) } }>
                          {
                            settingTimes.map((time, index) => {
                            return <option key={index} value={time}>{time}</option>
                            })
                          }
                          </Select>
                        </Td>
                        <Td><Input name='memo' value={record.memo} onChange={ e => { this.changeRehearsalRecord(e, index) } }/></Td>
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
                  <TimeInput placeholder='顔合わせ' name='meetingTime' type='time' value={timeTable.meetingTime} onChange={ this.change }/>
                </Meeting>
                <Open>
                  <div style={{width: 80}}>OPEN:</div>
                  <TimeInput placeholder='12:00' name='openTime' type='time' value={timeTable.openTime} onChange={ this.change }/>
                </Open>
                <Start>
                  <div style={{width: 80}}>START:</div>
                  <TimeInput placeholder='Start'  name='startTime'type='time' value={timeTable.startTime} onChange={ this.change }/>
                </Start>
              </TimesContainer>
              <Production>
                <TimesContainer>
                  <DefaultPlayTime>
                    <Text>持ち時間:</Text>
                    <Select name='productionPlayTime' value={timeTable.productionPlayTime} style={{width: 100}} onChange={ this.change }>
                      {
                        playTimes.map((time, index) => {
                        return <option key={index} value={time}>{time}</option>
                        })
                      }
                      </Select>
                    <Text>分</Text>
                  </DefaultPlayTime>
                  <DefaultSettingTime>
                    <Text>転換時間:</Text>
                    <Select name='productionSettingTime' value={timeTable.productionSettingTime} style={{width: 100}}  onChange={ this.change }>
                      {
                        settingTimes.map((time, index) => {
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
                    {timeTable.concerts.map((record, index) => {
                      return <Tr key={index}>
                        <Td style={{width: 80}} >{record.order}</Td>
                        <Td><Input name='bandName' value={record.bandName} onChange={ e => { this.changeProductionRecord(e, index) } } /></Td>
                        <Td style={{width: 200}}>{this.calculateProductionTime(index)}</Td>
                        <Td style={{width: 100}}>
                          <Select name='customPlayTime' value={record.customPlayTime || timeTable.productionPlayTime} onChange={ e => { this.changeProductionRecord(e, index) } }>
                          {
                            playTimes.map((time, index) => {
                            return <option key={index} value={time}>{time}</option>
                            })
                          }
                          </Select>
                        </Td>
                        <Td style={{width: 100}}>
                          <Select name='customSettingTime' disabled={index==0} value={record.customSettingTime || timeTable.productionSettingTime} onChange={ e => { this.changeProductionRecord(e, index) } }>
                          {
                            settingTimes.map((time, index) => {
                            return <option key={index} value={time}>{time}</option>
                            })
                          }
                          </Select>
                        </Td>

                        <Td><Input name='memo' value={record.memo} onChange={ e => { this.changeProductionRecord(e, index) } }/></Td>
                      </Tr>
                    }
                    )}
                  </Tbody>
                </Table>
              </Production>
              <Operation>
                <ButtonArea>
                  <ExportButton type="submit" onClick={this.exportAsPdf} className='btn btn-secondary btn-sm' >PDFを出力</ExportButton>
                </ButtonArea>
              </Operation>
            </TTContainer>
          </div>
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
  display: block;
`

const Description = styled.div`
  text-align: center;
  font-size: 40px;
`

const SearcherLink = styled.div`
  text-align: center;
  font-size: 17px;
  margin-bottom: 20px
`

const Logo = styled.img`
  max-width: 400px;
  max-height: 176px;
  margin: 0px auto;
  margin-bottom: 30px;
  display: block;
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
  margin-bottom: 30px;
`

const Operation = styled.div`
  display: flex;
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

const ExportButton = styled.button`
  margin: 0px 5px;
`
