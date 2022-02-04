import { Component, OnInit } from '@angular/core';
import { User } from 'src/app/models/user';
import { AuthService } from 'src/app/Services/auth.service';
import { CartService } from 'src/app/Services/cart.service';

@Component({
  selector: 'app-user-profile',
  templateUrl: './user-profile.component.html',
  styleUrls: ['./user-profile.component.css']
})
export class UserProfileComponent implements OnInit {

  lastOrders: any =[]
  userInfo :  any =[]
  userId : any
  index = 0

  constructor( private cartService : CartService,
    private authService : AuthService) { }

  ngOnInit(): void {
    this.getMyOrders();
    this.getMyDetails();
  }

  getMyOrders(){
    this.userId = localStorage.getItem('userid');

    this.cartService.getMyOrders(this.userId).subscribe(result =>{
      // console.log(result);

        this.lastOrders = result;
    });

  }

  getMyDetails(){

    this.userId = localStorage.getItem('userid');

    this.authService.getUserDetails(this.userId).subscribe((success : any) =>{
      // console.log(success);
      this.userInfo = success;
      // console.log(this.userInfo);
    })


  }

}
