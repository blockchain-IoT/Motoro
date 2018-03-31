/* eslint-disable react/prop-types,react/jsx-key */
import React from 'react';

const machineList = (props) => {
  const vins = props.machines.map(machine => <li> {machine.vin} </li>);
  const addresses = props.machines.map(machine => <li> {machine.address} </li>);

  return (

    <div className="uk-card uk-card-default uk-card-body">
      <h3 className="uk-card-title">Machines</h3>
      <p>Machines registered so far</p>
      <div className="uk-child-width-expand@s uk-grid ">
        <div>
          <h5>Vin</h5>
          <ul className="uk-list uk-list-large">
            {vins}
          </ul>
        </div>
        <div>
          <h5>Address</h5>
          <ul className="uk-list uk-list-large">
            {addresses}
          </ul>
        </div>
      </div>
    </div>
  );
};


export default machineList;

