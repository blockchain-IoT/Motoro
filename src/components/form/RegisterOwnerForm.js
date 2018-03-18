import React from 'react';

const registerOwnerForm = (props) => {
    return (
        <div className="uk-card uk-card-default uk-card-body">
            <h3 className="uk-card-title">Register new Owner</h3>
            <p>Create new instance of MachineOwner contract</p>
            <form>
                <fieldset className="uk-fieldset">
                    <div className="uk-margin">
                        <button className="uk-button uk-button-default" disabled={props.state._disabled}
                                onClick={props.onSubmit}>
                            Register
                        </button>
                    </div>
                </fieldset>
            </form>
        </div>
    );
};


export default registerOwnerForm;

