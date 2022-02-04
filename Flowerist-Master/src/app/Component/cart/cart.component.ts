import { Component, Input, OnDestroy, OnInit, Output } from '@angular/core';
import { NgForm } from '@angular/forms';
import { Router } from '@angular/router';
import { Subscription } from 'rxjs';
import { AuthService } from 'src/app/Services/auth.service';
import { CartService } from 'src/app/Services/cart.service';

@Component({
  selector: 'app-cart',
  templateUrl: './cart.component.html',
  styleUrls: ['./cart.component.css']
})
export class CartComponent implements OnInit , OnDestroy{
  cart : any =[];
  localCart : any =[]
  dbCart : any =[]
  index=0
  userid : any
  quantity: number
  form : NgForm
  @Input () productQuantity : any

  total: number=0;
  productTotal : any=[]

  userAuthenticated = false;
  private authStatusSub: Subscription = new Subscription;


  constructor(private cartService : CartService,
    private authService : AuthService,
    private router : Router) { }

  addProductToCart(product : any){




    // for(let i in this.cart){
    //   if(this.cart[i].productId === product.id){
    //     localStorage.removeItem('cart');
    //     // this.cart[i].productQuantity++;
    //     this.cart[i].productQuantity=this.form.value.quantity;
    //     isExist = true;

    //     break;
    //   }

    // }

    // if(!isExist){
    //   localStorage.removeItem('cart');

    //   this.cart.push({
    //     productId:product.id,
    //     productName:product.name,
    //     productPrice:product.price,
    //     productQuantity:1,
    //   });
    // }

    // console.log('Before Get Total');
    // this.getTotal();

    // localStorage.setItem('cart',JSON.stringify(this.cart));

    // console.log('================= Total ==================');

    // console.log(this.total);


  }

  getTotal() : any {
    this.total = 0;

    if(this.cart === null){
      return;
    }

    //grand total
    this.cart.forEach((item: any) => {
      this.total += item.productPrice * item.productQuantity;

    });

    //product total
    for (let index = 0; index < this.cart.length; index++) {
     this.productTotal[index] =this.cart[index].productPrice * this.cart[index].productQuantity
    }


  }

  onRemove(index : number){
    this.cart.splice(index,1);
    localStorage.setItem('cart',JSON.stringify(this.cart));
  }

  checkout(){
    this.router.navigate(['checkout'])
  }
  increase(event : Event){
    this.quantity++;
  }
  decrease(event : Event){
    this.quantity--;
  }

  ngOnInit(): void {

    this.cartService.getItem().subscribe((product:any)=>{
      // this.addProductToCart(product);
      console.log('In cart component get Item ',product);

    });

    if(localStorage.getItem('cart')===null){
      localStorage.setItem('cart',JSON.stringify(this.cart))
    }else{
      this.localCart = (localStorage.getItem('cart'));
      this.cart =JSON.parse(this.localCart);
    }




    console.log(this.cart);
    // for (let index = 0; index < this.localCart.length; index++) {
    //   this.cart = this.localCart[index];


    // }
    this.userid=localStorage.getItem('userid')

    // this.cartService.loadCart().subscribe((product) =>{
    //   console.log(product);
    //   for(let item in product){
    //     this.cart = product;
    //   }
    // });

    // this.cart= (JSON.stringify(localStorage.getItem('cart')));
    this.userAuthenticated = this.authService.getIsAuth();
    this.authStatusSub = this.authService.getAuthStatusListener().subscribe(isAuthenticated=>{
      this.userAuthenticated = isAuthenticated;

    });


    // if(!this.userAuthenticated){ this.router.navigate(['login']) }
    // else{ this.cart= this.cartService.loadCart()}

  }

  ngOnDestroy(): void {

  }


}
