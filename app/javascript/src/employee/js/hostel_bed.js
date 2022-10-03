document.addEventListener("turbolinks:load", () => {
    let overNightType = document.getElementById("room_overnight_kind")
    let totalRoomCount = document.getElementById("room_total_room")
    let bedNumber = document.querySelector(".bed-number")
 
    overNightType.addEventListener("change", ()=>{
        if(overNightType.value == "Кроватка"){
            totalRoomCount.classList.add("is-hidden")
            document.getElementsByTagName('label')[1].classList.add("is-hidden")
            
            bedNumber.classList.remove("is-hidden")
        }else{
            totalRoomCount.classList.remove("is-hidden")
            document.getElementsByTagName('label')[1].classList.remove("is-hidden")

            bedNumber.classList.add("is-hidden")
        }
    })

    if(overNightType.value == "Кроватка"){
        totalRoomCount.classList.add("is-hidden")
        document.getElementsByTagName('label')[1].classList.add("is-hidden")    
        bedNumber.classList.remove("is-hidden")
    }else{
        totalRoomCount.classList.remove("is-hidden")
        document.getElementsByTagName('label')[1].classList.remove("is-hidden")
        bedNumber.classList.add("is-hidden")
    }
})