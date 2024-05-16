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
    loginButton = document.getElementById('login-button')
    // Login show
    loginBtn.addEventListener('click', () => {
        login.classList.add('show-login')
    })

    loginButton.addEventListener('click', () => {
        login.classList.add('show-login')
    })
    
    // Login hide
    loginClose.addEventListener('click', () => {
        login.classList.remove('show-login')
    })
