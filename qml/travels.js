Qt.include("helpers.js")
var travels

function setTravels(newTravels) {
    travels = newTravels

    for (var b in travels) {
        var travel = travels[b];
        console.log(travel.DepartureTime)
        console.log(travel.ArrivalTime)
        for (var c in travel.TravelStages) {
            var stage = travel.TravelStages[c]
            console.log(stage.DepartureStop.Name)
        }
        var departureTime = parseDate(travel.DepartureTime)
        var arrivalTime = parseDate(travel.ArrivalTime)
        var timeDifference = arrivalTime.getTime() - departureTime.getTime()
        var timeDifferenceMinutes = timeDifference / 60000
        travelModel.append({
                           travelIndex: b,
                           title: Qt.formatDateTime(departureTime, "ddd dd MMM hh:mm") + " - " + Qt.formatDateTime(arrivalTime, "hh:mm"),
                           subtitle: "Travel time: " + timeDifferenceMinutes + " min",
                           departureTime: departureTime,
                           arrivalTime: arrivalTime,
                           travelTime: timeDifferenceMinutes,
                           selected: false});
    }
    travelModel.loadCompleted()
}
