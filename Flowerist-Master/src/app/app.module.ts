import { NgModule } from '@angular/core';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { BrowserModule } from '@angular/platform-browser';
import { HttpClientModule, HTTP_INTERCEPTORS } from '@angular/common/http'


import { AppRoutingModule } from './app-routing.module';
import { AppComponent } from './app.component';
import { LoginComponent } from './Component/login/login.component';
import { RegisterComponent } from './Component/register/register.component';
import { HeaderComponent } from './Component/Navbar/header/header.component';
import { FooterComponent } from './Component/Navbar/footer/footer.component';
import { AdminpanelComponent } from './Component/Admin/adminpanel/adminpanel.component';
import { HomepageComponent } from './Component/homepage/homepage.component';

import { CartComponent } from './Component/cart/cart.component';
import { CartItemComponent } from './Component/cart/cart-item/cart-item.component';
import { FlowersComponent } from './Component/homepage/flower-list/flowers/flowers.component';
import { FlowerListComponent } from './Component/homepage/flower-list/flower-list.component';
import { AuthInterceptor } from './Component/Auth/auth-interceptor';
import { SliderComponent } from './Component/homepage/slider/slider.component';
import { CheckoutComponent } from './Component/cart/checkout/checkout.component';
import { UserProfileComponent } from './Component/user-profile/user-profile.component';

@NgModule({
  declarations: [
    AppComponent,
    LoginComponent,
    RegisterComponent,
    HeaderComponent,
    FooterComponent,
    AdminpanelComponent,
    HomepageComponent,
    FlowerListComponent,
    CartComponent,
    CartItemComponent,
    FlowersComponent,
    SliderComponent,
    CheckoutComponent,
    UserProfileComponent
  ],
  imports: [
    ReactiveFormsModule,
    HttpClientModule,
    FormsModule,
    BrowserModule,
    AppRoutingModule,

  ],
  providers: [
    { provide : HTTP_INTERCEPTORS,useClass:AuthInterceptor, multi: true}
  ],
  bootstrap: [AppComponent]
})
export class AppModule { }
