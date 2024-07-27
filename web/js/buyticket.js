const closeBtn = document.getElementById('btn-close');
const confirmBox = document.getElementById('confirm-box-background');
const notificationCloseBtn = document.getElementById('btn-close-notification');
const notificationBox = document.getElementById('notification-background');
const buyTicketNotification = document.getElementById('buyticket-notification');
const checkoutCloseBtn = document.getElementById('btn-close-checkout');
const checkoutBox = document.getElementById('checkout-box-background');

closeBtn.addEventListener('click', () => {
    confirmBox.style.display = 'none';
});

notificationCloseBtn.addEventListener('click', () => {
    buyTicketNotification.style.transform = 'translate(-50%, -50%) scale(0)';
    notificationBox.style.opacity = '0';
    setTimeout(() => {
        notificationBox.style.display = 'none';
    }, 300);
});

checkoutCloseBtn.addEventListener('click', () => {
    checkoutBox.style.display = 'none';
});