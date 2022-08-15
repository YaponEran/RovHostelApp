import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"
import "bulma"

import '../src/employee/scss/employee.scss'
import '../src/employee/scss/employee_page.scss'
import '../src/employee/js/modal_trigger'
import "../src/employee/js/imask"

Rails.start()
Turbolinks.start()
ActiveStorage.start()