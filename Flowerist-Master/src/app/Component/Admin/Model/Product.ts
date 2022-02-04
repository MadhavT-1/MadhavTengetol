
export class Product {

    // Name: string;
    // Description: string;
    // Image:string;
    // Price:number;
    // available_qty:number;

    constructor(
              public id : number=1,
              public Name : string = "",
              public Description: string='',
              public Image:string='',
              public Price:number=0,
              public Available_qty:number=0,
    ){}

}

