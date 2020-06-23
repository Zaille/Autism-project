'use strict';

/** Profile class **/
class Profile extends React.Component {
    constructor(props) {
        super(props);

        this.state = {
            update: 0,
            firstName: props.firstName,
            lastName: props.lastName
        }
        this.switch = this.switch.bind(this);
    }

    updateProfile(value) {
        this.setState(value);
    }

    async switch(path) {
        if( this.state.update ) {
            if (confirm('Are you sure you want to change your information ?')) {

                let body = {};
                Object.keys(this.state).forEach( key => {
                    if( key !== 'update' ) body[key] = this.state[key];
                });

                const result = await fetch(path + '1', {
                    method: 'POST',
                    headers: {
                        'Accept': 'application/json',
                        'Content-Type': 'application/json'
                    },
                    body: JSON.stringify(body)
                });

                if( result.ok ) this.setState({update: 0})
                else console.log('Problème !'); // TODO
            }
        } else {
            this.setState({update : 1});
        }
    }
}

class ChildProfile extends Profile {

    constructor(props) {
        super(props);

        this.state.age = props.age;
    }

    render() {
        if( this.state.update ){
            return (
                <div id='child-profile'>
                    <h2 id='child-profile-title' className='first-row'>Child</h2>

                    <p className='first-column second-row th'>First Name</p>
                    <input type='text' value={this.state.firstName} id='chidlFirstName'
                           className='second-column second-row input-text'
                           onChange={e => this.updateProfile({firstName: e.target.value})}/>

                    <p className='first-column third-row th'>Last Name</p>
                    <input type='text' value={this.state.lastName} id='childLastName'
                           className='second-column third-row input-text'
                           onChange={e => this.updateProfile({lastName: e.target.value})}/>

                    <p className='third-column second-row th'>Age</p>
                    <input type='text' value={this.state.age} id='childAge'
                           className='fourth-column second-row input-text'
                           onChange={e => this.updateProfile({age: e.target.value})}/>

                    <input type='button' value='Update' id='childUpdateInfo'
                           className='gradientBlue fiveth-column third-row update'
                           onClick={() => this.switch('/api/child/profile/')}/>
                </div>
            );
        }  else {
            return (
                <div id='child-profile'>
                    <h2 id='child-profile-title' className='first-row'>Child</h2>

                    <p className='first-column second-row th'>First Name</p>
                    <p id='chidlFirstName' className='second-column second-row td'>{this.state.firstName}</p>

                    <p className='first-column third-row th'>Last Name</p>
                    <p id='childLastName' className='second-column third-row td'>{this.state.lastName}</p>

                    <p className='third-column second-row th'>Age</p>
                    <p id='childAge' className='fourth-column second-row td'>{this.state.age}</p>

                    <input type='button' value='Update' id='childUpdateInfo'
                           className='gradientBlue fiveth-column third-row update'
                           onClick={this.switch}/>
                </div>
            );
        }
    }
}

class ParentProfile extends Profile {

    constructor(props) {
        super(props);

        this.state.email = props.email;
        this.state.phone = props.phone;
        this.state.city = props.city;
    }

