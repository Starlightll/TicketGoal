const navMenu = document.getElementById('nav-menu'),
    navToggle = document.getElementById('nav-toggle'),
    navClose = document.getElementById('nav-close');

//Show menu
navToggle.addEventListener('click', () => {
    navMenu.classList.add('show-menu');
});
//Hide menu
navClose.addEventListener('click', () => {
    navMenu.classList.remove('show-menu');
});


//Login
const login = document.getElementById('login'),
    loginBtn = document.getElementById('login-btn'),
    loginClose = document.getElementById('login-close'),
    loginButton = document.getElementById('login-button'),
    register = document.getElementById('register'),
    registerButton = document.getElementById('register-button'),
    registerClose = document.getElementById('register-close'),
    signinButton = document.getElementById('signin-button'),
    forgotPasswordButton = document.getElementById("forgotpassword-button"),
    forgotPassword = document.getElementById("forgotPassword"),
    forgotPasswordSigninButton = document.getElementById('forgotpassword-signin-button'),
    forgotPasswordClose = document.getElementById('forgotpassword-register-close');
// Login show
loginBtn?.addEventListener('click', () => {
    login.classList.add('show-login');
});

loginButton?.addEventListener('click', () => {
    login.classList.add('show-login');
});

// Login hide
loginClose?.addEventListener('click', () => {
    login.classList.remove('show-login');
});

registerButton?.addEventListener('click', () => {
    register.classList.add('show-register');
    login.classList.remove('show-login');
});

// Register hide
registerClose?.addEventListener('click', () => {
    register.classList.remove('show-register');
});

signinButton?.addEventListener('click', () => {
    register.classList.remove('show-register');
    login.classList.add('show-login');
});

//Show forgotpassword field
forgotPasswordButton?.addEventListener('click', () => {
    forgotPassword.classList.add('show-register');
    login.classList.remove('show-login');
});
forgotPasswordSigninButton?.addEventListener('click', () => {
    forgotPassword.classList.remove('show-register');
    login.classList.add('show-login');
});
forgotPasswordClose?.addEventListener('click', () => {
    forgotPassword.classList.remove('show-register');
});
// Call Login API
const loginSubmitBtn = document.getElementById("submit-login-button");
loginSubmitBtn.onclick = async (e) => {
    e.preventDefault();
    const loginEmailValue = document.getElementById("email").value;
    const loginPasswordValue = document.getElementById("password").value;
    const errorMessage = document.getElementById("error-login-message");
    const currentURL = window.location.href;

    try {
        const response = await fetch('./signIn', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded'
            },
            body: `email=${encodeURIComponent(loginEmailValue)}&password=${encodeURIComponent(loginPasswordValue)}&redirectUrl=${encodeURIComponent(currentURL)}`
        });
        const jsonResponse = await response.json();

        if (!jsonResponse.isSuccess) {
            errorMessage.innerText = jsonResponse.message;
            errorMessage.style.display = "block";
            return;
        }
        window.location.href = jsonResponse.redirectUrl;
    } catch (error) {
        console.error('There was a problem with the fetch operation:', error);
    }
};


// Handle user manage profile
const profileBtn = document.getElementById("profile-btn");
const profileField = document.getElementById("profile-field");
const profileTitle = document.getElementById("profile-title");
const changePasswordTitle = document.getElementById("change-password-title");
const profielDisplayField = document.getElementById("profile-display-field");
const changePasswordDisplayField = document.getElementById("change-password-display-field");
const profileCloseBtn = document.getElementById("profile-close");
const body = document.querySelector("body");
if (profileCloseBtn) {
    profileCloseBtn.onclick = () => {
        profileField.classList.toggle('show-profile');
        body.style.removeProperty("overflow");
    };
}


if (changePasswordTitle) {
    changePasswordTitle.onclick = () => {
        profielDisplayField?.classList.add("d-none");
        changePasswordDisplayField?.classList.remove("d-none");
        profileTitle?.classList.remove("text-blue");
        changePasswordTitle?.classList.add("text-blue");
    };
}
if (profileTitle) {
    profileTitle.onclick = () => {
        changePasswordDisplayField.classList.add("d-none");
        profielDisplayField.classList?.remove("d-none");
        profileTitle.classList.add("text-blue");
        changePasswordTitle.classList?.remove("text-blue");
    };
}
if (profileBtn) {
    profileBtn.onclick = () => {
        profileField.classList.toggle('show-profile');
        body.style.overflow = "hidden";
    };
}


