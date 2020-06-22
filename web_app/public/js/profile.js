'use strict';

/** Profile class **/
class Profile extends React.Component {
    constructor(props) {
        super(props);

        this.update = 0;
        this.profile = {
            firstName: props.firstName,
            lastName: props.lastName,
        }
        this.switch = this.switch.bind(this);
    }

    switch(id) {
        this.setUpdate();

        if( this.update ) ReactDOM.render( this.renderUpdating(), document.getElementById(id) );
        else ReactDOM.render( this.render(), document.getElementById(id) );
    }

    setUpdate() {
        this.update ? this.update = 0 : this.update = 1;
    }
}

class ChildProfile extends Profile {

    constructor(props) {
        super(props);

        this.profile.age = props.age;
    }

    render() {
        return (
            <div id='child-profile'>
                <h2 id='child-profile-title' className='first-row'>Child</h2>

                <p className='first-column second-row th'>First Name</p>
                <p id='chidlFirstName' className='second-column second-row td'>{this.profile.firstName}</p>

                <p className='first-column third-row th'>Last Name</p>
                <p id='childLastName' className='second-column third-row td'>{this.profile.lastName}</p>

                <p className='third-column second-row th'>Age</p>
                <p id='childAge' className='fourth-column second-row td'>{this.profile.age}</p>

                <input type='button' value='Update' id='childUpdateInfo' className='gradientBlue fiveth-column third-row update' onClick={() => this.switch('child-profile-content')}/>
            </div>
        );
    }

    renderUpdating() {
        return (
            <div id='child-profile'>
                <h2 id='child-profile-title' className='first-row'>Child</h2>

                <p className='first-column second-row th'>First Name</p>
                <input type='text' value={this.profile.firstName} id='chidlFirstName' className='second-column second-row input-text'/>

                <p className='first-column third-row th'>Last Name</p>
                <input type='text' value={this.profile.lastName} id='childLastName' className='second-column third-row input-text'/>

                <p className='third-column second-row th'>Age</p>
                <input type='text' value={this.profile.age} id='childAge' className='fourth-column second-row input-text'/>

                <input type='button' value='Update' id='childUpdateInfo' className='gradientBlue fiveth-column third-row update' onClick={() => this.switch('child-profile-content')}/>
            </div>
        );
    }
}

class ParentProfile extends Profile {

    constructor(props) {
        super(props);

        this.profile.email = props.email;
        this.profile.phone = props.phone;
        this.profile.city = props.city;
    }

    render() {
        return (
            <div id='parent-profile'>
                <h2 id='parent-profile-title' className='first-row'>Parent</h2>

                <p className='first-column second-row th'>First Name</p>
                <p id='parentFirstName' className='second-column second-row td'>{this.profile.firstName}</p>

                <p className='first-column third-row th'>Last Name</p>
                <p id='parentLastName' className='second-column third-row td'>{this.profile.lastName}</p>

                <p className='first-column fourth-row th'>Email</p>
                <p id='parentMail' className='second-column fourth-row td'>{this.profile.email}</p>

                <p className='third-column second-row th'>Phone</p>
                <p id='parentPhone' className='fourth-column second-row td'>{this.profile.phone}</p>

                <p className='third-column third-row th'>City</p>
                <p id='parentCity' className='fourth-column third-row td'>{this.profile.city}</p>

                <input type='button' value='Update' id='parentUpdateInfo' className='gradientBlue fiveth-column fourth-row update' onClick={() => this.switch('parent-profile-content')}/>
            </div>
        );
    }

    renderUpdating() {
        return (
            <div id='parent-profile'>
                <h2 id='parent-profile-title' className='first-row'>Parent</h2>

                <p className='first-column second-row th'>First Name</p>
                <input type='text' value={this.profile.firstName} id='parentFirstName' className='second-column second-row input-text'/>

                <p className='first-column third-row th'>Last Name</p>
                <input type='text' value={this.profile.lastName} id='parentLastName' className='second-column third-row input-text'/>

                <p className='first-column fourth-row th'>Email</p>
                <input type='text' value={this.profile.email} id='parentMail' className='second-column fourth-row input-text'/>

                <p className='third-column second-row th'>Phone</p>
                <input type='text' value={this.profile.phone} id='parentPhone' className='fourth-column second-row input-text'/>

                <p className='third-column third-row th'>City</p>
                <input type='text' value={this.profile.city} id='parentCity' className='fourth-column third-row input-text'/>

                <input type='button' value='Update' id='parentUpdateInfo' className='gradientBlue fiveth-column fourth-row update' onClick={() => this.switch('parent-profile-content')}/>
            </div>
        );
    }
}

class DoctorProfile extends Profile {

    constructor(props) {
        super(props);

        this.profile.email = props.email;
        this.profile.clinic = props.clinic;
        this.profile.city = props.city;
    }

    render() {
        return (
            <div id='doctor-profile'>
                <h2 id='doctor-profile-title' className='first-row'>Parent</h2>

                <p className='first-column second-row th'>First Name</p>
                <p id='doctorFirstName' className='second-column second-row td'>{this.profile.firstName}</p>

                <p className='first-column third-row th'>Last Name</p>
                <p id='doctorLastName' className='second-column third-row td'>{this.profile.lastName}</p>

                <p className='first-column fourth-row th'>Email</p>
                <p id='doctorMail' className='second-column fourth-row td'>{this.profile.email}</p>

                <p className='third-column second-row th'>Clinic</p>
                <p id='doctorPhone' className='fourth-column second-row td'>{this.profile.clinic}</p>

                <p className='third-column third-row th'>City</p>
                <p id='doctorCity' className='fourth-column third-row td'>{this.profile.city}</p>

                <input type='button' value='Update' id='doctorUpdateInfo' className='gradientBlue fiveth-column fourth-row update' onClick={() => this.switch('doctor-profile-content')}/>
            </div>
        );
    }

    renderUpdating() {
        return (
            <div id='doctor-profile'>
                <h2 id='doctor-profile-title' className='first-row'>Parent</h2>

                <p className='first-column second-row th'>First Name</p>
                <input type='text' value={this.profile.firstName} id='doctorFirstName' className='second-column second-row input-text'/>

                <p className='first-column third-row th'>Last Name</p>
                <input type='text' value={this.profile.lastName} id='doctorLastName' className='second-column third-row input-text'/>

                <p className='first-column fourth-row th'>Email</p>
                <input type='text' value={this.profile.email} id='doctorMail' className='second-column fourth-row input-text'/>

                <p className='third-column second-row th'>Clinic</p>
                <input type='text' value={this.profile.clinic} id='doctorPhone' className='fourth-column second-row input-text'/>

                <p className='third-column third-row th'>City</p>
                <input type='text' value={this.profile.city} id='doctorCity' className='fourth-column third-row input-text'/>

                <input type='button' value='Update' id='doctorUpdateInfo' className='gradientBlue fiveth-column fourth-row update' onClick={() => this.switch('doctor-profile-content')}/>
            </div>
        );
    }
}