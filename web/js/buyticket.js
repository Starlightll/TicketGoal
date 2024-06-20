const closeBtn = document.getElementById('btn-close');
const confirmBox = document.getElementById('confirm-box-background');

closeBtn.addEventListener('click', () => {
    confirmBox.style.display = 'none';
});