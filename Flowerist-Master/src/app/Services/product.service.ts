import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';

@Injectable({
  providedIn: 'root'
})
export class ProductService {

  baseUrl = 'http://localhost:3000';
  constructor(private http : HttpClient) { }

  getProducts(){
    return this.http.get(`${this.baseUrl}/app/products`);
  }

}
