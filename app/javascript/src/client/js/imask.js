import IMask from 'imask';


document.addEventListener("turbolinks:load", ()=>{
    // let userMobileField = document.querySelector("[data-phone]")
    let userMobileField = document.getElementById("user_mobile_phone")
    let hotelPhoneField = document.getElementById("hotel_phone_number")
    let buildPhoneField = document.getElementById("building_phone_number")

    if(buildPhoneField){
        let maskOptions = {
            mask:'+{7}(000)000-00-00'
        }
        
        IMask(buildPhoneField, maskOptions)
    }

    if(hotelPhoneField){
        let maskOptions = {
            mask:'+{7}(000)000-00-00'
        }
        
        IMask(hotelPhoneField, maskOptions)
    }

    if(userMobileField){
        let maskOptions = {
            mask:'+{7}(000)000-00-00'
        }

        IMask(userMobileField, maskOptions)
    }
})