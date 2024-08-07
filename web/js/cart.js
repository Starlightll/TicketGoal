
const checkboxes = document.querySelectorAll('.ticket-checkbox');
const selectedTickets = {};
let totalPriceSelected = 0;
const totalPriceSelectedDisplay = document.getElementById('total-price-selected');
const selectedTicketInfo = document.getElementById('selected-ticket-info');
checkboxes.forEach(checkbox => {
    checkbox.addEventListener('change', function () {

    });
});
function handleChoose(ele) {
    const ticketId = ele.value;
    const price = parseFloat(ele.getAttribute('data-price'));
    const area = ele.getAttribute('data-area');
    const seat = ele.getAttribute('data-seat');
    const date = ele.getAttribute('data-date');
    if (ele.checked) {
        selectedTickets[ticketId] = {
            price: price,
            area: area,
            seat: seat,
            date: date
        };
        const ticketDetailsDiv = document.createElement('div');
        ticketDetailsDiv.setAttribute('id', `ticket-details-${ticketId}`);
        ticketDetailsDiv.innerHTML = `
                    <h4>Detail ticket ${ticketId}:</h4>
                    <p>Area: ${area}</p>
                    <p>Seat number: ${seat}</p>
                    <p>Price: ${price}</p>
                    <p>Date: ${date}</p>
          <input type="hidden" name="tickets" value="${ticketId}" />
                `;
        selectedTicketInfo.appendChild(ticketDetailsDiv);
        totalPriceSelected += price;
    } else {
        delete selectedTickets[ticketId];
        const ticketDetailsToRemove = document.getElementById(`ticket-details-${ticketId}`);
        if (ticketDetailsToRemove) {
            selectedTicketInfo.removeChild(ticketDetailsToRemove);
            totalPriceSelected -= price;
        }
    }
    totalPriceSelectedDisplay.textContent = `Total price: ${totalPriceSelected}`;
}

function sortByPrice(event, ascending) {
    event.preventDefault();
    const searchData = {
        club: "",
        selectedTickets: Object.keys(selectedTickets)
    };
    fetch('searchCart', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json',
        },
        body: JSON.stringify(searchData),
    })
            .then(response => response.json())
            .then(data => {
                console.log(sortByPriceFun(data, ascending))
                searchShow(sortByPriceFun(data, ascending));
            })
            .catch(error => {
                console.error('Error:', error);
            });
}

function sortByPriceFun(tickets, ascending) {
    return tickets.sort((a, b) => {
        return ascending == 'true' ? a.seat.price - b.seat.price : b.seat.price - a.seat.price;
    });
}

function searchTickets(event) {
    event.preventDefault();
    const clubValue = document.getElementById('clubInput').value.trim();
    const searchData = {
        club: clubValue,
        selectedTickets: Object.keys(selectedTickets)
    };
    fetch('searchCart', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json',
        },
        body: JSON.stringify(searchData),
    })
            .then(response => response.json())
            .then(data => {
                console.log('Search results:', data);
                searchShow(data);
            })
            .catch(error => {
                console.error('Error:', error);
            });
}

function deleteTicket(id, cart) {
    if (confirm('Are you sure to delete ?') == false) {
        return;
    }
    const deleteData = {
        ticketId: id,
        cartId: cart
    };
    fetch('deleteTicket', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json',
        },
        body: JSON.stringify(deleteData),
    })
            .then(response => response.json())
            .then(data => {
                alert("Delete successfully");
                if (selectedTickets[id] != null) {
                    totalPriceSelected -= selectedTickets[id].price;
                    delete selectedTickets[id];
                    const ticketDetailsToRemove = document.getElementById(`ticket-details-${id}`);
                    selectedTicketInfo.removeChild(ticketDetailsToRemove);

                    totalPriceSelectedDisplay.textContent = `Total price: ${totalPriceSelected}`;
                }
                searchShow(data);
            })
            .catch(error => {
                console.error('Error:', error);
            });
}

function formatDate(dateString) {
    const date = new Date(dateString);
    const year = date.getFullYear();
    let month = (date.getMonth() + 1).toString();
    let day = date.getDate().toString();

    if (month.length < 2) {
        month = '0' + month;
    }
    if (day.length < 2) {
        day = '0' + day;
    }
    return `${year}-${month}-${day}`;
}

function searchShow(data) {
    dataHandle = data.map((item) => {
        let checked = selectedTickets[item.ticketId] != null ? "checked" : "";
        return `<div class="cart-item">
                        <div class="ticket-info">
                            <div class="image-placeholder">
                                <div class="box-clubname">
                                    <p class="club1">${item.match.club1.clubName}</p>
                                    <p class="divider"></p>
                                    <p class="club2">${item.match.club2.clubName}</p>
                                </div>
                            </div>
                            <div class="ticket-details">
                                <p>Area: ${item.seat.area.areaName}</p>
                                <p>Seat number: ${item.seat.seatNumber}</p>
                                <p>Price: ${item.seat.price}</p>
                                 <p>Date: ${formatDate(item.match.schedule)}</p>
                            </div>
                        </div>
                        <div class="delete-icon">
                            <input type="checkbox" class="ticket-checkbox"
                                   data-price="${item.seat.price}"
                                   data-area="${item.seat.area.areaName}"
                                   data-seat="${item.seat.seatNumber}"
                                    data-date="${item.match.schedule}"
                                   value="${item.ticketId}"
                                   onClick="handleChoose(this)"
                                   ${checked}
                                   >
                            <span onClick="deleteTicket(${item.ticketId}, ${item.cartId})"><i class="fas fa-trash"></i></span>
                        </div>
                    </div>`;
    });
    if (data.length == 0) {
        document.querySelector(".cart-items").innerHTML = `
        <div class="cart-item">
                        <div class="ticket-info">
        <p>No have ticket found</p>
        <div class="ticket-details">
        </div>
                        </div>
        </div>
`;
    } else {
        document.querySelector(".cart-items").innerHTML = dataHandle.join("");
    }
}

function updateSelectedTickets(searchResults) {
    selectedTicketInfo.innerHTML = '';
    totalPriceSelected = 0;
    searchResults.forEach(ticket => {
        const ticketId = ticket.ticketId;
        const price = ticket.price;
        const area = ticket.areaName;
        const seat = ticket.seatNumber;
        selectedTickets[ticketId] = {
            price: price,
            area: area,
            seat: seat
        };
        const ticketDetailsDiv = document.createElement('div');
        ticketDetailsDiv.setAttribute('id', `ticket-details-${ticketId}`);
        ticketDetailsDiv.innerHTML = `
                <h4>Detail price ${ticketId}:</h4>
                <p>Area: ${area}</p>
                <p>Seat number: ${seat}</p>
                <p>Price: ${price}</p>
         <input type="hidden" name="tickets" value="${ticketId}" />
            `;
        selectedTicketInfo.appendChild(ticketDetailsDiv);
        totalPriceSelected += price;
    });
    totalPriceSelectedDisplay.textContent = `Total price: ${totalPriceSelected}`;
}

const checkoutCloseBtn = document.getElementById('btn-close-checkout');
const checkoutBox = document.getElementById('checkout-box-background');
const notificationCloseBtn = document.getElementById('btn-close-notification');
const notificationBox = document.getElementById('notification-background');
const buyTicketNotification = document.getElementById('buyticket-notification');

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