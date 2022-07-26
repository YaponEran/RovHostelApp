import IMask from 'imask';


document.addEventListener("turbolinks:load", ()=>{
    // let userMobileField = document.querySelector("[data-phone]")
    let userMobileField = document.getElementById("user_mobile_phone")

    let maskOptions = {
        mask:'+{7}(000)000-00-00'
    }

    var mask = IMask(userMobileField, maskOptions)
})