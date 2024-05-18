const navMenu = document.getElementById('nav-menu'),
    navToggle = document.getElementById('nav-toggle'),
    navClose = document.getElementById('nav-close')

    //Show menu
    navToggle.addEventListener('click', () => {
        navMenu.classList.add('show-menu')
    })

    //Hide menu
    navClose.addEventListener('click', () => {
        navMenu.classList.remove('show-menu')
    })


    //Login
const login = document.getElementById('login'),
    loginBtn = document.getElementById('login-btn'),
    loginClose = document.getElementById('login-close'),
    loginButton = document.getElementById('login-button'),
    register = document.getElementById('register'),
    registerButton = document.getElementById('register-button'),
    registerClose = document.getElementById('register-close')
    // Login show
    loginBtn.addEventListener('click', () => {
        register.classList.add('show-register')
    })

    loginButton.addEventListener('click', () => {
        register.classList.add('show-register')
    })
    
    // Login hide
    loginClose.addEventListener('click', () => {
        login.classList.remove('show-login')
    })
    

