import React from 'react';

const machineList = (props) => (
    <div className="uk-card uk-card-default uk-card-body">
        <h3 className="uk-card-title">Machines</h3>
        <p>Machines registered so far</p>
        <ul className="uk-list uk-list-striped">
            {props.machines.map(machine => (
                <li key={machine.vin}> {machine.vin} : {machine.address}</li>
            ))}
        </ul>
    </div >
);


export default machineList;

