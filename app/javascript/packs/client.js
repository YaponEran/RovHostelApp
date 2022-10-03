import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"
import "bulma"

import '../src/client/scss/client.scss'
// import '../src/client/scss/employee_page.scss'
import '../src/client/js/modal_trigger'
import "../src/client/js/imask"

Rails.start()
Turbolinks.start()
ActiveStorage.start()