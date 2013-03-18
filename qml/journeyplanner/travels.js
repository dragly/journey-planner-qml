Qt.include("helpers.js")
var travels = new Array()

function setTravels(newTravels, travelModel) {
    var a = JSON.parse(newTravels);
    travels = a.GetTravelsByPlacesResult.TravelProposals;
    console.log("Returned " + travels.length + " travel proposals")
    for (var b in travels) {
        var travel = travels[b];
//        console.log(travel)
//        console.log("Lets go!")
//        console.log(travel.DepartureTime)
//        console.log(travel.ArrivalTime)
        for (var c in travel.TravelStages) {
            var stage = travel.TravelStages[c]
//            console.log(stage.DepartureStop.Name)
        }
        var departureTime = parseDate(travel.DepartureTime)
        var arrivalTime = parseDate(travel.ArrivalTime)
        var timeDifference = arrivalTime.getTime() - departureTime.getTime()
        var timeDifferenceMinutes = timeDifference / 60000
        var travelStages = new Array()
        var travelStageTypes = new Array()
        for(var i=0; i<4; i++) {
            if(i < travel.TravelStages.length) {
//                console.log()
//                console.log("Line: " + travel.TravelStages[i].LineName + " Transportation: " + travel.TravelStages[i].Transportation)
                travelStages[i] = travel.TravelStages[i].LineName
                travelStageTypes[i] = travel.TravelStages[i].Transportation
            } else {
                travelStages[i] = ""
                travelStageTypes[i] = ""
            }
        }

        travelModel.append({
                               travelIndex: b,
                               departureTime: departureTime,
                               arrivalTime: arrivalTime,
                               travelTime: timeDifferenceMinutes,
                               travelStage0: travelStages[0],
                               travelStage1: travelStages[1],
                               travelStage2: travelStages[2],
                               travelStage3: travelStages[3],
                               travelStageType0: travelStageTypes[0],
                               travelStageType1: travelStageTypes[1],
                               travelStageType2: travelStageTypes[2],
                               travelStageType3: travelStageTypes[3],
                               travelStages: JSON.stringify(travel.TravelStages),
                               selected: false
                           });
    }
    travelModel.loadCompleted()
}
