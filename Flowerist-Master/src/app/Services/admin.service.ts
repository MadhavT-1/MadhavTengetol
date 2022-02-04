import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';

@Injectable({
  providedIn: 'root'
})
export class AdminService {
  baseUrl = 'http://localhost:3000';
  adminUrl = 'http://localhost:3000/app';

  constructor(private http: HttpClient) { }

  addFlower(flower : any){
    return this.http.post(`${this.adminUrl}/admin/addflower`, flower);
  }

  getFlowers(){
    return this.http.get(`${this.adminUrl}/admin/getflowers`);
  }

  removeFlower(name :any){
     return this.http.delete(`${this.adminUrl}/admin/remove/${name}`);
  }

  updateFlower(product : any){

    return this.http.put(`${this.adminUrl}/admin/update`,product)

  }

  getAllUsers(){
    return this.http.get(`${this.adminUrl}/admin/getusers`);
  }

  getOrderDetails(){
    return this.http.get(`${this.adminUrl}/admin/getorders`);
  }
}
