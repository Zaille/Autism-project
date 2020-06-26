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

    ReactDOM.render( <DoctorProfile firstName={data.firstName} lastName={data.lastName} email={data.mail}
                                    clinic={data.clinic} city={data.city} />,
                                    document.getElementById('doctor-profile-content') );
}

async function updatePassword() {

    const currentPass = document.getElementById('current-password').value;
    const newPass = document.getElementById('new-password').value;
    const repeatPass = document.getElementById('repeat-password').value;

    if( currentPass && newPass && repeatPass ) {

        if (confirm('Are you sure you want to change your password ?')) {

            if (newPass === repeatPass) {

                const response = await fetch('/api/password/3');
                const json = await response.json();
                const data = json[0];

                if (data.password === currentPass) {

                    const result = await fetch('/api/password/3', {
                        method: 'POST',
                        headers: {
                            'Accept': 'application/json',
                            'Content-Type': 'application/json'
                        },
                        body: JSON.stringify({newPass: newPass})
                    });

                    if (result.ok) {

                        ReactDOM.render(
                            <p className='validation'>Your password has been updated</p>,
                            document.getElementById('doctor-password-update')
                        );

                        document.getElementById('current-password').value = '';
                        document.getElementById('new-password').value = '';
                        document.getElementById('repeat-password').value = '';

                        setTimeout(function () {
                            ReactDOM.render(
                                '',
                                document.getElementById('doctor-password-update')
                            );
                        }, 5000);

                    }
                    else {
                        ReactDOM.render(
                            <p className='error'>A problem occured during the update of your password</p>,
                            document.getElementById('doctor-password-update')
                        );
                    }

                } else {
                    ReactDOM.render(
                        <p className='error'>Incorrect password</p>,
                        document.getElementById('doctor-password-update')
                    );
                }
            } else {
                ReactDOM.render(
                    <p className='error'>Passwords must be identic</p>,
                    document.getElementById('doctor-password-update')
                );
            }
        }
    } else {
        ReactDOM.render(
            <p className='error'>Empty fields</p>,
            document.getElementById('doctor-password-update')
        );
    }
}
