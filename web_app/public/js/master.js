'use strict';

async function initPatientProfile() {
    const response = await fetch('/api/patient/profile/1');
    const json = await response.json();
    const data = json[0];

    const childProfile = new ChildProfile({firstName: data.firstName, lastName: data.lastName, age: data.age});
    const parentProfile = new ParentProfile({firstName: data.parentFirstName, lastName: data.parentLastName, email: data.mail, phone: data.phoneNumber, city: data.city});

    ReactDOM.render( childProfile.render(), document.getElementById('child-profile-content') );
    ReactDOM.render( parentProfile.render(), document.getElementById('parent-profile-content') );
}

async function initDoctorProfile() {
    const response = await fetch('/api/doctor/profile/3');
    const json = await response.json();
    const data = json[0];

    const doctorProfile = new DoctorProfile({firstName: data.firstName, lastName: data.lastName, email: data.mail, clinic: data.clinic, city: data.city});

    ReactDOM.render( doctorProfile.render(), document.getElementById('doctor-profile-content') );
}
