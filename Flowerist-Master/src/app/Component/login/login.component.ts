import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { FormBuilder, FormControl, FormGroup, Validators } from '@angular/forms';
import { AuthService } from 'src/app/Services/auth.service';
import { LoginDetails } from 'src/app/models/logindetails';
import { CartService } from 'src/app/Services/cart.service';
import { map } from 'rxjs';

@Component({
  selector: 'app-login',
  templateUrl: './login.component.html',
  styleUrls: ['./login.component.css']
})
export class LoginComponent implements OnInit {

  userid : any
  loginForm: FormGroup;

  constructor(     private authService: AuthService,
    private formBuilder: FormBuilder,
    ) {

    this.loginForm = formBuilder.group({
          email: new FormControl('', [
            Validators.required,
            Validators.minLength(3),
            Validators.maxLength(30),
            Validators.pattern('^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+.[a-zA-Z0-9-.]+$')
          ]),

          password: new FormControl('', [
            Validators.required,
            Validators.minLength(6),
            Validators.maxLength(12)

          ])

    });
  }


  onLoginSubmit() {
    if(this.loginForm.invalid){
      alert('Please Enter Correct Information')
    }

      const loginDetails : LoginDetails ={
        email: this.loginForm.value.email,
        password : this.loginForm.value.password
      }


      this.authService.getLogin(loginDetails);

      this.userid = localStorage.getItem('userid');
  }


  ngOnInit(): void {
  }



  get loginFormControl() {
    return this.loginForm.controls;
  }

}
