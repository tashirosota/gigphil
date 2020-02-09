import React from "react"
import styled from 'styled-components'
import swal from 'sweetalert';
import axios from "axios";
import { IoIosClose, IoIosMenu } from "react-icons/io";

export default class ArtistList extends React.Component {
  constructor(props){
    super(props)
    this.state = {
      example: this.props.example

    }

    this.hoo = this.hoo.bind(this) 
  }

  hoo(){
    this.setState({ visiable: true })
  }

  render () {
    const { example } = this.state
    return (
      <React.Fragment>  
      </React.Fragment>
    )
  }
}