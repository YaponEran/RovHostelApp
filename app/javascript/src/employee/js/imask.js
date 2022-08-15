import IMask from 'imask';


document.addEventListener("turbolinks:load", ()=>{
    // let userMobileField = document.querySelector("[data-phone]")
    let userMobileField = document.getElementById("user_mobile_phone")

    if(userMobileField){
        let maskOptions = {
            mask:'+{7}(000)000-00-00'
        }

        IMask(userMobileField, maskOptions)
    }
})