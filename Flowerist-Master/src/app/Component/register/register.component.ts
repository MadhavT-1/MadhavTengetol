import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormControl, FormGroup, NgForm, Validators } from '@angular/forms';
import { Router } from '@angular/router';
import { User } from 'src/app/models/user';
import { AuthService } from 'src/app/Services/auth.service';

@Component({
  selector: 'app-register',
  templateUrl: './register.component.html',
  styleUrls: ['./register.component.css']
})
export class RegisterComponent implements OnInit {
  registrationForm: FormGroup;

  constructor(private router : Router,
     private authService : AuthService,
     private formBuilder : FormBuilder
      ) {
        this.registrationForm = this.formBuilder.group({
          firstName: new FormControl('', [
            Validators.required,
            Validators.minLength(3),
            Validators.maxLength(30),
            Validators.pattern('^[a-zA-Z ]*$')]),

           lastName : new FormControl('',[
            Validators.required,
            Validators.minLength(3),
            Validators.maxLength(30),
            Validators.pattern('^[a-zA-Z ]*$')
           ]),

           email : new FormControl('',[
            Validators.required,
            Validators.minLength(3),
            Validators.maxLength(30),
            Validators.pattern('^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+.[a-zA-Z0-9-.]+$')
           ]),
           contact : new FormControl('',[
            Validators.required,
            Validators.maxLength(10)
           ]),
           address : new FormControl('',[
            Validators.required,
            Validators.minLength(3),
            Validators.maxLength(30),
            Validators.pattern('^[a-zA-Z ]*$')
           ]),
           confirmPassword : new FormControl('',[
            Validators.required,
            Validators.minLength(6),
            Validators.maxLength(10)
           ]),
           password : new FormControl('',[
            Validators.required,
            Validators.minLength(6),
            Validators.maxLength(10)

           ])

        });
        }




onRegistrationFormSubmit() {
  const user : User = this.registrationForm.value;
    if(this.registrationForm.invalid || this.registrationForm.untouched){
      alert('Form invalid');
      this.registrationForm.reset()
    }

  const confirmPassword = this.registrationForm.value.confirmPassword;

    if(user.password === confirmPassword){
      this.authService.createUser(user).subscribe(data => {
        alert('Registratn successfully...!');
        this.registrationForm.reset();
        this.router.navigate(['/login']);
      });
    }else{
      alert('Password does not match..!');
    }
}

get registrationFormControl(){
  return this.registrationForm.controls;
}

ngOnInit(): void {}

}
