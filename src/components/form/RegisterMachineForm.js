import React from 'react';

const registerMachineForm = (props) => {
    return (
        <div className="uk-card uk-card-default uk-card-body">
            <h3 className="uk-card-title">Register new Machine</h3>
            <p>After creating MachineOwner contract you should be able to register new Machine</p>
            <form>
                <fieldset className="uk-fieldset">

                    <div className="uk-margin">
                        <input className="uk-input" type="text" placeholder="Model" name="model"
                            onChange={props.onChange} value={props.state.model} />
                    </div>

                    <div className="uk-margin">
                        <input className="uk-input" type="text" placeholder="Make" name="make"
                            onChange={props.onChange} value={props.state.make} />
                    </div>

                    <div className="uk-margin">
                        <input className="uk-input" type="text" placeholder="VIN" name="vin"
                            onChange={props.onChange} value={props.state.vin} />
                    </div>

                    <div className="uk-margin">
                        <button className="uk-button uk-button-default"
                        disabled={props.state._disabled} onClick={props.onSubmit}>Register</button>
                    </div>

                </fieldset>
            </form>
        </div>
    );
};


export default registerMachineForm;

