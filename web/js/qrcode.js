
let countdownInterval;
let expiryTime = 60 * 1000 * 60;

function generateQRCode(data) {
    const qrUrl = `https://quickchart.io/qr?text=${encodeURIComponent(data)}&size=400`;
    const timestamp = new Date().getTime();
    localStorage.setItem('qrCodeData', JSON.stringify({qrUrl, timestamp}));
    displayQRCode(data);
}

function displayQRCode(data) {
    const qrData = JSON.parse(localStorage.getItem('qrCodeData'));
    if (qrData) {
        document.getElementById('qrContent').innerHTML = `<img src="${qrData.qrUrl}" alt="QR Code" />`;
        document.getElementById('descTicket').innerHTML = "QR CODE #TICKET" + data;
        document.getElementById('qrPopup').style.display = 'block';
        startCountdown();
    }
}

function startCountdown() {
    const qrData = JSON.parse(localStorage.getItem('qrCodeData'));
    const startTime = qrData.timestamp;
    countdownInterval = setInterval(() => {
        const currentTime = new Date().getTime();
        const elapsedTime = currentTime - startTime;
        const timeLeft = expiryTime - elapsedTime;
        if (timeLeft <= 0) {
            clearInterval(countdownInterval);
            document.getElementById('countdown').innerHTML = 'Expired';
            closePopup();
            return;
        }
        const minutes = Math.floor((timeLeft % (1000 * 60 * 60)) / (1000 * 60));
        const seconds = Math.floor((timeLeft % (1000 * 60)) / 1000);
        document.getElementById('countdown').innerHTML = `<span style="color:red">Timmer: ${minutes}m ${seconds}s </span>`;
    }, 1000);
}

function closePopup() {
    clearInterval(countdownInterval);
    document.getElementById('qrContent').innerHTML = '';
    document.getElementById('descTicket').innerHTML = '';
    document.getElementById('qrPopup').style.display = 'none';
}

function validateQRCode() {
    const qrData = JSON.parse(localStorage.getItem('qrCodeData'));
    if (qrData) {
        const currentTime = new Date().getTime();
        const elapsedTime = currentTime - qrData.timestamp;
        if (elapsedTime < expiryTime) {
        } else {
            document.getElementById('qrContent').innerHTML = '<img src="https://t3.ftcdn.net/jpg/02/23/88/58/360_F_223885881_Zotk7yyvWJDvq6iWq2A9XU60iVJEnrzC.jpg" alt="QR Code" />';
        }
    }
}
setInterval(validateQRCode, 1000);