// Handle call API for update profile and change password
const profileUpdateBtn = document.getElementById("profile-update-submit-btn");
const passwordChangeBtn = document.getElementById("password-change-btn");

profileUpdateBtn ? profileUpdateBtn.onclick = async (e) => {
    e.preventDefault();
    const username = document.getElementById("profileUsername").value;
    const email = document.getElementById("profileEmail").value;
    const phone = document.getElementById("profilePhone").value;
    const address = document.getElementById("profileAddress").value;
    const gender = document.getElementById("profileGender").value;
    if (validateField(username, "string")
        && validateField(email, "email")
        && validateField(phone, "phone")
        && validateField(address, "address")
        && validateField(gender, "number")) {
        try {
            const response = await fetch('./changeProfile', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded'
                },
                body: `username=${encodeURIComponent(username).trim()}
                        &email=${encodeURIComponent(email).trim()}
                        &phone=${encodeURIComponent(phone).trim()}
                        &address=${encodeURIComponent(address).trim()}
                        &gender=${encodeURIComponent(gender).trim()}`
            });
            const jsonResponse = await response.json();
            console.log(jsonResponse);
            if (!jsonResponse.isSuccess) {
                alert(jsonResponse?.messasge || "Something wrong when updating,please try again !!!");
                return;
            }
            alert(jsonResponse?.messasge || "Update profile success !!");
            window.location.reload();
        } catch (error) {
            console.error('There was a problem with the fetch operation:', error);
        }
    }

} : null;

passwordChangeBtn ? passwordChangeBtn.onclick = async (e) => {
    e.preventDefault();
    const oldPass = document.getElementById("changePassword-oldPass").value;
    const newPass = document.getElementById("changePassword-newPass").value;
    const confirmPass = document.getElementById("changePassword-confirmPass").value;

    if (newPass.trim() !== confirmPass.trim()) {
        alert("Confirm Password must be the same as the New Password");
        return;
    }
    if (newPass.trim().length < 8) {
        alert("Password must be more than 8 characters");
        return;
    }
    try {
        const response = await fetch('./changePassword', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded'
            },
            body: `oldPass=${encodeURIComponent(oldPass).trim()}
                        &newPass=${encodeURIComponent(newPass).trim()}`
        });
        const jsonResponse = await response.json();
        console.log(jsonResponse);
        if (!jsonResponse.isSuccess) {
            alert(jsonResponse?.messasge || "Something's wrong");
            return;
        }
        alert(jsonResponse?.messasge || "Update success !!");
        window.location.reload();
    } catch (error) {
        console.error('There was a problem with the fetch operation:', error);
    }

} : null;

// Handle register new account
const registerSubmitBtn = document.getElementById('sign-up-btn-submit');
if (registerSubmitBtn) {
    registerSubmitBtn.addEventListener('click', async function () {
        const email = document.getElementById('registerEmailForm').value;
        const password = document.getElementById('registerPassword').value;
        const rePassword = document.getElementById('confirmPassword').value;
        if (password !== rePassword || !password) {
            alert("Confirm Password must be the same with Password");
            return;
        }
        if (!validateField(email, "email")) {
            return;
        }

        try {
            const response = await fetch('./signUp', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded'
                },
                body: `email=${encodeURIComponent(email).trim()}&rePassword=${encodeURIComponent(rePassword).trim()}&password=${encodeURIComponent(password).trim()}`
            });
            const jsonResponse = await response.json();
            console.log(jsonResponse);
            if (!jsonResponse.isSuccess) {
                alert(jsonResponse?.message || "Something's wrong");
                return;
            }
            alert(jsonResponse?.message || "Register success !!");
            window.location.reload();
        } catch (error) {
            console.error('There was a problem with the fetch operation:', error);
        }
    });
}
// Handle forgotpassword
const forgotpasswordSubmitBtn = document.getElementById('forgotpassword-submit-button');
if (forgotpasswordSubmitBtn) {
    forgotpasswordSubmitBtn.addEventListener('click', async function () {
        const email = document.getElementById('forgotPasswordEmail').value;
        console.log(email);
        try {
            const response = await fetch('./forgotPassword', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded'
                },
                body: `email=${encodeURIComponent(email).trim()}`
            });
            const jsonResponse = await response.json();
            alert(jsonResponse.message);
        } catch (exception) {
            console.error('There was a problem with the fetch operation:', exception);
        }
    });
}

