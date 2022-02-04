import { Component, Input, OnInit } from '@angular/core';
import { CartService } from 'src/app/Services/cart.service';

@Component({
  selector: 'app-cart-item',
  templateUrl: './cart-item.component.html',
  styleUrls: ['./cart-item.component.css']
})
export class CartItemComponent implements OnInit {

  @Input() productItem: any ;
  @Input() total : any;

  constructor() { }

  ngOnInit(): void {

  }

}