    render() {
        if( this.state.update ) {
            return (
                <div id='parent-profile'>
                    <h2 id='parent-profile-title' className='first-row'>Parent</h2>

                    <p className='first-column second-row th'>First Name</p>
                    <input type='text' value={this.state.firstName} id='parentFirstName'
                           className='second-column second-row input-text'
                           onChange={e => this.updateProfile({firstName: e.target.value})}/>

                    <p className='first-column third-row th'>Last Name</p>
                    <input type='text' value={this.state.lastName} id='parentLastName'
                           className='second-column third-row input-text'
                           onChange={e => this.updateProfile({lastName: e.target.value})}/>

                    <p className='first-column fourth-row th'>Email</p>
                    <input type='text' value={this.state.email} id='parentMail'
                           className='second-column fourth-row input-text'
                           onChange={e => this.updateProfile({email: e.target.value})}/>

                    <p className='third-column second-row th'>Phone</p>
                    <input type='text' value={this.state.phone} id='parentPhone'
                           className='fourth-column second-row input-text'
                           onChange={e => this.updateProfile({phone: e.target.value})}/>

                    <p className='third-column third-row th'>City</p>
                    <input type='text' value={this.state.city} id='parentCity'
                           className='fourth-column third-row input-text'
                           onChange={e => this.updateProfile({city: e.target.value})}/>

                    <input type='button' value='Update' id='parentUpdateInfo'
                           className='gradientBlue fiveth-column fourth-row update'
                           onClick={() => this.switch('/api/parent/profile/')}/>
                </div>
            );
        } else {
            return (
                <div id='parent-profile'>
                    <h2 id='parent-profile-title' className='first-row'>Parent</h2>

                    <p className='first-column second-row th'>First Name</p>
                    <p id='parentFirstName' className='second-column second-row td'>{this.state.firstName}</p>

                    <p className='first-column third-row th'>Last Name</p>
                    <p id='parentLastName' className='second-column third-row td'>{this.state.lastName}</p>

                    <p className='first-column fourth-row th'>Email</p>
                    <p id='parentMail' className='second-column fourth-row td'>{this.state.email}</p>

                    <p className='third-column second-row th'>Phone</p>
                    <p id='parentPhone' className='fourth-column second-row td'>{this.state.phone}</p>

                    <p className='third-column third-row th'>City</p>
                    <p id='parentCity' className='fourth-column third-row td'>{this.state.city}</p>

                    <input type='button' value='Update' id='parentUpdateInfo'
                           className='gradientBlue fiveth-column fourth-row update'
                           onClick={this.switch}/>
                </div>
            );
        }
    }
}

class DoctorProfile extends Profile {

    constructor(props) {
        super(props);

        this.state.email = props.email;
        this.state.clinic = props.clinic;
        this.state.city = props.city;
    }

    render() {
        if( this.state.update ){
            return (
                <div id='doctor-profile'>
                    <h2 id='doctor-profile-title' className='first-row'>Parent</h2>

                    <p className='first-column second-row th'>First Name</p>
                    <input type='text' value={this.state.firstName} id='doctorFirstName'
                           className='second-column second-row input-text'
                           onChange={e => this.updateProfile({firstName: e.target.value})}/>

                    <p className='first-column third-row th'>Last Name</p>
                    <input type='text' value={this.state.lastName} id='doctorLastName'
                           className='second-column third-row input-text'
                           onChange={e => this.updateProfile({lastName: e.target.value})}/>

                    <p className='first-column fourth-row th'>Email</p>
                    <input type='text' value={this.state.email} id='doctorMail'
                           className='second-column fourth-row input-text'
                           onChange={e => this.updateProfile({email: e.target.value})}/>

                    <p className='third-column second-row th'>Clinic</p>
                    <input type='text' value={this.state.clinic} id='doctorPhone'
                           className='fourth-column second-row input-text'
                           onChange={e => this.updateProfile({clinic: e.target.value})}/>

                    <p className='third-column third-row th'>City</p>
                    <input type='text' value={this.state.city} id='doctorCity'
                           className='fourth-column third-row input-text'
                           onChange={e => this.updateProfile({city: e.target.value})}/>

                    <input type='button' value='Update' id='doctorUpdateInfo'
                           className='gradientBlue fiveth-column fourth-row update'
                           onClick={this.switch}/>
                </div>
            );
        } else {
            return (
                <div id='doctor-profile'>
                    <h2 id='doctor-profile-title' className='first-row'>Parent</h2>

                    <p className='first-column second-row th'>First Name</p>
                    <p id='doctorFirstName' className='second-column second-row td'>{this.state.firstName}</p>

                    <p className='first-column third-row th'>Last Name</p>
                    <p id='doctorLastName' className='second-column third-row td'>{this.state.lastName}</p>

                    <p className='first-column fourth-row th'>Email</p>
                    <p id='doctorMail' className='second-column fourth-row td'>{this.state.email}</p>

                    <p className='third-column second-row th'>Clinic</p>
                    <p id='doctorPhone' className='fourth-column second-row td'>{this.state.clinic}</p>

                    <p className='third-column third-row th'>City</p>
                    <p id='doctorCity' className='fourth-column third-row td'>{this.state.city}</p>

                    <input type='button' value='Update' id='doctorUpdateInfo'
                           className='gradientBlue fiveth-column fourth-row update'
                           onClick={this.switch}/>
                </div>
            );
        }
    }
}