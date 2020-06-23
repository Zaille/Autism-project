'use strict';

async function initPatientProfile() {
    const response = await fetch('/api/patient/profile/1');
    const json = await response.json();
    const data = json[0];

    ReactDOM.render(<ChildProfile firstName={data.firstName} lastName={data.lastName}
                                  age={data.age}/>, document.getElementById('child-profile-content'));
    ReactDOM.render(<ParentProfile firstName={data.parentFirstName} lastName={data.parentLastName} email={data.mail}
                                   phone={data.phoneNumber}
                                   city={data.city}/>, document.getElementById('parent-profile-content'));
}

async function initDoctorProfile() {
    const response = await fetch('/api/doctor/profile/3');
    const json = await response.json();
    const data = json[0];

    const doctorProfile = new DoctorProfile({firstName: data.firstName, lastName: data.lastName, email: data.mail, clinic: data.clinic, city: data.city});

    ReactDOM.render( doctorProfile.render(), document.getElementById('doctor-profile-content') );
}

async function updatePassword() {

    if (confirm('Are you sure you want to change your password ?')) {

        const currentPass = document.getElementById('current-password').value;
        const newPass = document.getElementById('new-password').value;
        const repeatPass = document.getElementById('repeat-password').value;

        if (newPass === repeatPass) {

            const response = await fetch('/api/password/1');
            const json = await response.json();
            const data = json[0];

            if( data.password === currentPass ){

                const result = await fetch('/api/password/1', {
                    method: 'POST',
                    headers: {
                        'Accept': 'application/json',
                        'Content-Type': 'application/json'
                    },
                    body: JSON.stringify({newPass : newPass})
                });

                console.log(result);
                if( result.ok ) console.log('Mot de passe modifié !')
                else console.log('Problème lors de la modification du mot de passe'); // TODO

            } else {
                console.log('Mot de passe incorrect');
            }
        } else {
            console.log('Mot de passe non identique');
        }
    }
}
