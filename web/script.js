window.addEventListener("message", function (event) {
    let data = event.data

    if (data.hudstatus === false) {
        $('.container').fadeOut();
    } else {
        document.getElementById('kills').textContent = data.plykills;
        document.getElementById('deaths').textContent = data.plydeaths;
        document.getElementById('kd').textContent = data.plykd;
        document.getElementById('league').textContent = data.plyleague;
    }
})