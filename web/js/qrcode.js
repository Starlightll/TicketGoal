function generateQRCode(ticketId, area, seatNumber, price, date, club1, club2) {
    const qrData = `#TICKET${ticketId}\nArea: ${area}\nSeat number: ${seatNumber}\nPrice: ${price}\nDate: ${date}\nClub1: ${club1}\nClub2: ${club2}`;
    const qrUrl = `https://api.qrserver.com/v1/create-qr-code/?size=400x400&data=${encodeURIComponent(qrData)}`;
    document.getElementById('qrContent').innerHTML = `<img src="${qrUrl}" alt="QR Code" />`;
    document.getElementById('descTicket').innerHTML = `QR CODE for ticket #TICKET${ticketId}`;
    document.getElementById('qrPopup').style.display = 'block';
}

function closePopup() {
    document.getElementById('qrPopup').style.display = 'none';
}