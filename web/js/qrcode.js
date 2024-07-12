function generateQRCode(data) {
    const qrUrl = `https://quickchart.io/qr?text=` + data + `&size=400`;
    document.getElementById('qrContent').innerHTML = `<img src="${qrUrl}" alt="QR Code" />`;
    document.getElementById('descTicket').innerHTML = `QR CODE for ticket #TICKET`;
    document.getElementById('qrPopup').style.display = 'block';
}

function closePopup() {
    document.getElementById('qrPopup').style.display = 'none';
}