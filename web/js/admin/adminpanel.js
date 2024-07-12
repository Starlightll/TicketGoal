/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */


var subBtns = document.querySelectorAll('.nav__link.dropdown__item');

subBtns.forEach(function (subBtn) {
    subBtn.addEventListener('click', function () {
        var subMenu = subBtn.nextElementSibling;
        var dropdownIcon = subBtn.querySelector('.admin .nav__link .ri-arrow-drop-down-line');

        if (subMenu.style.display === 'block') {
            subMenu.style.display = 'none';
            dropdownIcon.classList.remove('rotate');
        } else {
            subMenu.style.display = 'block';
            dropdownIcon.classList.add('rotate');
        }
    });
});