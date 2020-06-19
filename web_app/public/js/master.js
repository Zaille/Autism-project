'use strict';

async function initPatientProfile() {
    const response = await fetch('/api/patient/profile/2');
    const json = await response.json();
    const data = json[0];

    console.log(data);

    ReactDOM.render( data.firstName, document.getElementById('chidlFirstName') );
    ReactDOM.render( data.lastName, document.getElementById('childLastName') );
    ReactDOM.render( data.age, document.getElementById('childAge') );
    ReactDOM.render( data.parentFirstName, document.getElementById('parentFirstName') );
    ReactDOM.render( data.parentLastName, document.getElementById('parentLastName') );
    ReactDOM.render( data.mail, document.getElementById('parentMail') );
    ReactDOM.render( data.phoneNumber, document.getElementById('parentPhone') );
    ReactDOM.render( data.city, document.getElementById('parentCity') );

    // document.getElementById('childUpdateInfo').addEventListener( 'click', () => {
    //     console.log('ici');
    //     ReactDOM.render( <input type='text'>{data.firstName}</input>, document.getElementById('chidlFirstName') );
    //     ReactDOM.render( <input type='text'>{data.lastName}</input>, document.getElementById('childLastName') );
    //     ReactDOM.render( <input type='text'>{data.age}</input>, document.getElementById('childAge') );
    // });
    //
    // document.getElementById('parentUpdateInfo').addEventListener( 'click', () => {
    //     console.log('la');
    //     ReactDOM.render(<input type='text'>{data.parentFirstName}</input>, document.getElementById('parentFirstName'));
    //     ReactDOM.render(<input type='text'>{data.parentLastName}</input>, document.getElementById('parentLastName'));
    //     ReactDOM.render(<input type='text'>{data.mail}</input>, document.getElementById('parentMail'));
    //     ReactDOM.render(<input type='text'>{data.phoneNumber}</input>, document.getElementById('parentPhone'));
    //     ReactDOM.render(<input type='text'>{data.city}</input>, document.getElementById('parentCity'));
    // });
}

async function initDoctorProfile() {
    const response = await fetch('/api/doctor/profile/2');
    const json = await response.json();
    const data = json[0];

    console.log(data);

    // const name = 'Josh Perez';
    // const element = <h1>Hello, {name}</h1>;
    //
    // ReactDOM.render(
    //     element,
    //     document.getElementById('root')
    // );
}
