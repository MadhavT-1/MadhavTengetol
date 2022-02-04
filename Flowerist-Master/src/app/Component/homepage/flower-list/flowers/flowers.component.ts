import { Component, Input, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { AuthService } from 'src/app/Services/auth.service';
import { CartService } from 'src/app/Services/cart.service';

@Component({
  selector: 'app-flowers',
  templateUrl: './flowers.component.html',
  styleUrls: ['./flowers.component.css']
})
export class FlowersComponent implements OnInit {
  isAuthenticated = false;


  @Input()
   flowerItem : any;

   productquantity : number =1;


  constructor(private cartService : CartService,
    private authService : AuthService,
    private router : Router) { }

  ngOnInit(): void {
    this.isAuthenticated=this.authService.getIsAuth();
  }

  handleAddToCart(){

    if(!this.isAuthenticated){
      this.router.navigate(['login']);
    }

    this.cartService.sendItem(this.flowerItem,this.productquantity);
  }


}
