import React from "react"
import PropTypes from "prop-types"
class TimeTable extends React.Component {
  render () {
    return (
      <React.Fragment>
        TimeTable
        <h1>Test</h1>
      </React.Fragment>
    );
  }
}

TimeTable.propTypes = {
  greeting: PropTypes.string
};
export default TimeTable
