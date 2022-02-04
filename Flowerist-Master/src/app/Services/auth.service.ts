import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Router } from '@angular/router';
import { Observable, Subject } from 'rxjs';

import { LoginDetails } from '../models/logindetails';
import { User } from '../models/user';

@Injectable({
  providedIn: 'root'
})
export class AuthService {
  private isAuthenticated = false;
  private token : string='';
  private tokenTimer: any;
  private authStatusListener = new Subject<boolean>();
  private userid :any;
  localcart : any=[]
  cart : any =[]

  baseUrl = 'http://localhost:3000';

  constructor(private http : HttpClient,
    private router : Router) {
  }
  getToken(){
    return this.token;
  }

  createUser(newUser : User) {
    return this.http.post(`${this.baseUrl}/app/register`, newUser);
  }

  getLogin(login : LoginDetails){
     this.http.post<{token : string;userid : any;}>(`${this.baseUrl}/app/login`,login)
      .subscribe(response =>{
        this.token = response.token;
      const tokenNew = response.token;
      const userid = response.userid;

      console.log('in auth service : token',userid);

      if(response.userid==='admin'){
        this.storeToken(tokenNew,userid);
        this.router.navigate(['adminpanel']);
      }else{
        this.storeToken(tokenNew,userid);
        this.router.navigate(['homepage']);
      }
     },error=>{
       alert('Invalid Credentials')
     })
  }

  storeToken(token : string,userid : number){

    this.isAuthenticated = true;
    this.authStatusListener.next(true);
    this.userid = userid;
    localStorage.setItem('userid',JSON.stringify(userid));
    this.authStatusListener.next(true);
    localStorage.setItem('token',JSON.stringify(token));
    alert('Login Successfully');
    // localStorage.setItem('username',JSON.stringify(token.email));
  }

  saveAuthData(token : string, expirationDate : Date){
    localStorage.setItem("token", token);
    localStorage.setItem("expiration", expirationDate.toISOString());
  }

  autoAuthUser() {
    const authInformation = this.getAuthData();
    if (!authInformation) {
      // this.router.navigate(['/homepage'])
      return ;
    }
    // const now = new Date();
    // const expiresIn = authIif (expiresIn > 0) {
      this.token = authInformation.token;
      this.isAuthenticated = true;
      // this.setAuthTimer(expiresIn / 1000);
      this.authStatusListener.next(true);
    // }
  }


  private getAuthData() {
    const token = localStorage.getItem("token");
    // const expirationDate = localStorage.getItem("expiration");
    if (!token ) {
      return;
    }
    return {
      token: token
    }
  }

  getIsAuth(){

    return this.isAuthenticated;
  }

  private setAuthTimer(duration: number) {
    console.log("Setting timer: " + duration);
    this.tokenTimer = setTimeout(() => {
      this.logout();
    }, duration * 1000);
  }

  getAuthStatusListener(){
    return this.authStatusListener.asObservable();
  }

  logout(){
    this.isAuthenticated = false;
    this.authStatusListener.next(false);
    clearTimeout(this.tokenTimer)
    localStorage.removeItem('username')
    localStorage.removeItem('cart');
    localStorage.removeItem('userid')
    this.clearAuthData();
    this.router.navigate(['login']);

  }
  private clearAuthData() {
    localStorage.removeItem("token");

  }

  getUserId(){
    return this.userid
  }

  getUserDetails(id : any){

    let userId = {userid : id};

    return this.http.post<{details : User}>(`${this.baseUrl}/app/myprofile`,userId);

  }


}
