<%-- 
    Document   : header1
    Created on : May 17, 2024, 11:43:03 AM
    Author     : mosdd
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <title>TicketGoal</title>
    <link rel="preconnect" href="https://fonts.googleapis.com"/>
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin/>
    <link
            href="https://fonts.googleapis.com/css2?family=Inter:wght@100..900&display=swap"
            rel="stylesheet"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/remixicon/4.2.0/remixicon.css">

    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/header.css"/>

</head>
<body>
<header class="header">
    <div class="header__content">
        <nav class="nav">
            <a href="<c:url value='/homepageServlet'/>" class="nav__logo">
                <img src="${pageContext.request.contextPath}/img/TICKETGOAL.png" alt="logo">
            </a>
            <div class="nav__menu" id="nav-menu">
                <ul class="nav__list">
                    <li class="nav__item">
                        <a href="<c:url value='/matchServlet'/>" class="nav__link">MATCHES</a>
                    </li>
                    <li class="nav__item">
                        <a href="<c:url value='/playerServlet'/>" class="nav__link">PLAYER</a>
                    </li>
                    <li class="nav__item">
                        <a href="<c:url value='/shopServlet'/>" class="nav__link">SHOP</a>
                    </li>
                    <li class="nav__item">
                        <a href="<c:url value='/contactServlet'/>" class="nav__link">CONTACT</a>
                    </li>
                </ul>

                <!-- Close button -->
                <div class="nav__close" id="nav-close">
                    <i class="ri-close-line"></i>
                </div>
            </div>
            <div class="nav__actions">
                <!-- Login button -->
                <c:if test="${sessionScope.user != null}">
                    <i class="ri-user-line nav__cart" id="profile-btn"></i>
                    <button onclick="window.location.href = './signOutServlet'" class="join__button">LOG OUT</button>
                </c:if>
                <c:if test="${sessionScope.user == null}">
                    <i class="ri-user-fill nav__login" id="login-btn"></i>
                    <button class="join__button" id="login-button">JOIN NOW</button>
                </c:if>
                <!-- Search button -->
                <a href="cart"><i class="ri-shopping-cart-2-fill nav__cart" id="search-btn"></i></a>
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
    <!--Login Field-->
    <div class="login ${showLogin}" id="login">
        <div class="login__decor"></div>

        <!-- Login  form -->
        <form action="./signIn" class="login__form" method="POST">
            <i class="ri-close-line login__close" id="login-close"></i>
            <i style="color:red;display:none" id="error-login-message"></i>
            <div class="login__icon">
                <img src="${pageContext.request.contextPath}/img/loginIcon.png" alt="loginIcon">
            </div>
            <h2 class="login__title">SIGN IN</h2>

            <div class="login__group">
                <div>
                    <label for="email" class="login__label">Email</label>
                    <input type="email" placeholder="Enter your email" id="email" class="login__input"
                           autocomplete="on">
                </div>

                <div>
                    <label for="password" class="login__label">Password</label>
                    <input type="password" placeholder="Enter your password" id="password" class="login__input">
                </div>
            </div>

            <div>
                <p class="login__signup">
                    Don't have an account? <a id="register-button">Sign up</a>
                </p>

                <a class="login__forgot" id="forgotpassword-button">
                    Forgot password?
                </a>

                <button type="submit" class="login__button" id="submit-login-button">Sign In</button>
            </div>
            <div class="login__social">
                <a class="login__google"
                   href="https://accounts.google.com/o/oauth2/auth?scope=email&redirect_uri=http://localhost:8080/TicketGoal/googleLogin&response_type=code&client_id=550821903410-138bsqhr6mcm321bagemu78a3cd2ctr7.apps.googleusercontent.com&approval_prompt=force">
                    <i class="fab fa-google"></i> Sign in with Google
                </a>
            </div>
        </form>
    </div>
    <!--Register Field-->
    <div class="register" id="register">
        <div class="register__decor"></div>

        <!-- Register form -->
        <form action="" class="register__form" onsubmit="(e)=>{e.preventDefault();}">
            <i class="ri-close-line register__close" id="register-close"></i>

            <div class="login__icon">
                <img src="${pageContext.request.contextPath}/img/loginIcon.png" alt="loginIcon">
            </div>
            <h2 class="register__title">SIGN UP</h2>

            <div class="register__group">
                <div>
                    <label for="email" class="register__label">Email</label>
                    <label for="registerEmailForm"></label><input type="email" placeholder="Enter your email"
                                                                  id="registerEmailForm" class="register__input">
                </div>

                <div>
                    <label for="registerPassword" class="register__label">Password</label>
                    <input type="password" placeholder="Enter your password" id="registerPassword"
                           class="register__input" autocomplete="current-password">
                </div>

                <div>
                    <label for="confirmPassword" class="register__label">Confirm password</label>
                    <input type="password" placeholder="Confirm your password" id="confirmPassword"
                           class="register__input" autocomplete="current-password">
                </div>
            </div>

            <div>
                <p class="register__signin">
                    Already have an account? <a id="signin-button">Sign in</a>
                </p>
                <button type="submit" class="register__button" id="sign-up-btn-submit">Sign Up</button>
            </div>
        </form>
    </div>
    <!--ForgotPassword Field-->
    <div class="register" id="forgotPassword">
        <div class="register__decor"></div>

        <!-- Register form -->
        <form action="" class="register__form">
            <i class="ri-close-line register__close" id="forgotpassword-register-close"></i>

            <div class="login__icon">
                <img src="${pageContext.request.contextPath}/img/loginIcon.png" alt="loginIcon">
            </div>
            <h2 class="register__title">Forgot Password</h2>

            <div class="register__group">
                <div>
                    <label for="forgotPasswordEmail" class="register__label">Email</label>
                    <input type="email" placeholder="Enter your email" id="forgotPasswordEmail" class="register__input">
                </div>

            </div>

            <div>
                <p class="register__signin">
                    Already have an account? <a>Sign in</a>
                </p>
                <button type="button" class="register__button" id="forgotpassword-submit-button">Reset</button>
            </div>
        </form>
    </div>
    <!--(User was logged) Profile-->
    <c:if test="${sessionScope.user != null}">
        <div class="profile" id="profile-field">
            <div class="profile__decor"></div>
            <form action="" class="profile__form">
                <i class="ri-close-line profile__close" id="profile-close"></i>
                <div class="profile__header">
                    <div class="login__icon">
                        <i class="ri-user-fill" style="font-size: 30px; margin-bottom: 10px"></i>
                    </div>
                </div>
                <div class="profile__main">
                    <div class="profile__information">
                        <h2 class="profile__title" id="profile-title">Profile</h2>
                        <div id="profile-display-field">
                            <div class="profile__group">
                                <div class="profile__column">
                                    <div class="profile__item">
                                        <label for="profileUsername" class="profile__label">Username</label>
                                        <input type="text" placeholder="Enter your username" id="profileUsername"
                                               class="profile__input" value="${user.getUsername()}">
                                    </div>
                                    <div class="profile__item">
                                        <label for="profileEmail" class="profile__label">Email</label>
                                        <input type="email" placeholder="Enter your email" id="profileEmail"
                                               class="profile__input" value="${user.getEmail()}">
                                    </div>
                                    <div class="profile__item">
                                        <label for="profilePhone" class="profile__label">Phone</label>
                                        <input type="text" placeholder="Enter your phone number" id="profilePhone"
                                               class="profile__input" value="${user.getPhoneNumber()}">
                                    </div>
                                </div>
                                <div class="profile__column">
                                    <div class="profile__item">
                                        <label for="profileAddress" class="profile__label">Address</label>
                                        <input type="text" value="${user.getAddress()}" id="profileAddress" placeholder="Enter your address">
                                    </div>
                                    <div class="profile__item">
                                        <label for="profileGender" class="profile__label">Gender</label>
                                        <select id="profileGender" class="profile__input">
                                            <option value="1">Male</option>
                                            <option value="2">Female</option>
                                            <option value="3">Other</option>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="submit">
                                <button type="submit" class="profile__button" id="profile-update-submit-btn">Update</button>
                            </div>
                        </div>
                    </div>
                    <div class="change__password">
                        <h2 class="profile__title" id="change-password-title">Change Password</h2>
                        <div class="profile__group" id="change-password-display-field">
                            <div>
                                <label for="changePassword-oldPass" class="profile__label">Old Password</label>
                                <input type="password" placeholder="Enter your password" id="changePassword-oldPass"
                                       class="profile__input" autocomplete="current-password">
                            </div>
                            <div>
                                <label for="changePassword-newPass" class="profile__label">New Password</label>
                                <input type="password" placeholder="Enter your password" id="changePassword-newPass"
                                       class="profile__input" autocomplete="new-password">
                            </div>
                            <div>
                                <label for="changePassword-confirmPass" class="profile__label">Confirm password</label>
                                <input type="password" placeholder="Confirm your password" id="changePassword-confirmPass"
                                       class="profile__input" autocomplete="new-password">
                            </div>
                            <div>
                                <button type="submit" class="profile__button" id="password-change-btn">Change</button>
                            </div>
                        </div>
                    </div>
                </div>
            </form>
        </div>
    </c:if>
</header>
<script src="${pageContext.request.contextPath}/js/validate.js"></script>
<script src="${pageContext.request.contextPath}/js/main.js"></script>
<script>
    window.onload = function () {
        var gender = ${user.getGender() != null ?user.getGender() : 1 };

        var selectElement = document.getElementById('profileGender');

        selectElement ? selectElement.value = gender : null;
    };
</script>
</body>
</html>
