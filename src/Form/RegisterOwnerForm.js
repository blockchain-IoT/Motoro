/* eslint-disable react/prop-types */
import React from 'react';

const registerOwnerForm = props => (
  <div className="uk-card uk-card-default uk-card-body uk-width-1-2@m">
    <h3 className="uk-card-title">Register new Owner</h3>
    <p>Lorem ipsum <a href="#">dolor</a> sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.</p>
    <form>
      <fieldset className="uk-fieldset">
        <div className="uk-margin">
          <button className="uk-button uk-button-default"
            disabled={props.state._disabled} onClick={props.onSubmit}>Register</button>
        </div>

      </fieldset>
    </form>
  </div>
);


export default registerOwnerForm;

