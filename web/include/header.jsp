<%-- 
    Document   : header1
    Created on : May 17, 2024, 11:43:03 AM
    Author     : mosdd
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <title>TicketGoal</title>
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
    <link
      href="https://fonts.googleapis.com/css2?family=Inter:wght@100..900&display=swap"
      rel="stylesheet"/>

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/remixicon/4.2.0/remixicon.css">

    <link rel="stylesheet" href="../css/style.css" />
    
  </head>
  <body>
    <header class="header">
        <div class="header__content">
            <nav class="nav">
                <a href="#" class="nav__logo">
                    <img src="../img/TICKETGOAL.png" alt="logo">
                </a>
                <div class="nav__menu" id="nav-menu">
                    <ul class="nav__list">
                        <li class="nav__item">
                            <a href="#" class="nav__link">MATCHES</a>
                        </li>
                        <li class="nav__item">
                            <a href="#" class="nav__link">PLAYER</a>
                        </li>
                        <li class="nav__item">
                            <a href="#" class="nav__link">SHOP</a>
                        </li>
                        <li class="nav__item">
                            <a href="#" class="nav__link">CONTACT</a>
                        </li>
                    </ul>

                    <!-- Close button -->
                    <div class="nav__close" id="nav-close">
                        <i class="ri-close-line"></i>
                    </div>
                </div>
                <div class="nav__actions">
                    <!-- Login button -->
                    <i class="ri-user-fill nav__login" id="login-btn"></i>
                    <button class="join__button" id="login-button">JOIN NOW</button>
                    <!-- Search button -->
                    <i class="ri-shopping-cart-2-fill nav__cart" id="search-btn"></i>
                    <!-- Toggle button -->
                    <div class="nav__toggle" id="nav-toggle">
                        <i class="ri-menu-line"></i>
                    </div>
                </div>
            </nav>

            <!-- <div class="header__cta">
                <a href="#" class="btn btn--primary">SIGN IN</a>
                <a href="#" class="btn btn--secondary">SIGN UP</a>
            </div> -->
        </div>
    </header>
    <!-- Search form -->

        <!-- Login -->
        <div class="login" id="login">
            <div class="login__decor">
            </div>
            <form action="" class="login__form">
                <div class="login__icon">
                    <img src="../img/loginIcon.png" alt="loginIcon">
                </div>
                <h2 class="login__title">SIGN IN</h2>
            
                <div class="login__group">
                    <div>
                        <label for="email" class="login__label">Email</label>
                        <input type="email" placeholder="Enter your email" id="email" class="login__input">
                    </div>
                    
                    <div>
                        <label for="password" class="login__label">Password</label>
                        <input type="password" placeholder="Enter your password" id="password" class="login__input">
                    </div>
                </div>

                <div>
                    <p class="login__signup">
                    Don't have an account? <a href="#">Sign up</a>
                    </p>
    
                    <a href="#" class="login__forgot">
                    Forgot password?
                    </a>
    
                    <button type="submit" class="login__button">Sign In</button>
                </div>
            </form>
         <i class="ri-close-line login__close" id="login-close"></i>
      </div>

    <script src="../js/main.js"></script>
  </body>
</html>