import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { AdminpanelComponent } from './Component/Admin/adminpanel/adminpanel.component';
import { AuthGuard } from './Component/Auth/auth.guard';
import { CartComponent } from './Component/cart/cart.component';
import { CheckoutComponent } from './Component/cart/checkout/checkout.component';
import { HomepageComponent } from './Component/homepage/homepage.component';
import { LoginComponent } from './Component/login/login.component';
import { RegisterComponent } from './Component/register/register.component';
import { UserProfileComponent } from './Component/user-profile/user-profile.component';

const routes: Routes = [
  {path:'',redirectTo:'homepage',pathMatch:'full'},
  {path:'homepage',component:HomepageComponent},
  {path : 'login',component:LoginComponent},
  {path: 'register', component:RegisterComponent},
  {path:'cart',component:CartComponent,canActivate:[AuthGuard]},
  {path : 'adminpanel',component: AdminpanelComponent},
  {path : 'checkout', component : CheckoutComponent,canActivate:[AuthGuard]},
  {path:'profile',component: UserProfileComponent,canActivate:[AuthGuard]}
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule],
  providers: [AuthGuard]
})
export class AppRoutingModule { }
