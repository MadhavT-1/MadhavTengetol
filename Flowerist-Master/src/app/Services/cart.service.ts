import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Router } from '@angular/router';
import { Observable, Subject } from 'rxjs';
import { AuthService } from './auth.service';

@Injectable({
  providedIn: 'root'
})
export class CartService {

  baseUrl = 'http://localhost:3000'
  subject = new Subject();
  quantity : number = 1
  check : false

  cart : any =[]
  localCart : any = []
  total : number = 0

  constructor(private http : HttpClient,
    private authService : AuthService,
    private router : Router) { }

  getItem(){
    // this.cart = localStorage.getItem('cart');

    return this.subject.asObservable();

  }

  sendItem(product : any,quantity: any){

    //TODO : Add product to database
    let isExist = false


    if(localStorage.getItem('cart') !== null){
      this.localCart = localStorage.getItem('cart');
      this.cart =JSON.parse(this.localCart);
    }else{
     localStorage.setItem('cart',JSON.stringify(this.cart));
    }

    const userid = localStorage.getItem('userid');


    for(let i in this.cart){
      if(this.cart[i].productId === product.id){
        localStorage.removeItem('cart');
        this.cart[i].productQuantity += quantity;
        isExist = true;
        break;
      }
    }


    if(!isExist){

      this.cart.push({
        productId:product.id,
        productName:product.name,
        productPrice:product.price,
        productQuantity:quantity,
      });

    }


  //  const cartItem ={
  //       productId:product.id,
  //       productname:product.name,
  //       productprice:product.price,
  //       productquantity:quantity,
  //   }

    localStorage.setItem('cart',JSON.stringify(this.cart));

    this.subject.next(product);

  }

  updateCart(quantity : any,productid : any,userid :any){
    const info = {
      quantity: quantity,
      productid:productid,
      userid:userid
    };
    console.log(info);

        return this.http.put(`${this.baseUrl}/app/updatecart/`,info);
  }



  addProductToCart(product : any){

    console.log('addProductToCart:',product);
    // this.sendItem(product,this.quantity)

    // return this.http.post(`${this.baseUrl}/app/addorder`,product);

    return this.http.post(`${this.baseUrl}/app/addtocart`,product);

  }

  placeOrder(product : any){
    return this.http.post(`${this.baseUrl}/app/addorder`,product);
  }

 sendCart(product : []){
  console.log("in Cart service");

  console.log(product);


  }

  getCart(){
    return this.subject.asObservable();
  }

  getTotal() : any {
    this.total = 0;
    this.cart.forEach((item: any) => {
      this.total += item.productPrice * item.productQuantity;
    });

  }

  setQuantity(quantity : number){
    this.quantity = quantity;
  }

  loadDBCart(id : any){
    let userid ={userid : id}
    return this.http.post(`${this.baseUrl}/app/loadcart`,userid);
  }

  checkIfExist(productid : any)  {

    return this.http.post<{status : boolean}>(`${this.baseUrl}/app/findone`,productid);

  }

  getMyOrders(userid : any){
    const id ={userid: userid}
    return this.http.post(`${this.baseUrl}/app/getmyorders`,id);
  }

  getCartLength(){
    console.log('In cart length function', this.cart);

    return this.cart.length;
  }

}
