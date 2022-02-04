import { Component, OnInit } from '@angular/core';

// import { Product } from 'src/app/models/Product';
import { Product } from '../Model/Product'
import { AdminService } from 'src/app/Services/admin.service';


@Component({
  selector: 'app-adminpanel',
  templateUrl: './adminpanel.component.html',
  styleUrls: ['./adminpanel.component.css']
})
export class AdminpanelComponent implements OnInit {

    products: any =[];
    showNew: Boolean = false;
    submitType: string = "Save";
    selectedRow!: number;
    form: any;
    showData = false
    showUsers = false
    showOrders =false
    userList :any =[]
    orderDetails : any = []

  constructor(private adminService : AdminService) {}

  onNew() {
    this.form = new Product();
    this.submitType = 'Save';
    this.showData= false
    this.showNew = true;
    this.showUsers =false
    this.showOrders =true
    }

  onSave() {
    if (this.submitType === 'Save') {
      const item = {
        name: this.form.name,
        description: this.form.description,
        image:this.form.image,
        price: this.form.price,
        available_qty: this.form.available_qty
      }

      // console.log(item);

      this.adminService.addFlower(item).subscribe(response=>{
        alert('Flower Added...');
        this.form = '';
      })



    } else
    {

    // Update existing
    const id = this.products[this.selectedRow].id;
    this.products[this.selectedRow].name = this.form.name;
    this.products[this.selectedRow].description = this.form.description;
    this.products[this.selectedRow].image = this.form.image;
    this.products[this.selectedRow].price = this.form.price;
    this.products[this.selectedRow].available_qty = this.form.available_qty;

    // console.log(this.products[this.selectedRow]);
    const item = this.products[this.selectedRow];


    this.adminService.updateFlower(item).subscribe(response=>{
      alert('Updated SuccessFully');
    })
  }

  //   this.showNew = false;

  }


  onEdit(index: number) {
    this.selectedRow = index;
    this.form = new Product();

    // Retrieve selected
    this.form = Object.assign({}, this.products[this.selectedRow]);
    this.submitType = 'Update';
    this.showData = false;
    this.showUsers = false
    this.showNew = true;
    this.showOrders = true
  }

  onDelete(index: number) {

    const item = this.products.splice(index, 1);

    const flowerName = item[0].name;

    this.adminService.removeFlower(flowerName).subscribe(result=>{
      alert('flower Removed');
    });


  }

  onCancel() {
    this.showNew = false;
    this.showOrders = false
  }

  showList(){
    this.showData = true
    this.showNew = false
    this.showUsers = false
    this.showOrders = true
  }

  getUsers(){
    this.showUsers = true
    this.showNew= false
    this.showData = false
    this.showOrders = true
    this.adminService.getAllUsers().subscribe(response =>{
      this.userList = response;
    })
  }

  ngOnInit() {

    this.adminService.getFlowers().subscribe(items=>{
      this.products = items;
    });

    // this.getUsers();
    this.adminService.getOrderDetails().subscribe(orders=>{
      this.orderDetails = orders
    })

  }

}
