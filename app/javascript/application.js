import { Application } from "@hotwired/stimulus"

const application = Application.start()

// Configure Stimulus development experience
application.debug = false
window.Stimulus   = application

import { Alert } from "tailwindcss-stimulus-components"
import Menu_controller from "./controllers/menu_controller";
application.register('alert', Alert)
application.register('menu', Menu_controller)

export { application }