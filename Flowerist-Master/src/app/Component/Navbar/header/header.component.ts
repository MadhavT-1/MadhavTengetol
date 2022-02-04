import { Component, OnDestroy, OnInit } from '@angular/core';
import { Subscription } from 'rxjs';
import { AuthService } from 'src/app/Services/auth.service';
import { CartService } from 'src/app/Services/cart.service';

@Component({
  selector: 'app-header',
  templateUrl: './header.component.html',
  styleUrls: ['./header.component.css']
})
export class HeaderComponent implements OnInit, OnDestroy {
  userIsAuthenticated = false;
  private authListenerSub: Subscription = new Subscription;
  cart: any =[]
  newCart: any =[]
  username : any ;
  cartlength : any
  userid: any

  constructor(private authService : AuthService,
    private cartService : CartService) { }

  ngOnInit(): void {

   this.userIsAuthenticated=this.authService.getIsAuth();
   this.username =localStorage.getItem('userid')
   console.log('in header ',this.username);


   this.authListenerSub = this.authService
   .getAuthStatusListener()
   .subscribe(isAuthenticated => {
     this.userIsAuthenticated = isAuthenticated;

   });

  //  this.newCart = localStorage.getItem('cart');
  //  this.cart = JSON.parse(this.newCart)
  //  console.log('in header ',this.cart);


  //  this.cartlength = this.cart.length;



  }



  onLogout(){

    this.newCart = localStorage.getItem('cart');
    this.cart = JSON.parse(this.newCart);

    // const userid = localStorage.getItem('userid')
    // console.log('In Header logout',userid);


    // this.cart.forEach((item: any) => {
    //   let cartItem = {
    //     productid: this.cart.productId,
    //     userid:userid,
    //     producname: this.cart.productName,
    //     productprice:this.cart.productPrice,
    //     quantity:this.cart.productQuantity
    //   }
    //   alert(cartItem)
    //   this.cartService.addProductToCart(cartItem).subscribe(result=>{
    //     console.log("products added to cart ..",result);

    //   })
    // });

    // for (let index = 0; index < this.cart.length; index++) {
    //   let cartItem = {
    //     productid: this.cart[index].productId,
    //     userid:userid,
    //     productname: this.cart[index].productName,
    //     productprice:this.cart[index].productPrice,
    //     quantity:this.cart[index].productQuantity
    //   }

    //   // this.cartService.addProductToCart(cartItem).subscribe(result=>{
    //   //   console.log("products added to cart ..",result);
    //   // });

    // }

    this.authService.logout();
  }

  ngOnDestroy(): void {
    this.authListenerSub.unsubscribe();

  }
}
