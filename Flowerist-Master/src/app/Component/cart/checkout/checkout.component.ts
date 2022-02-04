import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { CartService } from 'src/app/Services/cart.service';

@Component({
  selector: 'app-checkout',
  templateUrl: './checkout.component.html',
  styleUrls: ['./checkout.component.css']
})
export class CheckoutComponent implements OnInit {

  cart: any =[]
  cartItem: any =[]
  dbCart : any =[]
  emptyarray : any =[]
  total = 0;
  totalQuantity = 0
  userid : any


  constructor(private cartService : CartService,
    private router : Router) {
      this.cartItem = localStorage.getItem('cart');
      this.userid = localStorage.getItem('userid');
      console.log(this.userid);

     this.cart = JSON.parse(this.cartItem);
     console.log('in checkout ',this.cart);

     // this.loadCart();
     this.getTotal();
     }

  ngOnInit(): void {
    //  this.cartItem = localStorage.getItem('cart');
    //  this.userid = localStorage.getItem('userid');
    //  console.log(this.userid);

    // this.cart = JSON.parse(this.cartItem);
    // console.log('in checkout ',this.cart);

    // // this.loadCart();
    // this.getTotal();
  }



  getTotal() : any {
    this.total = 0;
    this.cart.forEach((item: any) => {
      this.total += item.productPrice * item.productQuantity;
    });

  }

  getQuantity(){
    this.totalQuantity = 0;
    for (let index = 0; index < this.cart.length; index++) {
      this.totalQuantity += this.cart[index].productQuantity;

    }
  }


  checkOut(){
    // this.userid = localStorage.getItem('userid');

    for (let index = 0; index < this.cart.length; index++) {
      const element = this.cart[index];
      const totalprice = (element.productQuantity * element.productPrice)

      const item ={
        userid: this.userid,
        productid: element.productId,
        productname:element.productName,
        quantity: element.productQuantity,
        price:element.productPrice,
        total:totalprice
      }

      console.log(item);

      this.cartService.placeOrder(item).subscribe(response=>{
        console.log('Product Added');
      });

      localStorage.removeItem('cart');
      // localStorage.setItem('cart',JSON.stringify(this.emptyarray))

    }
      alert('Order Placed..')
      this.router.navigate(['/homepage']);
  }

  loadCart(){

    this.cartService.loadDBCart(this.userid).subscribe(success=>{
      this.dbCart = success;
      console.log('loadCart : ',this.dbCart);


    })
  }

}
